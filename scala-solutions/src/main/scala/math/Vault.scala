//
//  Vault.scala
//  scala-solutions
//
//  Created by d-exclaimation on 12:33 PM.
//

package math

object Vault {
  def vaultCode(code: Seq[Int], k: Int): Seq[Int] = {
    val otherIndices = (i: Int) =>
      if (k > 0)
        (1 to k).map(i + _)
      else
        (1 to -k).map(i - _).map(_ % code.length + code.length)

    val sumOthers = (i: Int) => otherIndices(i)
      .map(_ % code.length)
      .map(code(_))
      .sum

    val evalResult = (i: Int) => if (k == 0) 0 else sumOthers(i)

    code.indices.map(evalResult)
  }
}
