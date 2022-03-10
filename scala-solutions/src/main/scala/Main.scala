//
//  Optional.scala
//  dotty-solutions
//
//  Created by d-exclaimation on 17:09..
//

import array.{Crunching, NumericalSeq}
import graph.*
import math.{Clock, Employees, Euler, bezoutIdentity, inverseInZ}
import string.Cipher
import string.Cipher.toCharInts
import unions.UnionApproaches
import unions.UnionApproaches.{Charitable, Helpful}

@main def main(): Unit = {
  val graph = AdjacencyListGraph(
    """U 4
      |1 2
      |0 1
      |0 2
      |2 3
      |""".stripMargin)

  println(graph.shortestPath(0, 2).pathString)

  println(graph)

  println(Euler.phi(7))
}
