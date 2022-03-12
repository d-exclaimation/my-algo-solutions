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
    .filter(_.isPrime)
    .map(p => (p - 1, p))
    .foldLeft(m) {
      case (acc, (m, d)) => acc * m / d
    }
}
