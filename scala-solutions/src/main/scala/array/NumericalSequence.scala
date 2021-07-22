//
//  Sequence.scala
//  Scala-Solutions
//
//  Created by d-exclaimation on 12:31 PM.
//

package array

import scala.language.implicitConversions

class NumericalSequence(val wrapped: Iterable[Int]) {
  /**
   * Check whether numerical sequence is in increasing order
   *
   * '''Complexity''':
   *
   * Time: ''O(n)'' | Space: ''O(1)''
   *
   * @return Boolean whether it's increasing
   */
  def isIncreasing: Boolean = {
    val (_, res) = wrapped.foldLeft((0, false)) { (acc, x) =>
      val (prev, res) = acc
      (x, res && prev <= x)
    }
    res
  }
}

object NumericalSequence {
  implicit def iterableToNumericalSequence(value: Iterable[Int]): NumericalSequence = new NumericalSequence(value)

  /**
   * Up, Up and Away
   *
   * Check if possible to change one value to make it all increasing order
   *
   * @param arr List of Integers.
   * @return Boolean whether it is possible.
   */
  def upUpAndAway(arr: List[Int]): Boolean = {
    arr
      .indices
      .iterator
      .count(i => {
        val curr = arr(i)
        val prev = if (i > 0) arr(i - 1) else curr
        val next = if (i < arr.length - 1) arr(i + 1) else curr
        prev <= curr && curr <= next
      }) == 1
  }
}


