//
//  Snakes.scala
//  scala-solutions
//
//  Created by d-exclaimation on 12:52 PM.
//

package minigames

import scala.collection.immutable.Queue
import scala.collection.mutable
import scala.math.{max, min}
import scala.util.Random

object Snakes {
  case class Point(x: Int, y: Int) {
    def normalized(n: Int): Point =
      Point(max(0, min(n - 1, x)), max(0, min(n - 1, y)))

    def move(direction: Point, n: Int): Point = {
      val Point(dx, dy) = direction
      Point(x + dx, y + dy).normalized(n)
    }
  }

  type Body = Queue[Point]
  type Foods = Set[Point]


  def start(n: Int = 10): (Body, Foods) = {
    (Queue.apply(Point(n/2, n/2)), Set.apply(randomFood(n)))
  }

  def apply(direction: Point, body: Body, foods: Foods, n: Int = 10): (Body, Foods) = {
    val head = body.last.move(direction, n)
    val withHead = body.enqueue(head)

    if (foods.contains(head))
      (withHead, foods - head + randomFood(n))
    else
      (withHead.dequeue._2, foods)
  }

  private def randomFood(n: Int): Point = {
    val x = Random.between(0, n)
    val y = Random.between(0, n)
    Point(x, y)
  }


  def show(body: Body, foods: Foods, n: Int = 10): Unit = {
    val lines = (0 to (n + 1)).map(_ => "🔘").mkString
    val grid = Vector.fill(n)(
      mutable.ArrayBuffer.fill(n)("✖️")
    )

    foods.foreach {
      case Point(x, y) => grid(y).update(x, "🍏")
    }

    body.zipWithIndex.foreach {
      case (Point(x, y), i) if i % 2 == 0 => grid(y).update(x, "🟨")
      case (Point(x, y), _) => grid(y).update(x, "🟧")
    }

    val headOpt = body.lastOption
    headOpt.foreach(head => grid(head.y).update(head.x, "🟥"))


    println(lines)
    grid.foreach { arr =>
      println("🔘" + arr.mkString + "🔘")
    }
    println(lines)
  }


  extension (state: (Body, Foods)) {
    def output(n: Int): Unit = {
      show(state._1, state._2, n)
    }
  }
}