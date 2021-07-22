//
//  Dollar.scala
//  Scala-Solutions
//
//  Created by d-exclaimation on 3:40 PM.
//

package math

object Dollar {
  /**
   * Determine the value need to compensate all the transactions with 1 dollar remaining
   * @param transaction All the value added or subtracted.
   * @return Money needed to stay in 1 dollar
   */
  def singleDollar(transaction: List[Int]): Int = 1 - transaction.sum
}
