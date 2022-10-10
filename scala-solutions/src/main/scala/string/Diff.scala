//
//  Diff.scala
//  scala-solutions
//
//  Created by d-exclaimation on 13:29.
//

package string

import scala.annotation.tailrec
import scala.collection.mutable

object Diff {

  def brokenKeyboard(a: String, b: String): Boolean =
    ignoreDups(a.toCharArray, b.toCharArray)

  @tailrec
  private def ignoreDups(a: Seq[Char], b: Seq[Char]): Boolean = (a, b) match {
    case (_, Seq()) => true
    case (Seq(), _) => false
    case (lhead +: ltail, rhead +: rtail) if lhead == rhead => ignoreDups(ltail, rtail)
    case (_ +: ltail, rhs) => ignoreDups(ltail, rhs)
  }

  def distance(a: String, b: String, i: Int = -1, j: Int = -1): Int =
    if (i < 0 || j < 0) distance(a, b, a.length, b.length)
    else if (i == 0 || j == 0) Seq(i, j).max
    else if (a(i - 1) == b(i - 1)) distance(a, b, i - 1, j - 1)
    else {
      Seq((i - 1, j), (i, j - 1), (i - 1, j - 1))
        .map { case (ii, jj) => distance(a, b, ii, jj) }
        .min + 1
    }


  def distanceMemoized(a: String, b: String): Int = {
    val cache = IndexedSeq.fill(a.length)(mutable.IndexedSeq.fill(b.length)(-1))

    def recursion(i: Int = a.length, j: Int = b.length): Int = {
      val cached = cache(i - 1)(j - 1)
      if (cached > -1) cached
      else {
        val res = if (i == 0 || j == 0) Seq(i, j).max
        else if (a(i - 1) == b(i - 1)) recursion(i - 1, j - 1)
        else {
          Seq((i - 1, j), (i, j - 1), (i - 1, j - 1))
            .map { case (a, b) => recursion(a, b) }
            .min + 1
        }
        cache(i - 1).update(j - 1, res)
        res
      }
    }

    recursion()
  }

  object Operation extends Enumeration {
    val DELETE, INSERT, SUBSTITUTE, ALIGNMENT = Value
  }

  def distanceRecurrence(a: String, b: String): Seq[Operation.Value] = {
    @tailrec
    def recurrenceCache(
      i: Int = 0,
      j: Int = 0,
      cache: IndexedSeq[IndexedSeq[Int]] = IndexedSeq.fill(a.length + 1)(IndexedSeq.fill(b.length + 1)(0))
    ): IndexedSeq[IndexedSeq[Int]] = {
      if (i > a.length) cache
      else if (j > b.length) recurrenceCache(i + 1, 0, cache)
      else {
        val nextCache =
          if (i == 0 && j == 0) cache
          else if (j == 0) cache.updated(i, cache(i).updated(j, i))
          else if (i == 0) cache.updated(i, cache(i).updated(j, j))
          else if (a(i - 1) == b(j - 1)) cache.updated(i, cache(i).updated(j, cache(i - 1)(j - 1)))
          else cache.updated(i,
            cache(i).updated(j, 1 + Seq((i - 1, j), (i, j - 1), (i - 1, j - 1))
              .map { case (m, n) => cache(m)(n) }.min
            )
          )
        recurrenceCache(i, j + 1, nextCache)
      }
    }

    val cache = recurrenceCache()
    println(cache.map(row => row.map(_.toString).mkString(", ")).map(row => s"[$row]").mkString("\n"))

    @tailrec
    def reconstruct(i: Int, j: Int, res: Seq[Operation.Value] = Seq.empty): Seq[Operation.Value] = {
      if (i == 0 || j == 0) Seq.fill(Seq(i, j).max)(Operation.DELETE) ++ res
      else if (a(i - 1) == b(j - 1)) reconstruct(i - 1, j - 1, Operation.ALIGNMENT +: res)
      else {
        val ((nextI, nextJ), op) = Seq(((i - 1, j), Operation.DELETE), ((i, j - 1), Operation.INSERT), ((i - 1, j - 1), Operation.SUBSTITUTE))
          .minBy { case ((m, n), _) => cache(m)(n) }
        reconstruct(nextI, nextJ, op +: res)
      }
    }
    reconstruct(a.length, b.length)
  }
}
