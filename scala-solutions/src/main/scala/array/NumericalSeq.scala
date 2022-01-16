//
//  Sequence.scala
//  Scala-Solutions
//
//  Created by d-exclaimation on 12:31 PM.
//

package array

import option.*

object NumericalSeq {

  extension (iter: Iterable[Int]) {

    /** Check whether numerical sequence is in increasing order
     *
     * '''Complexity''':
     *
     * Time: ''O(n)'' | Space: ''O(1)''
     *
     * @return
     * Boolean whether it's increasing
     */
    def isIncreasing: Boolean = {
      val (_, res) = iter.foldLeft((0, true)) { (acc, x) =>
        val (prev, res) = acc
        (x, res && prev <= x)
      }
      res
    }
  }

  /** Up, Up and Away
   *
   * Check if possible to change one value to make it all increasing order
   *
   * @param arr
   * List of Integers.
   * @return
   * Boolean whether it is possible.
   */
  def upUpAndAway(arr: Vector[Int]): Boolean =
    arr.indices
      .count { i =>
        val curr = arr(i)
        val before = if (i > 0) arr(i - 1) else arr(i)
        val next = if (i < arr.length - 1) arr(i + 1) else arr(i)
        before <= curr && curr <= next
      } == 1

  def discountedPrice(vec: Vector[Int]): Vector[Int] = {
    vec.indices
      .map { i =>
        val discount = vec.indices
          .slice(i + 1, vec.length)
          .find(j => vec(j) <= vec(i))
          .?>(vec(_))
        vec(i) - (discount ?? 0)
      }.toVector
  }


  def missingKth(seq: Seq[Int], k: Int): Int = {
    var i = 0
    var stack = List[Int]()
    var j = 1
    while (i < seq.length && stack.length < k) {
      var curr = seq(i)
      while (j < curr && stack.length < k) {
        stack = j +: stack
        j += 1
      }
      i += 1
      j += 1
    }
    if (stack.isEmpty) seq.last else stack.head
  }

  def weirdSort(nums1: Seq[Int], nums2: Seq[Int]): Seq[Int] = {
    val set: Set[Int] = Set(nums2: _*)
    val other = nums1.filter(!set.contains(_)).sorted
    val owned = nums1
      .filter(set.contains(_))
      .sortWith { (lhs, rhs) =>
        nums2.indexOf(lhs) < nums2.indexOf(rhs)
      }

    owned ++ other
  }

  def isRotatedFromSorted(nums: Seq[Int], count: Int = 0): Boolean = {
    if (nums.isIncreasing) true
    else if (count == nums.length) false
    else isRotatedFromSorted(nums.tail :+ nums.head, count + 1)
  }
}