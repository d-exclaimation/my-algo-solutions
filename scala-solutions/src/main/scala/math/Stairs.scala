//
//  Stairs.scala
//  Scala-Solutions
//
//  Created by d-exclaimation on 3:35 PM.
//

package math

object Stairs {
  /**
   * Count the column staircase can be created
   * @param num Number of block given.
   * @param start Starting height (Default: 1)
   * @return Number of steps / height
   */
  def createStaircase(num: Int, start: Int = 1): Int =
    if (num < start) 0 else 1 + createStaircase(num - start, start + 1)
}
