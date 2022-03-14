//
//  AdjacencyListGraph.scala
//  scala-solutions
//
//  Created by d-exclaimation on 10:46 AM.
//


package graph

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
) extends Graph {

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
}
