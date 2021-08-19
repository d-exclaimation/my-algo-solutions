//
//  Uncertainty.scala
//  scala-solutions
//
//  Created by d-exclaimation on 9:17 AM.
//

package math.decision

import async.StructuredConcurrency.*

import scala.concurrent.Future

object Uncertainty {
  def maximin(table: Seq[(String, Seq[Double])]): Future[(String, Double)] = async {
    val minIdx = await(futureIndex(table, _ <= _)) getOrElse 0
    table
      .map { case (label, seq) => (label, seq(minIdx)) }
      .reduce { case ((lhs, lval), (rhs, rval)) => if (lval >= rval) (lhs, lval) else (rhs, rval) }
  }

  private def futureIndex(
    table: Seq[(String, Seq[Double])],
    order: (Double, Double) => Boolean
  ): Future[Int] = async {
    val (_, firstRow) = table(0)

    val (res, _) = firstRow
      .indices
      .map(i => (i, firstRow(i)))
      .reduce { case ((i, acc), (j, curr)) => if (order(acc, curr)) (i, acc) else (j, curr) }

    res
  }
}
