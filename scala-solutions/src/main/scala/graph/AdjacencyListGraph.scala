//
//  AdjacencyListGraph.scala
//  scala-solutions
//
//  Created by d-exclaimation on 10:46 AM.
//


package graph

import graph.AdjacencyListGraph.nextVertex
import utils.not

import scala.annotation.tailrec
import scala.collection.immutable.{AbstractSeq, LinearSeq, Queue}
import scala.collection.mutable
import scala.util.control.NonFatal

/**
 * Adjacency List representing a Graph with vertices denoted in integers.
 *
 * @param n    Amount of vertices.
 * @param list The list itself.
 */
case class AdjacencyListGraph(
  n: Int,
  list: IndexedSeq[Seq[(Int, Option[Int])]]
) {

  /**
   * Check if these two vertices have an edge
   *
   * @param from Starting vertex
   * @param to   Ending vertex
   * @return A boolean showing that an edge exists
   */
  def isEdge(from: Int, to: Int): Boolean =
    if (from < 0 || from >= n || to < 0 || to >= n) false
    else list.apply(from).exists(_._1 == to)


  /**
   * Find all edges from a vertex
   *
   * @param from Starting vertex
   * @return A sequence of all edges in vertex, weight pair
   */
  def edge(from: Int): Seq[(Int, Option[Int])] =
    if (from < 0 || from >= n) Seq.empty
    else list.apply(from)

  /**
   * Whether this Graph have a weight on every edges.
   *
   * @return A boolean showing that it is weighted
   */
  def isWeighted: Boolean = list
    // Find a vertex with edges
    .filter(_.nonEmpty)
    // Find a edge that have a weight
    .exists(_.exists(_._2.nonEmpty))

  /**
   * Whether this Graph's edges are directed or not
   *
   * @return A boolean showing the result
   */
  def isDirected: Boolean = list
    .zipWithIndex
    // Find a vertex with edges
    .filter(_._1.nonEmpty)
    // Figure out if the head edge, exist backwards
    .exists {
      case ((to, weight) +: remains, i) => list(to)
        .exists {
          case (o, otherWeight) => o == i && otherWeight == weight
        }
    }
    .not

  def topologicalOrdering: Seq[Int] = {
    val state = mutable.ArrayBuffer.fill[String](n){ "U" }
    val parent = mutable.ArrayBuffer.fill[Option[Int]](n) { None }
    val stack = mutable.Stack.empty[Int]

    for (u <- 0 until n) {
      if (state(u) == "U") {
        topologicalDfsLoop(u, state, parent, stack)
      }
    }

    stack.popAll().toSeq
  }

  private def topologicalDfsLoop(
    u: Int,
    state: mutable.ArrayBuffer[String],
    parent: mutable.ArrayBuffer[Option[Int]],
    stack: mutable.Stack[Int]
  ): Unit = {
    edge(u).foreach { case (v, _) =>
      if (state(v) == "U") {
        state.update(v, "D")
        parent(v) = Some(u)
        topologicalDfsLoop(v, state, parent, stack)
      }
    }
    state.update(u, "P")
    stack.push(u)
  }

  def transposed: AdjacencyListGraph =
    if (isDirected.not) new AdjacencyListGraph(n, list)
    else {
      val mapped = list.zipWithIndex
        .foldLeft(Map.empty[Int, Seq[(Int, Option[Int])]]) {
          case (acc, (edges, from)) =>
            edges.foldLeft(acc) {
              case (m, (to, weight)) => m.updated(to, m
                .getOrElse(to, Seq.empty)
                .appended((from, weight))
              )
            }
        }

      new AdjacencyListGraph(n,
        list = (0 until n).map(mapped.getOrElse(_, Seq.empty))
      )
    }

  def isHub(vertex: Int): Boolean =
    if (vertex < 0 || vertex >= n) false
    else {
      val (state, _) = bfsOuterLoop(Queue.apply(vertex), Map.empty, Map.empty)
      if ((0 until n).map(state.getOrElse(_, "U")).contains("U")) false
      else {
        val tran = transposed
        val (state2, _) = tran.bfsOuterLoop(Queue.apply(vertex), Map.empty, Map.empty)
        (0 until n).map(state2.getOrElse(_, "U")).contains("U").not
      }
    }

  def hubs: Seq[Int] = list.indices.filter(isHub)

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
  private def bfsOuterLoop(
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
  private def bfsInnerLoop(
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
  private def shortWalk(
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


  override def toString: String =
    s"<#AdjacencyListGraph(n: $n, edges:" + "\n" + list.zipWithIndex.map {
      case (value, i) => s"  $i -> {${
        value
          .map(edge => edge._2
            .map(weight => s"(${edge._1}, $weight)")
            .getOrElse(s"${edge._1}")
          )
          .mkString(", ")
      }}"
    }.mkString("\n") + "\n)>"


  def prim(start: Int): (IndexedSeq[Option[Int]], IndexedSeq[Int]) = {
    if (isWeighted.not || isDirected) return (IndexedSeq.empty, IndexedSeq.empty);

    val inTree = mutable.ArrayBuffer.fill[Boolean](n)(false)
    val distance = mutable.ArrayBuffer.fill[Int](n)(Int.MaxValue)
    val parent = mutable.ArrayBuffer.fill[Option[Int]](n)(None)

    distance.update(start, 0)

    while (inTree.exists(_.not)) {
      val (u, _) = nextVertex(inTree, distance)

      inTree.update(u, true)

      for ((v, Some(weight)) <- edge(u).filter{ case (v, weight) => inTree(v).not && weight.exists(_ < distance(v)) }) {
        distance.update(v, weight)
        parent.update(v, Some(u))
      }
    }

    (parent.toIndexedSeq, distance.toIndexedSeq)
  }

  def dijkstra(start: Int): (IndexedSeq[Option[Int]], IndexedSeq[Int]) = {
    if (isWeighted.not || isDirected) return (IndexedSeq.fill(n)(None), IndexedSeq.fill(n)(-1));

    val distance = mutable.ArrayBuffer.fill[Int](n)(Int.MaxValue)
    val inTree = mutable.ArrayBuffer.fill[Boolean](n)(false)
    val parent = mutable.ArrayBuffer.fill[Option[Int]](n)(None)

    distance.update(start, 0)

    while (inTree.exists(_.not)) {
      val (u, _) = nextVertex(inTree, distance)
      inTree.update(u, true)

      for ((v, Some(weight)) <- edge(u)) {
        if (inTree(v).not && distance(u) + weight < distance(v)) {
          distance.update(v, distance(u) + weight)
          parent.update(v, Some(u))
        }
      }
    }

    (parent.toIndexedSeq, distance.toIndexedSeq)
  }

}

object AdjacencyListGraph {
  def apply(graphString: String): AdjacencyListGraph = {
    val (edges, isWeighted, isUndirected, n) = parse(graphString)
    val res = edges.foldLeft(Map.empty[Int, Seq[(Int, Option[Int])]]) {
      case (acc, (start, end, weight)) =>
        val res = acc.updated(start, acc.getOrElse(start, Seq.empty) :+ (end, weight))
        if (!isUndirected) res
        else res.updated(end, acc.getOrElse(end, Seq.empty) :+ (start, weight))
    }

    new AdjacencyListGraph(
      n = n,
      list = (0 until n).map(res.getOrElse(_, Seq.empty))
    )
  }

  def nextVertex(inTree: mutable.ArrayBuffer[Boolean], distance: mutable.ArrayBuffer[Int]): (Int, Int) = inTree
    .zipWithIndex
    .filter(_._1.not)
    .map(_._2)
    .map(i => (i, distance.apply(i)))
    .minBy(_._2)
}
