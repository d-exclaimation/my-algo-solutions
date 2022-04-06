//
//  Coins.scala
//  scala-solutions
//
//  Created by d-exclaimation on 10:00 PM.
//

package math

import scala.annotation.tailrec

object Coins {
  def greedy(price: Int, coins: Seq[Int]): Map[Int, Int] = {
    val c = coins.sorted
    changeRec(price, coins, c.length - 1, Map.empty)
  }

  def optimal(price: Int, coins: Seq[Int]): Map[Int, Int] = {
    val c = coins.sorted
    c.foldLeft(Map.empty[Int, Int]) {
      case (acc, coin) if acc.isEmpty => acc.updated(coin, price / coin)
      case (acc, coin) => {
        val total = acc
          .map {
            case (prevCoin, count) if coin % prevCoin == 0 =>
              val ratio = coin / prevCoin
              count / ratio
            case _ => 0
          }
          .sum

        acc
          .map {
            case (prevCoin, count) if coin % prevCoin == 0 =>
              (prevCoin, count % coin)
            case (prevCoin, count) =>
              (prevCoin, count)
          }
          .updated(coin, total)
      }
    }
  }

  @tailrec
  private def changeRec(price: Int, coins: Seq[Int], i: Int, carry: Map[Int, Int]): Map[Int, Int] =
    if (price <= 0) carry
    else if (i < 0) carry
    else if (coins(i) > price) changeRec(price, coins, i - 1, carry)
    else changeRec(price - coins(i), coins, i, carry.updated(coins(i), carry.getOrElse(coins(i), 0) + 1))
}
