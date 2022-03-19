//
//  Snakes.scala
//  scala-solutions
//
//  Created by d-exclaimation on 12:52 PM.
//

package minigames

import scala.annotation.tailrec
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
  
  object Point {
    val left = Snakes.Point(-1, 0)
    val right = Snakes.Point(1, 0)
    val up = Snakes.Point(0, -1)
    val down = Snakes.Point(0, 1)
  }

  type Body = Queue[Point]
  type Foods = Set[Point]


  @tailrec
  def apply(body: Body, foods: Foods, n: Int = 10): (Body, Foods, Boolean) = {
    val (newBody, newFoods, stillGoing) = scala.io.StdIn.readLine() match {
      case "w" => next(Point.up, body, foods, n)
      case "a" => next(Point.left, body, foods, n)
      case "s" => next(Point.down, body, foods, n)
      case "d" => next(Point.right, body, foods, n)
      case _ => (body, foods, false)
    }
    
    Snakes.show(newBody, newFoods, n)
    
    if (!stillGoing) (newBody, newFoods, false)
    else apply(newBody, newFoods, n)
  }
  
  def start(n: Int = 10): (Body, Foods) = {
    (Queue.apply(Point(n/2, n/2)), Set.apply(randomFood(n), randomFood(n), randomFood(n)))
  }

  def next(direction: Point, body: Body, foods: Foods, n: Int = 10): (Body, Foods, Boolean) = {
    val head = body.last.move(direction, n)
    val withHead = body.enqueue(head)
    val collision = Set.from(body)
    if (collision.contains(head))
      (withHead, foods, false)
    else if (foods.contains(head))
      (withHead, foods - head + randomFood(n), true)
    else
      (withHead.dequeue._2, foods, true)
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