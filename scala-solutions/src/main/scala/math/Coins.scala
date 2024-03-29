//
//  Coins.scala
//  scala-solutions
//
//  Created by d-exclaimation on 10:00 PM.
//

package math

import scala.annotation.tailrec
import scala.collection.mutable

object Coins {
  def greedy(price: Int, coins: Seq[Int]): Map[Int, Int] = {
    val c = coins.sorted

    @tailrec
    def changeRec(price: Int, coins: Seq[Int], i: Int, carry: Map[Int, Int]): Map[Int, Int] =
      if (price <= 0) carry
      else if (i < 0) carry
      else if (coins(i) > price) changeRec(price, coins, i - 1, carry)
      else changeRec(price - coins(i), coins, i, carry.updated(coins(i), carry.getOrElse(coins(i), 0) + 1))

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


  def dynamic(price: Int, coins: Seq[Int]): Int =
    if (price == 0) 0
    else if (price < 0) Int.MaxValue
    else 1 + coins.map(coin => dynamic(price - coin, coins)).min


  def dynamicMemoized(price: Int, coins: Seq[Int]): Int = {
    val cache = mutable.IndexedSeq.fill[Option[Int]](price + 1)(None)

    def innerFunc(price: Int): Int = {
      if (price == 0) 0
      else if (price < 0) Int.MaxValue
      else cache.applyOrElse(price, _ => None) match {
        case Some(value) => value
        case None =>
          val res = 1 + coins.map(coin => innerFunc(price - coin)).min
          cache.update(price, Some(res))
          res
      }
    }

    innerFunc(price)
  }

  def dynamicRecurrence(price: Int, coins: Seq[Int]): Int = {
    @tailrec
    def innerFunc(amount: Int = 1, cache: IndexedSeq[Int] = IndexedSeq.fill(price + 1)(0)): IndexedSeq[Int] = {
      if (amount == price) cache
      else
        val nextCache = cache.updated(
          amount,
          1 + coins
            .filter(_ <= price)
            .map(coin => cache.apply(price - coin))
            .min
        )
        innerFunc(amount + 1, nextCache)
    }

    innerFunc().applyOrElse(price, _ => Int.MaxValue)
  }
}
