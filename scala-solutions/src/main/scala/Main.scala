//
//  Optional.scala
//  dotty-solutions
//
//  Created by d-exclaimation on 17:09..
//

import array.{Crunching, NumericalSeq}
import graph.*
import math.*
import string.Cipher
import string.Cipher.toCharInts
import unions.UnionApproaches
import unions.UnionApproaches.{Charitable, Helpful}

@main def main(): Unit = {
  val graphStr =
    """U 7 W
      |0 1 5
      |0 2 7
      |0 3 12
      |1 2 9
      |2 3 4
      |1 4 7
      |2 4 4
      |2 5 3
      |3 5 7
      |4 5 2
      |4 6 5
      |5 6 2""".stripMargin

  val graph = AdjacencyListGraph(graphStr)
  println(graph)
  val (parent, distance) = graph.prim(0)

  println(s"[${
    parent.map {
      case Some(value) => s"$value"
      case None => "-"
    }.mkString(", ")
  }] [${
    distance.mkString(", ")
  }]")
}

def p(q: Int): Int = 2 * q + 1
