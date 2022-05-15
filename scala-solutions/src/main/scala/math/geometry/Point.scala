//
//  Point.scala
//  scala-solutions
//
//  Created by d-exclaimation on 13:57.
//


package math.geometry

import scala.annotation.targetName

case class Point(coordinates: Double*) {
  def magnitude: Double =
    scala.math.sqrt(coordinates.map(c => c * c).sum)

  def dimension: Int = coordinates.length

  private def operated(vector: Vector)(operator: (Double, Double) => Double): Point =
    Point(coordinates.zipAll(vector.coordinates, 0d, 0d).map({ case (lhs, rhs) => operator(lhs, rhs) }):_*)

  @targetName("Add")
  def +(vector: Vector): Point =
    operated(vector)(_ + _)

  @targetName("Subtract")
  def -(vector: Vector): Point =
    operated(vector)(_ - _)

  @targetName("Scale")
  def *(scale: Double): Point =
    Point(coordinates.map(_ * scale):_*)

  def vector: Vector =
    Vector(coordinates:_*)

  def vector(from: Point): Vector =
    (this - from.vector).vector
}

object Point {
  def origin(dimension: Int = 2) = Point(Seq.fill(dimension)(0d):_*)

  def `2d`(x: Double, y: Double) = Point(x, y)

  def `3d`(x: Double, y: Double, z: Double) = Point(x, y, z)
}
