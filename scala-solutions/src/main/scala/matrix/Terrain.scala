//
//  Terrain.scala
//  scala-solutions
//
//  Created by d-exclaimation on 11:34.
//

package matrix

import scala.collection.mutable

object Terrain {
  extension[T] (any: T) {
    def some: Option[T] = Some(any)
  }

  extension[T] (opt: Option[T]) {
    def pretty: String = opt match {
      case Some(value) => value.toString
      case None => "-"
    }
  }

  extension[T] (matrix: IndexedSeq[IndexedSeq[T]]) {
    def pretty: String =
      s"[${matrix.map(_.map(_.toString).mkString(", ")).map("[" + _ + "]").mkString(",\n ")}]"
  }


  final class MinCostPath(
    private val grid: IndexedSeq[IndexedSeq[Int]]
  ) {
    private val cache = IndexedSeq.fill(grid.length) {
      mutable.IndexedSeq.fill[Option[(Int, Option[Int])]](grid.headOption.map(_.length).getOrElse(0))(None)
    }

    def cost(row: Int, col: Int): Int =
      costAndParent(row, col)._1

    def costAndParent(row: Int, col: Int): (Int, Option[Int]) =
      if (isOutOfBound(row, col)) (Int.MaxValue, None)
      else if (row == 0) (weight(row, col), None)
      else cache(row)(col) match {
        case Some((value, parent)) => (value, parent)
        case None =>
          val (predecessor, parent) = Seq(-1, 0, 1).map(col + _).map(c => (cost(row - 1, c), Some(c))).minBy(_._1)
          val answer = predecessor + weight(row, col)
          cache(row).update(col, (answer, parent).some)
          (answer, parent)
      }

    def weight(row: Int, col: Int): Int = grid(row)(col)

    def isOutOfBound(row: Int, col: Int): Boolean = row < 0 || row >= grid.length || col < 0 || col >= grid(row).length

    def cost: Int =
      grid(grid.length - 1).indices.map(cost(grid.length - 1, _)).min

    def costGrid: IndexedSeq[IndexedSeq[Int]] =
      grid.zipWithIndex.map { case (row, i) => row.indices.map(cost(i, _)) }

    def costAndPathGrid: IndexedSeq[IndexedSeq[(Int, Option[Int])]] =
      grid.zipWithIndex.map { case (row, i) => row.indices.map(costAndParent(i, _)) }
  }

  object MinCostPath {
    def apply(grid: IndexedSeq[IndexedSeq[Int]]): MinCostPath =
      if (grid.map(_.length).forall(_ == grid.headOption.map(_.length).getOrElse(0))) new MinCostPath(grid)
      else throw Exception("Invalid grid")
  }
}
