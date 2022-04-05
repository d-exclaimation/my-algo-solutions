//
//  Coins.scala
//  scala-solutions
//
//  Created by d-exclaimation on 10:00 PM.
//

package math

import scala.annotation.tailrec

object Coins {
  def change(price: Int, coins: Seq[Int]): Map[Int, Int] = {
    val c = coins.sorted
    changeRec(price, coins, c.length - 1, Map.empty)
  }

  @tailrec
  private def changeRec(price: Int, coins: Seq[Int], i: Int, carry: Map[Int, Int]): Map[Int, Int] =
    if (price <= 0) carry
    else if (i < 0) carry
    else if (coins(i) > price) changeRec(price, coins, i - 1, carry)
    else changeRec(price - coins(i), coins, i, carry.updated(coins(i), carry.getOrElse(coins(i), 0) + 1))
}
