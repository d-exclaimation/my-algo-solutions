//
//  Fibonacci.scala
//  scala-solutions
//
//  Created by d-exclaimation on 4:27 PM.
//

package math

import scala.collection.mutable.ArrayBuffer

object Fibonacci {
  def tribonacci(n: Int): Int = n match
    case x if x <= 1 => x
    case 2 => tribonacci(0) + tribonacci(1)
    case y => tribonacci(y - 1) + tribonacci(y - 2) + tribonacci(y - 3)

  def optimizedTresbonacci(n: Int): Int = {
    (3 to n)
      .foldLeft(Vector[Int](0, 1, 1)) { (acc, curr) =>
        curr match {
          case _ => acc :+ acc.slice(acc.length - 3, acc.length).sum
        }
      }
      .apply(n)
  }

  def blazingTribonacci(n: Int): Int = {
    var buffer = new ArrayBuffer[Int]()
    buffer += 0
    buffer += 1
    buffer += 1
    for (i <- (3 to n)) {
      buffer += (buffer(i - 3) + buffer(i - 2) + buffer(i - 1))
    }
    buffer(n)
  }
}
