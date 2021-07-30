//
//  Multiple.scala
//  scala3-simple
//
//  Created by d-exclaimation on 5:23 PM.
//
package queue

import scala.math.pow

object Multiple {
  def probZero(m: Int, l: Double, u: Double): Double = {
    val p = l / u
    val x = (p ** m) / (m.! * (1 - (l / (m * u))))
    val fn = (n: Int) => (p ** n) / n.! + x
    (0 until m).map(fn).sum ** -1
  }

  extension (d: Double)
    def **(e: Double): Double = pow(d, e)

  extension (i: Int)
    def ! : Int = if (i <= 0) 1 else (1 to i).reduce(_ * _)
}
