//
//  Binary.scala
//  Scala-Solutions
//
//  Created by d-exclaimation on 8:59 PM.
//

package bits

object Binary {
  def maxEqualCountSeq(bits: Vector[Int]): Int = {
    val initState = (0, (0, 0))
    val (max, (_, _)) = bits.foldLeft(initState)((acc, curr) => {
      val (maxCount, (ones, zeros)) = acc
      val newOnes = ones + (if (curr == 1) 1 else 0)
      val newZeros = zeros + (if (curr == 0) 1 else 0)
      val newMax = if (newOnes == newZeros) newOnes + newZeros else maxCount
      (newMax, (newOnes, newZeros))
    })
    max
  }
}
