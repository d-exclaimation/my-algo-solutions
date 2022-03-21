//
//  Candies.scala
//  scala-solutions
//
//  Created by d-exclaimation on 8:42 PM.
//

package minigames

import scala.annotation.tailrec

object Candies {
  /**
   * You are given a certain number of `candies` and an `exchange` rate.
   * For every `exchange` number of candy wrappers that you trade in, you receive an additional candy.
   * Return the maximum number of candies that you can eat.
   *
   * Ex:
   *
   * {{{
   * candies = 3, exchange = 3.
   * return 4 (each your three candies, exchange 3 wrappers, each additional candy).
   * }}}
   *
   * {{{
   * candies = 3, exchange = 4.
   * return 3
   * }}}
   */
  def eatingCandy(candies: Int, exchangeRate: Int, wrappers: Int = 0, eaten: Int = 0): Int =
    if (candies > 0) eatingCandy(0, exchangeRate, wrappers + candies, eaten + candies)
    else if (wrappers >= exchangeRate) eatingCandy(wrappers / exchangeRate, exchangeRate, wrappers % exchangeRate, eaten)
    else eaten
}
