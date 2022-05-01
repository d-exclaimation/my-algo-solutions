//
//  Memoised.scala
//  scala-solutions
//
//  Created by d-exclaimation on 10:46.
//

package utils

import scala.collection.mutable

case class Memoized[Input, Output, ID](
  func: (Input, mutable.Map[ID, Output]) => Output,
) {
  private val memo = mutable.Map.empty[ID, Output]

  def call(input: Input): Output = {
    val res = func(input, memo)
    res
  }

  def reset() = {
    memo.clear()
  }

  def cleanCall(input: Input): Output = {
    reset()
    call(input)
  }
}