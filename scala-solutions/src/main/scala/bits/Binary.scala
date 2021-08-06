//
//  Binary.scala
//  Scala-Solutions
//
//  Created by d-exclaimation on 8:59 PM.
//

package bits

import pipe.pipe

import scala.math.max

object Binary {
  def maxEqualCountSeq(bits: Vector[Int], maxCount: Int = 0, ones: Int = 0, zeros: Int = 0): Int = bits match {
    case curr +: tail => {
      val newOnes = ones + (if (curr == 1) 1 else 0)
      val newZeros = zeros + (if (curr == 0) 1 else 0)
      val newMax = if (newOnes == newZeros) newOnes + newZeros else maxCount
      maxEqualCountSeq(bits, newMax, newOnes, newZeros)
    }
    case _ => maxCount
  }

  def oneBitsSequence(bits: Seq[Int]): Int =
    bits
      .indices
      .map { i => bits.indices.filter(_ != i).map(bits(_)).pipe(maxOneSequence(_)) }
      .max

  def maxOneSequence(bits: Seq[Int], prevMax: Int = 0, count: Int = 0): Int = bits match {
    case curr +: tail => {
      if (curr == 0) maxOneSequence(tail, max(prevMax, count), 0)
      else maxOneSequence(tail, prevMax, count + 1)
    }
    case _ => max(prevMax, count)
  }


  def applyXOR(n: Int, start: Int = 0): Int = (0 until n).map(start + 2 * _).reduce(_ ^ _)
}