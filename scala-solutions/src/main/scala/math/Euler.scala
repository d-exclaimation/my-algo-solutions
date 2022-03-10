//
//  Euler.scala
//  scala-solutions
//
//  Created by d-exclaimation on 3:45 PM.
//

package math

object Euler {
  def phi(m: Int): Int = (2 to m)
    .filter(m % _ == 0)
    .map(_.toDouble).map(p => 1.0 - (1.0 / p))
    .appended(m.toDouble)
    .product
    .toInt
}
