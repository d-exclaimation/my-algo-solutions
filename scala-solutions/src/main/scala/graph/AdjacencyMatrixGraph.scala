//
//  AdjacencyMatrixGraph.scala
//  scala-solutions
//
//  Created by d-exclaimation on 4:07 PM.
//


package graph

import scala.annotation.tailrec
import scala.collection.mutable

class AdjacencyMatrixGraph(
  val n: Int,
  val isDirected: Boolean = false,
  private val matrix: IndexedSeq[IndexedSeq[Boolean]] = IndexedSeq.empty
) {
  def isEdge(from: Int, to: Int): Boolean =
    if (from < 0 || from >= n || to < 0 || to >= n) false
    else matrix(from)(to)

  def edges: Seq[(Int, Int)] =
    val directed = matrix
      .zipWithIndex
      .flatMap { case (vertices, i) => vertices.zipWithIndex.filter(_._1).map(tup => (i, tup._2)) }

    if (isDirected) directed
    else {
      directed
        .map { case (i, j) => if (i < j) (i, j) else (j, i) }
        .toSet
        .toSeq
    }

  def edges(from: Int): IndexedSeq[Int] =
    if (from < 0 || from >= n) IndexedSeq.empty
    else matrix(from).zipWithIndex.flatMap {
      case (true, i) => Some(i)
      case _ => None
    }

  def bfs(start: Int): Seq[Option[Int]] = {
    val state = mutable.ArrayBuffer.fill(n)("U")
    val parent = mutable.ArrayBuffer.fill[Option[Int]](n)(None)
    val queue = mutable.ArrayDeque.empty[Int]

    state(start) = "D"
    queue.append(start)

    while (queue.nonEmpty) {
      val u = queue.removeHead()
      for (v: Int <- edges(u)) {
        if (state(v) == "U") {
          state(v) = "D"
          parent(v) = Some(u)
          queue.append(v)
        }
      }
      state(u) = "P"
    }

    parent.toIndexedSeq
  }


  def dfs(start: Int): Seq[Option[Int]] = {
    val parent = mutable.ArrayBuffer.fill[Option[Int]](n)(None)
    val state = mutable.ArrayBuffer.fill(n)("U")
    state(start) = "D"

    dfsLoop(start, state, parent)

    parent.toIndexedSeq
  }

  private def dfsLoop(u: Int, state: mutable.ArrayBuffer[String], parent: mutable.ArrayBuffer[Option[Int]]): Unit = {
    for (v: Int <- edges(u)) {
      if (state(v) == "U") {
        state(v) = "D"
        parent(v) = Some(u)
        dfsLoop(v, state, parent)
      }
    }
    state(u) = "P"
  }
}

object AdjacencyMatrixGraph {
  type AdjacentMatrix = IndexedSeq[IndexedSeq[Boolean]]
  type ParentTree = Seq[Option[Int]]

  def apply(n: Int, isDirected: Boolean = false, matrix: AdjacentMatrix): AdjacencyMatrixGraph =
    new AdjacencyMatrixGraph(n, isDirected, matrix)

  def apply(text: String): AdjacencyMatrixGraph = {
    val lines = text
      .split('\n')
      .toSeq
      .map(_.split(' ').toSeq)

    val isDirected = lines.head.head.toUpperCase == "D"
    val n = lines.head(1).toIntOption.getOrElse(0)
    val edges = lines
      .slice(1, lines.length)
      .flatMap {
        case Seq(from, to) => (from.toIntOption, to.toIntOption) match {
          case (Some(f), Some(t)) => Some(f, t)
          case _ => None
        }
        case _ => None
      }
      .filter { case (i, j) => i >= 0 && i < n && j >= 0 && j < n }


    if (n == 0)
      new AdjacencyMatrixGraph(n, isDirected)
    else {
      val matrix = edges.
        foldLeft(IndexedSeq.fill(n)(IndexedSeq.fill(n)(false))) {
          case (matrix, (i, j)) =>
            matrix.zipWithIndex.map {
              case (row, `i`) => row.zipWithIndex.map {
                case (_, `j`) => true
                case (prev, _) => prev
              }
              case (row, `j`) => row.zipWithIndex.map {
                case (prev, `i`) => if (!isDirected) true else prev
                case (prev, _) => prev
              }
              case (row, _) => row
            }
        }
      new AdjacencyMatrixGraph(n, isDirected, matrix)
    }
  }

  @tailrec
  def shortestPath(parentTree: ParentTree, from: Int, to: Int, carry: Seq[Int] = Seq.empty): Seq[Int] =
    if (from == to) from +: carry
    else {
      parentTree.applyOrElse(to, _ => None) match {
        case None => carry
        case Some(value) => shortestPath(parentTree, from, value, to +: carry)
      }
    }
}