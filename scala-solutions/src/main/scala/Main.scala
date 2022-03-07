//
//  Optional.scala
//  dotty-solutions
//
//  Created by d-exclaimation on 17:09..
//

import array.{Crunching, NumericalSeq}
import graph.AdjacencyMatrixGraph
import math.{Clock, Employees}
import string.Cipher
import string.Cipher.toCharInts
import unions.UnionApproaches
import unions.UnionApproaches.{Charitable, Helpful}

@main def main(): Unit = {
  val graph = AdjacencyMatrixGraph(
    """U 4
      |1 2
      |0 1
      |0 2
      |2 3
      |""".stripMargin)

  val parentTree = graph.bfs(0)
  println(AdjacencyMatrixGraph.shortestPath(parentTree, 0, 3))
}
