//
//  Vector.scala
//  scala-solutions
//
//  Created by d-exclaimation on 14:04.
//


package math.geometry

import scala.annotation.targetName

case class Vector(coordinates: Double*) {
  @targetName("Dot")
  def **(vector: Vector): Double = coordinates
    .zipAll(vector.coordinates, 0d, 0d)
    .map { case (lhs, rhs) => lhs * rhs }
    .sum

  def magnitude: Double = this ** this
}

object Vector {
  def empty(dimension: Int) = Vector((1 to dimension).map(_ => 0d):_*)

  def `2d`(x: Double, y: Double) = Vector(x, y)

  def `3d`(x: Double, y: Double, z: Double) = Vector(x, y, z)
}
