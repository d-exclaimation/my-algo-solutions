//
//  perfectSquare.scala
//  Scala-Solutions
//
//  Created by d-exclaimation on 10:28 AM.
//

package math

object Square {
  /**
   * Finding if value is a perfect square
   *
   * @param num Numerical value.
   * @return True of False.
   */
  def perfectSquare(num: Int): Boolean = {
    val res = (0 to num / 2)
      .map(x => x * x)
      .find(x => x == num)
    res match {
      case Some(_) => true
      case None => false
    }
  }
}