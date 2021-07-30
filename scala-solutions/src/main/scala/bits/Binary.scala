//
//  Binary.scala
//  Scala-Solutions
//
//  Created by d-exclaimation on 8:59 PM.
//

package bits

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
}