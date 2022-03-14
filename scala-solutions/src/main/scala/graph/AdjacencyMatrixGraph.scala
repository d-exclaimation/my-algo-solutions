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
  private val matrix: IndexedSeq[IndexedSeq[Option[Int]]] = IndexedSeq.empty
) extends Graph {
  def isEdge(from: Int, to: Int): Boolean =
    if (from < 0 || from >= n || to < 0 || to >= n) false
    else matrix(from)(to).isDefined

  def edges: Seq[(Int, Int)] =
    val directed = matrix
      .zipWithIndex
      .flatMap { case (vertices, i) => vertices
        .zipWithIndex
        .filter(_._1.isDefined)
        .map(tup => (i, tup._2)) 
      }

    if (isDirected) directed
    else {
      directed
        .map { case (i, j) => if (i < j) (i, j) else (j, i) }
        .toSet
        .toSeq
    }

  def isWeighted: Boolean =
    matrix.exists(_.exists {
      case Some(value) if value > 0 => true
      case _ => false
    }
    )

  def edge(from: Int): Seq[(Int, Option[Int])] =
    if (from < 0 || from >= n) Seq.empty
    else matrix(from).zipWithIndex.flatMap {
      case (Some(0), i) => Some((i, None))
      case (Some(weight), i) => Some((i, Some(weight)))
      case _ => None
    }


  def dfs(start: Int): Seq[Option[Int]] = {
    val parent = mutable.ArrayBuffer.fill[Option[Int]](n)(None)
    val state = mutable.ArrayBuffer.fill(n)("U")
    state(start) = "D"

    dfsLoop(start, state, parent)

    parent.toIndexedSeq
  }

  private def dfsLoop(u: Int, state: mutable.ArrayBuffer[String], parent: mutable.ArrayBuffer[Option[Int]]): Unit = {
    for ((v, _) <- edge(u)) {
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
  type AdjacentMatrix = IndexedSeq[IndexedSeq[Option[Int]]]
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
        foldLeft(IndexedSeq.fill(n)(IndexedSeq.fill[Option[Int]](n)(None))) {
          case (matrix, (i, j)) =>
            matrix.zipWithIndex.map {
              case (row, `i`) => row.zipWithIndex.map {
                case (_, `j`) => Some(0)
                case (prev, _) => prev
              }
              case (row, `j`) => row.zipWithIndex.map {
                case (prev, `i`) => if (!isDirected) Some(0) else prev
                case (prev, _) => prev
              }
              case (row, _) => row
            }
        }
      new AdjacencyMatrixGraph(n, isDirected, matrix)
    }
  }
}