//
//  Knapsack.scala
//  scala-solutions
//
//  Created by d-exclaimation on 10:24 PM.
//

package math

import scala.annotation.tailrec
import scala.collection.mutable

object Knapsack {
  def greedy(limit: Int, seq: Seq[(Int, Int)]): Seq[(Int, Int)] =
    val (_, res) = seq
      .sortBy { case (b, w) => b.toDouble / w.toDouble }
      .reverse
      .foldLeft((limit, Seq.empty[(Int, Int)])) {
        case ((l, acc), (b, w)) if l >= w =>
          (l - w, acc.appended((b, w)))
        case ((l, acc), _) => (l, acc)
      }
    res

  def dynamic(limit: Int, seq: Seq[(Int, Int)], n: Int): Int = {
    if (limit == 0 || n == 0) 0
    else
      val (value, weight) = seq.applyOrElse(n - 1, _ => (0, limit))
      val without = dynamic(limit, seq, n - 1)
      if (weight > limit) without
      else Seq(without, value + dynamic(limit - weight, seq, n - 1)).max
  }

  def dynamicMemoized(limit: Int, seq: Seq[(Int, Int)], n: Int): Int = {
    val cache = IndexedSeq.fill(n)(mutable.IndexedSeq.fill(limit)(-1))
    def innerFunc(limit: Int, n: Int): Int = {
      if (limit == 0 || n == 0) 0
      else
        val (value, weight) = seq.applyOrElse(n - 1, _ => (-1, limit))
        val without = dynamic(limit, seq, n - 1)
        cache(n)(limit) match {
          case -1 =>
            val res =
              if (weight > limit) without
              else Seq(without, value + dynamic(limit - weight, seq, n - 1)).max
            cache(n).update(limit, res)
            res
          case res => res
        }

    }
    innerFunc(limit, n)
  }

  def dynamicRecurrence(limit: Int, seq: Seq[(Int, Int)], n: Int): Int = {
    @tailrec
    def innerFunc(
      c: Int = 1,
      i: Int = 1,
      cache: IndexedSeq[IndexedSeq[Int]] = IndexedSeq.fill(n)(IndexedSeq.fill(limit)(0))
    ): IndexedSeq[IndexedSeq[Int]] = {
      if (c == limit) cache
      else if (i == 1) innerFunc(c + 1)
      else
        val (value, weight) = seq.applyOrElse(n - 1, _ => (-1, limit))
        val without = cache(i - 1)(c)
        val nextCache =
          if (weight > c)
            cache.updated(i, cache(i).updated(c, without))
          else
            cache.updated(i, cache(i).updated(c, Seq(without, value + cache(i - 1)(c - weight)).max))
        innerFunc(c, i + 1, nextCache)
    }

    innerFunc()(n)(limit)
  }
}
