//
//  SubsetSum.scala
//  scala-solutions
//
//  Created by d-exclaimation on 20:01.
//

package math

import scala.collection.mutable

object SubsetSum {
  def dynamic(numbers: Seq[Int], n: Int, required: Int, nonEmpty: Boolean = false): Boolean = {
    println(s"n: $n, required: $required")
    if (n == 0) false
    else {
      if (required == 0 && nonEmpty) true
      else dynamic(numbers, n - 1, required, nonEmpty) || dynamic(numbers, n - 1, required - numbers(n - 1), true)
    }
  }

  def dynamicMemoized(numbers: Seq[Int], n: Int, required: Int): Boolean = {
    val cache = IndexedSeq.fill(n)(mutable.IndexedSeq.fill[Option[Boolean]](required)(None))

    def innerFunc(i: Int, s: Int, nonEmpty: Boolean = false): Boolean = {
      if (i == 0) false
      else {
        val res =
          if (s == 0 && nonEmpty) true
          else innerFunc(i - 1, required, nonEmpty) || innerFunc(i - 1, required - numbers(i - 1), true)

        cache(i).update(s, Some(res))
        res
      }
    }

    innerFunc(n, required)
  }
}
