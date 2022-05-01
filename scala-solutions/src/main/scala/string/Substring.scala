//
//  LongestSubstring.scala
//  scala-solutions
//
//  Created by d-exclaimation on 21:22.
//

package string

import scala.annotation.tailrec

object Substring {
  extension (s: String) {
    def withoutTail: String = s.substring(0, s.length - 1)
  }

  def longestCommon(s1: String, s2: String): String = (s1.toSeq, s2.toSeq) match {
    case (Seq(), Seq()) => ""
    case (head1 :+ tail1, head2 :+ tail2) if tail1 == tail2 => longestCommon(head1.mkString, head2.mkString) + tail1.toString
    case (head1 :+ tail1, head2 :+ tail2) =>
      val sol1 = longestCommon(head1.mkString, s2)
      val sol2 = longestCommon(s1, head2.mkString)
      if (sol1.length > sol2.length) sol1 else sol2
    case (_, _) => ""
  }

  def longestCommonOptimized(s1: String, s2: String, i1: Int, i2: Int): String =
    if (i1 == 0 || i2 == 0) ""
    else if (s1(i1 - 1) == s2(i2 - 1)) longestCommonOptimized(s1, s2, i1 - 1, i2 - 1) + s"${s1(i1 - 1)}"
    else
      Seq(
        longestCommonOptimized(s1, s2, i1 - 1, i2),
        longestCommonOptimized(s1, s2, i1, i2 - 1)
      ).maxBy(_.length)

  def longestCommonRecurrence(s1: String, s2: String): String = {
    @tailrec
    def innerFunc(i1: Int, i2: Int, cache: IndexedSeq[IndexedSeq[Int]] = IndexedSeq.fill(s1.length + 1)(IndexedSeq.fill(s2.length + 1)(0))): IndexedSeq[IndexedSeq[Int]] = {
      if (i1 == s1.length) cache
      else if (i2 == s2.length) innerFunc(i1 + 1, 1, cache)
      else
        val nextCache = cache.updated(i1,
          cache(i1).updated(i2,
            if (s1(i1 - 1) == s2(i2 - 1)) cache(i1 - 1)(i2 - 1) + 1
            else Seq(cache(i1 - 1)(i2), cache(i1)(i2 - 1)).max
          )
        )
        innerFunc(i1, i2 + 1, nextCache)
    }

    val table = innerFunc(1, 1)

    @tailrec
    def reconstruct(i1: Int, i2: Int, res: String = ""): String = {
      if (i1 == 0 || i2 == 0) res
      else if (s1(i1 - 1) == s2(i2 - 1)) reconstruct(i1 - 1, i2 - 1, s"${s1(i1 - 1)}$res")
      else 
        val (j1, j2) = Seq((i1 - 1, i2), (i1, i2 - 1)).maxBy { case (i, j) => table(i)(j) }
        reconstruct(j1, j2, res)
    }
    
    reconstruct(s1.length, s2.length)
  }
}
