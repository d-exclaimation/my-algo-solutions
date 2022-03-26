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
import minigames.{ReverseSnake, Snakes}

@main def main(): Unit = {
//  val x5x4x3x21 = Seq(1, 0, 1, 1, 1, 1)
//  for (i <- (6 to 31)) {
//    val root = (0 to i).map(j => if (j == i || j == 0) 1 else 0)
//    printPolyinZ2(divideInZ2(
//      div = x5x4x3x21,
//      root
//    ))
//  }
  val c = Seq(1, 1, 1, 0, 1)
  val permute = utils.dfsBacktrack[Seq[Int], Int, Seq[Seq[Int]]](
    candidate = Seq.empty,
    input = 5,
    output = Seq.empty,
    isSolution = (c, i) => c.length == i,
    shouldPrune = c => c.length == 5 && c.forall(_ == 0),
    children = (c, _) => Seq(c :+ 0, c :+ 1),
    addToOutput = (c, o) => o :+ c
  )
  println("      seed         period")
  for (s <- permute) {
    val p = lfsrPeriod(c, s)
    println(s" ${s.mkString(", ")}       $p")
  }
}

