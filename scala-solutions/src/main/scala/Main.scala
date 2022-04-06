//
//  Optional.scala
//  dotty-solutions
//
//  Created by d-exclaimation on 17:09..
//

import array.{Crunching, NumericalSeq, LinearSort}
import graph.*
import math.*
import tree.HuffmanTree
import string.Character.{decodeCharacters, headUntil}
import string.Cipher
import string.Cipher.toCharInts
import unions.UnionApproaches
import unions.UnionApproaches.{Charitable, Helpful}
import minigames.{ReverseSnake, Snakes}

@main def main(): Unit = {
  println(Coins.greedy(68, Seq(1, 20, 50)).values.sum)
  println(Coins.optimal(68, Seq(1, 20, 50)).values.sum)
}

