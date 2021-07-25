//
//  Main.scala
//  scala-solutions
//
//  Created by d-exclaimation on 6:36 AM.
//

import array.NumericalSequence
import bits.Binary
import linked.Link
import math.{Clock, Stairs}
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
    println(Clock.clockAngle(3, 25))

    println("Up, Up, and Away")
    println(NumericalSequence.upUpAndAway(Vector(3, 1, 2, 0)))

    println("Create staircase")
    println(Stairs.createStaircase(7))

    println("Binary sequence max even")
    println(Binary.maxEqualCountSeq(Vector(1, 1)))


    println("Discount next price")
    println(NumericalSequence.discountedPrice(Vector(3, 2, 2)))
  }

}
