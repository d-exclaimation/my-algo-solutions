//
//  Graph.scala
//  scala-solutions
//
//  Created by d-exclaimation on 9:45 AM.
//


package graph

import graph.Graph.edgesFor
import utils.not

import scala.annotation.tailrec
import scala.collection.immutable.Queue
import scala.collection.mutable

trait Graph {
  def n: Int

  def edge(from: Int): Seq[(Int, Option[Int])]

  def isWeighted: Boolean

  def isDirected: Boolean


  /**
   * Find a sequence that follow the topological ordering, where
   * given aa vertex u and its edge (u, v), u is always before v
   *
   * @return A sequence following the ruleset
   */
  def topologicalOrdering: Seq[Int] = {
    val staringStates = (Map.empty[Int, String], Map.empty[Int, Option[Int]], Vector.empty[Int])

    val (_, _, stack) = (0 until n)
      .foldLeft(staringStates) {
        case ((state, parent, stack), u) =>
          if (state.getOrElse(u, "U") == "U") topologicalDfsRec(u, state, parent, stack)
          else (state, parent, stack)
      }

    stack.reverse
  }

  private def topologicalDfsRec(
    u: Int,
    state: Map[Int, String],
    parent: Map[Int, Option[Int]],
    stack: Vector[Int]
  ): (Map[Int, String], Map[Int, Option[Int]], Vector[Int]) = {
    val (newState, newParent, newStack) = edge(u)
      .foldLeft((state, parent, stack)) {
        case ((currState, currParent, currStack), (v, _)) if state.getOrElse(v, "U") == "U" =>
          topologicalDfsRec(v,
            currState.updated(v, "D"),
            currParent.updated(v, Some(u)),
            currStack
          )
        case (states, _) => states
      }

    (newState.updated(u, "P"), newParent, newStack.appended(u))
  }


  /**
   * Breath first search to find the parent tree from a starting vertex
   *
   * @param start Staring vertex
   * @return A parent tree in form of a sequence where the value is the parent of the vertex of that index.
   */
  def bfs(start: Int): IndexedSeq[Option[Int]] =
    val (_, mapped) = bfsOuterLoop(
      Queue.apply(start),
      Map.empty,
      Map.empty
    )
    (0 until n).map(mapped.get)

  @tailrec
  protected final def bfsOuterLoop(
    queue: Queue[Int],
    state: Map[Int, String],
    parent: Map[Int, Int]
  ): (Map[Int, String], Map[Int, Int]) =
    if (queue.isEmpty) (state, parent)
    else {
      val (curr, newQueue) = queue.dequeue
      val (latestQueue, newState, newParent) = bfsInnerLoop(curr, edge(curr), newQueue, state, parent)
      bfsOuterLoop(latestQueue, newState.updated(curr, "P"), newParent)
    }

  @tailrec
  protected final def bfsInnerLoop(
    curr: Int,
    edges: Seq[(Int, Option[Int])],
    queue: Queue[Int],
    state: Map[Int, String],
    parent: Map[Int, Int]
  ): (Queue[Int], Map[Int, String], Map[Int, Int]) =
    if (edges.isEmpty) (queue, state, parent)
    else {
      val (v, _) +: remains = edges
      val isUndiscovered = state.getOrElse(v, "U") == "U"

      bfsInnerLoop(curr, remains,
        if (isUndiscovered) queue.enqueue(v) else queue,
        if (isUndiscovered) state.updated(v, "D") else state,
        if (isUndiscovered) parent.updated(v, curr) else parent
      )
    }


  /**
   * Finding the shortest path from a vertex to another
   *
   * @param from Staring vertex
   * @param to   Ending vertex
   * @return A sequence showing the path `from` -> `to` or None if path doesn't exist
   */
  def shortestPath(from: Int, to: Int): Option[Seq[Int]] =
    if (from < 0 || from >= n || to < 0 || to >= n) None
    else if (isWeighted) shortWalk(dijkstra(from)._1, from, to)
    else shortWalk(bfs(from), from, to)

  @tailrec
  protected final def shortWalk(
    parent: IndexedSeq[Option[Int]],
    from: Int,
    to: Int,
    carry: Seq[Int] = Seq.empty
  ): Option[Seq[Int]] =
    if (from == to) Some(from +: carry)
    else parent.applyOrElse(to, _ => None) match {
      case None => None
      case Some(value) => shortWalk(parent, from, value, to +: carry)
    }


  /**
   * Spanning tree algorithm construct a parent tree and its corresponding weights based on
   * certain criteria describe in the algorithm given as parameter.
   *
   * @param start     Starting vertex of these algorithm.
   * @param algorithm The criteria algorithm used to dictate the decision in contructing the tree
   * @return A spanning tree described in a parent tree and its weight sequence.
   */
  private def spanningTree(start: Int)(
    algorithm: (Int, Int, Int, mutable.ArrayBuffer[Int]) => (Boolean, Int)
  ): (IndexedSeq[Option[Int]], IndexedSeq[Int]) = {
    if (isWeighted.not) return (IndexedSeq.fill(n)(None), IndexedSeq.fill(n)(-1))

    val distance = mutable.ArrayBuffer.fill[Int](n)(Int.MaxValue)
    val inTree = mutable.ArrayBuffer.fill[Boolean](n)(false)
    val parent = mutable.ArrayBuffer.fill[Option[Int]](n)(None)

    distance.update(start, 0)

    while (inTree.exists(_.not)) {
      val (u, _) = Graph.nextVertex(inTree, distance)
      inTree.update(u, true)

      for ((v, Some(weight)) <- edge(u)) {
        val (valid, res) = algorithm(u, v, weight, distance)
        if (inTree(v).not && valid) {
          distance.update(v, res)
          parent.update(v, Some(u))
        }
      }
    }

    (parent.toIndexedSeq, distance.toIndexedSeq)
  }

  /**
   * Prim algorithm to find minimum spanning tree (min total weight)
   *
   * @param start Starting vertex
   * @return a tuple of parent tree and the distance for each vertex
   */
  def prim(start: Int): (IndexedSeq[Option[Int]], IndexedSeq[Int]) =
    spanningTree(start) {
      case (_, v, weight, distances) if weight < distances(v) => (true, weight)
      case _ => (false, Int.MaxValue)
    }


  /**
   * Dijkstra algorithm to find the shortest spanning tree from a vertex (min weight from `start` vertex)
   *
   * @param start Starting vertex
   * @return a tuple of parent tree and the distance for each vertex to `start`
   */
  def dijkstra(start: Int): (IndexedSeq[Option[Int]], IndexedSeq[Int]) =
    spanningTree(start) {
      case (u, v, weight, distances) if distances(u) + weight < distances(v) => (true, distances(v) + weight)
      case _ => (false, Int.MaxValue)
    }

  def d(i: Int, j: Int, k: Int): Int =
    if (k <= -1) {
      if (i == j) 0
      else edge(i).find(_._1 == j).map(_._2.getOrElse(0)).getOrElse(Int.MaxValue)
    }
    else {
      val ik = d(i, k, k - 1)
      val kj = d(k, j, k - 1)
      val ij = if (ik == Int.MaxValue || kj == Int.MaxValue) Int.MaxValue else ik + kj
      scala.math.min(ij, d(i, j, k - 1))
    }

  def immediateDistances: (IndexedSeq[mutable.ArrayBuffer[Int]], IndexedSeq[mutable.ArrayBuffer[Option[Int]]]) = {
    val distances = (0 until n)
      .map(_ => mutable.ArrayBuffer.fill(n)(Int.MaxValue))
    val parent = (0 until n)
      .map(_ => mutable.ArrayBuffer.fill[Option[Int]](n)(None))

    for (i <- 0 until n) {
      for ((j, weight) <- edge(i)) {
        distances(i).update(j, weight.getOrElse(0))
        parent(i).update(j, Some(i))
      }
    }
    (distances, parent)
  }

  def floyd: (IndexedSeq[mutable.ArrayBuffer[Int]], IndexedSeq[mutable.ArrayBuffer[Option[Int]]]) = {
    val (distances, parent) = immediateDistances
    for (k <- 0 until n) {
      for (i <- 0 until n) {
        for (j <- 0 until n) {
          val ik = distances(i)(k)
          val kj = distances(k)(j)
          val ij = if (ik == Int.MaxValue || kj == Int.MaxValue) Int.MaxValue else ik + kj
          if (distances(i)(j) > ij) {
            distances(i).update(j, ij)
            parent(i).update(j, parent(k)(j))
          }
        }
      }
    }
    (distances, parent)
  }

  def degree(u: Int): Int =
    if (u < 0 || u >= n) 0
    else edge(u).length
}

object Graph {
  protected final def nextVertex(
    inTree: mutable.ArrayBuffer[Boolean], distance: mutable.ArrayBuffer[Int]
  ): (Int, Int) = inTree
    .zipWithIndex
    .filterNot(_._1)
    .map(_._2)
    .map(i => (i, distance.apply(i)))
    .minBy(_._2)


  def edgesFor(
    algorithm: Int => (IndexedSeq[Option[Int]], IndexedSeq[Int]),
    start: Int
  ): Seq[(Int, Int, Int)] = {
    val (parent, distances) = algorithm(start)
    parent.zipWithIndex
      .flatMap { 
        case (Some(v), u) => Some(
            if (u <= v) (u, v, distances(u))
            else (v, u, distances(u))
        )
        case _ => None
      }
  }
}