//
//  perfectSquare.scala
//  Scala-Solutions
//
//  Created by d-exclaimation on 10:28 AM.
//

package math

object Square {
  def perfectSquare(num: Int): Boolean = {
    val res = (0 to num/2)
      .map(x => x * x)
      .find(x => x == num)
    res match {
      case Some(_) => true
      case None => false
    }
  }
}