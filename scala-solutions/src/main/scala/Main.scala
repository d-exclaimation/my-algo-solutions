//
//  Optional.scala
//  dotty-solutions
//
//  Created by d-exclaimation on 17:09..
//

import array.{Crunching, NumericalSeq}
import graph.*
import math.*
import string.Character.{decodeCharacters, headUntil}
import string.Cipher
import string.Cipher.toCharInts
import unions.UnionApproaches
import unions.UnionApproaches.{Charitable, Helpful}
import minigames.Snakes

@main def main(): Unit = {
  val n = 10
  val left = Snakes.Point(-1, 0)
  val right = Snakes.Point(1, 0)
  val up = Snakes.Point(0, -1)
  val down = Snakes.Point(0, 1)

  var res = Snakes.start(n)
  Snakes.show(res._1, res._2, n)

  var isMoving = true

  while (isMoving) {
    res = scala.io.StdIn.readLine() match {
      case "w" => Snakes.apply(up, res._1, res._2, n)
      case "a" => Snakes.apply(left, res._1, res._2, n)
      case "s" => Snakes.apply(down, res._1, res._2, n)
      case "d" => Snakes.apply(right, res._1, res._2, n)
      case _ =>
        isMoving = false
        res
    }
    Snakes.show(res._1, res._2, n)
  }
}
