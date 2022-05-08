//
//  IncreasingSubsequence.scala
//  scala-solutions
//
//  Created by d-exclaimation on 16:27.
//

package array

import scala.annotation.tailrec

object IncreasingSubsequence {
  def longestRecurrence(seq: Seq[Int]): Seq[Int] = {
    @tailrec
    def recurrence(i: Int, res: Seq[(Int, Int)] = Seq.fill(seq.length + 1)((1, -1))): Seq[(Int, Int)] = {
      if (i > seq.length) res
      else {
        val next =
          if (i == 1) res.updated(i, (1, - 1))
          else {
            val predecessor = (1 until i).filter(j => seq(j - 1) < seq(i - 1)).maxBy(res.apply)
            res.updated(i, (1 + res(predecessor - 1)._1, predecessor))
          }
        recurrence(i + 1, next)
      }
    }

    val cache = recurrence(1)
    val l = cache.zipWithIndex.maxBy(_._1._1)._2

    @tailrec
    def reconstruct(i: Int, res: Seq[Int] = Seq.empty): Seq[Int] = {
      if (i <= 0) res
      else {
        val (_, nextI) = cache(i - 1)
        reconstruct(nextI, seq(i - 1) +: res)
      }
    }

    reconstruct(l)
  }
}
