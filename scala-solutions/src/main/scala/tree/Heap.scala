//
//  Heap.scala
//  scala-solutions
//
//  Created by d-exclaimation on 8:22 PM.
//

package tree

/**
 * Heap Data Structure of N-Branch size and resolver function that handle priority.
 *
 * @param data       Initial data if necessary (Have to be valid)
 * @param resolver   Resolving priorities, return true if first is higher in priority.
 * @param childCount Child Node count.
 * @tparam T Any type to be hold and comparable by resolver.
 */
class Heap[T](
  private val resolver: (T, T) => Boolean,
  private val childCount: Int = 2,
) {
  private var data: Vector[T] = Vector()

  /**
   * Heapify yeah
   *
   * @param data Data Vector to be heapify, cause i like Vector (log(n) operations)
   */
  def heapify(data: Vector[T]): Unit = {
    this.data = data
    parentIndex(this.data.length - 1) match {
      case Some(parent) => {
        for (i <- (0 to parent).reverse) {
          siftDown(i)
        }
      }
      case _ => {}
    }
  }

  /**
   * Sift Up if necessary, given the resolver return true for child against the parent
   *
   * @param idx Index of the child.
   */
  private def siftUp(idx: Int): Unit = parentIndex(idx) match {
    case Some(parent) => {
      // If the parent loses priority to the child, perform swap and recursive
      if (resolver(data(idx), data(parent))) {
        swap(idx, parent)
        siftUp(parent)
      }
    }
    // Do nothing, if no parent
    case _ => {}
  }

  /**
   * Sift down if necessary, given the resolver return true for highest priority child against the parent given
   *
   * @param idx Parent index.
   */
  private def siftDown(idx: Int): Unit = highChildIndex(childrenIndices(idx)) match {
    case Some(minChild) => {
      // High priority child has higher priority than parent, perform swap
      if (resolver(data(minChild), data(idx))) {
        swap(minChild, idx)
        siftDown(minChild)
      }
    }
    case _ => {}
  }

  /**
   * Find the indicies of children given index of parent (Always valid)
   *
   * @param idx Index of parent.
   * @return Seq[Int] of valid child indices
   */
  private def childrenIndices(idx: Int): Seq[Int] = {
    if (childCount <= 1) {
      return List(idx + 1)
    }
    val p = idx + 1
    val indices = (p * childCount + 1) +: (0 to childCount - 1).map(p * childCount - _)
    return indices.map(_ - 1).filter(_ < data.length).filter(_ > 0)
  }

  /**
   * Return the highest priority child
   *
   * @param children Children indices.
   * @return Int if any, None if Seq is empty
   */
  private def highChildIndex(children: Seq[Int]): Option[Int] = {
    if (children.length <= 0) {
      return None
    }
    Some(children.reduce((min, i) => if (resolver(data(i), data(min))) i else min))
  }

  /**
   * Find index of parent given Index of child
   *
   * @param idx The index of the child.
   * @return Option[Int] of parent index, None if no parent / child is root node
   */
  private def parentIndex(idx: Int): Option[Int] = {
    if (idx <= 0) {
      return None
    }
    if (childCount == 1) {
      return Some(idx - 1)
    }
    val curr = idx + 1
    val offset = childCount - 2
    return Some((curr + offset) / childCount - 1)
  }

  /** Swap function */
  private def swap(i: Int, j: Int): Unit = {
    data = data.updated(i, data(j)).updated(j, data(i))
  }

  /**
   * Push a new value into the heap
   *
   * @param value of T.
   */
  def push(value: T): Unit = {
    data = data :+ value
    siftUp(data.length - 1)
  }

  def <<(value: T): Heap[T] = {
    push(value)
    this
  }

  /**
   * Push a new value into the heap and return the heap
   *
   * @param value of T.
   */
  def pushed(value: T): Heap[T] = {
    push(value)
    this
  }

  /**
   * Pop the highest priority value based on resolver
   *
   * @return T with highest priority.
   */
  def pop(): Option[T] = {
    if (data.length <= 0) {
      return None
    }
    val grabbed = Some(data(0))
    if (data.length == 1) {
      data = Vector()
      return grabbed
    }
    data = data.updated(0, data.last).slice(0, data.length - 1)
    siftDown(0)
    return grabbed
  }

  def peek: Option[T] = if (data.length <= 0) None else Some(data(0))
}


object Heap {
  /**
   * Heapify vector and return a new heap
   *
   * @param data       Data vector.
   * @param resolver   Resolving priorities, return true if first is higher in priority.
   * @param childCount Child Node count.
   * @tparam T Any type to be hold and comparable by resolver.
   * @return A new Heapified heap
   */
  def make[T](data: Vector[T], resolver: (T, T) => Boolean, childCount: Int = 2): Heap[T] = {
    var heap = new Heap[T](resolver, childCount)
    heap.heapify(data)
    return heap
  }
}