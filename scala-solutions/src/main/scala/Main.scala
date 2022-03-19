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
  val (body, foods) = Snakes.start(n)
  Snakes.show(body, foods, n)

  val _ = Snakes.apply(body, foods, n)
}
