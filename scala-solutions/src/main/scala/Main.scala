//
//  Optional.scala
//  dotty-solutions
//
//  Created by d-exclaimation on 17:09..
//

import array.{Crunching, NumericalSeq, LinearSort}
import graph.*
import math.*
import string.Character.{decodeCharacters, headUntil}
import string.Cipher
import string.Cipher.toCharInts
import unions.UnionApproaches
import unions.UnionApproaches.{Charitable, Helpful}
import minigames.{ReverseSnake, Snakes}

@main def main(): Unit = {
  val input = Map(
    'a' -> 2,
    'b' -> 4,
    'c' -> 5,
    'd' -> 0,
    'e' -> 2,
    'f' -> 4,
    'g' -> 3,
    'h' -> 5
  )
  println(LinearSort.keyPositions(input.keys.toSeq, input.apply))

  println(LinearSort.radixSort(Seq(329, 457, 657, 839, 436, 720, 355, 1000)))
}

