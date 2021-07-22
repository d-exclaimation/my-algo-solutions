//
//  Main.scala
//  scala-solutions
//
//  Created by d-exclaimation on 6:36 AM.
//

import array.NumericalSequence.upUpAndAway
import linked.Link
import math.Clock.clockAngle
import tree.Tree

object Main {
  def main(args: Array[String]): Unit = {
    println("Tree problems")
    val subpath = Link(1,
      Link(2,
        Link(2).some
      ).some
    )
    val oak = Tree(1,
      Tree(2, Tree(2).some).some,
      Tree(3).some
    )
    println(oak.haveSubPath(subpath.some))
    println(oak.removed(2))

    println("Clock angle")
    println(clockAngle(3, 25))

    println("Up, Up, and Away")
    println(upUpAndAway(List(3, 1, 2, 0)))
  }

}
