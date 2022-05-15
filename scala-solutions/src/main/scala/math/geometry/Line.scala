//
//  Line.scala
//  scala-solutions
//
//  Created by d-exclaimation on 14:51.
//


package math.geometry


case class Line(from: Point, to: Point) {
  def point(scale: Double): Point =
    val lhs = from * (1d - scale)
    val rhs = to * scale
    lhs.+(rhs.vector)
}

object Line {
  def apply(from: Point, vector: Vector) = new Line(from, from + vector)
}
