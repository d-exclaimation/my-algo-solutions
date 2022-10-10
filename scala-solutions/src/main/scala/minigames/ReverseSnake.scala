//
//  ReverseSnake.scala
//  scala-solutions
//
//  Created by d-exclaimation on 4:58 PM.
//

package minigames

import scala.annotation.tailrec
import scala.collection.immutable.{AbstractSeq, LinearSeq, Queue}
import scala.collection.mutable
import scala.math.{abs, max, min}
import scala.util.Random

object ReverseSnake {

  /**
   * Point in a area of x and y square
   *
   * @param x Horizontal location
   * @param y Vertical location
   */
  case class Point(x: Int, y: Int) {
    /**
     * Change the x and y point to be within the n x n square space
     *
     * @param n The side of the square
     * @return A point with normalized values
     */
    def normalized(n: Int): Point =
      Point(max(0, min(n - 1, x)), max(0, min(n - 1, y)))

    /**
     * Apply cu
     *
     * @param direction A point as direction
     * @param n         The side of the square to bound the point
     * @return A new point after the applied direction within the n x n square
     */
    def apply(direction: Point, n: Int): Point = {
      val Point(dx, dy) = direction
      Point(x + dx, y + dy).normalized(n)
    }
  }

  object Point {
    /** Left direction point */
    val left = Point(-1, 0)
    /** Right direction point */
    val right = Point(1, 0)
    /** Up direction point */
    val up = Point(0, -1)
    /** Down direction point */
    val down = Point(0, 1)
  }

  /** A snake body represented in a queue where the last element is the head */
  type Body = Queue[Point]

  extension (b: Body) {
    def approach(point: Point, n: Int): Point = {
      val Point(x, y) = b.last
      val notIn = b.reverse.tail.toSet
      val Point(x1, y1) = point.normalized(n)
      val movements = Seq(Point(x1 - x, 0), Point(0, y1 - y))
        .filter(p => p.x != 0 || p.y != 0)
        .map {
          case Point(dx, 0) if dx != 0 => Point(dx / abs(dx), 0)
          case Point(0, dy) if dy != 0 => Point(0, dy / abs(dy))
          case neither => neither
        }
        .map {
          b.last(_, n)
        }
        .filter {
          !notIn.contains(_)
        }

      Random.shuffle(movements) match {
        case first +: _ => first
        case _ => Point(x, y)
      }
    }
  }


  /**
   * Create a new game
   *
   * @param n         The side of the bounding square
   * @param foodCount The count of the food in the game
   */
  def apply(n: Int = 10): Unit = {
    val (self, body) = start(n)
    ReverseSnake.show(self, body, n)

    next(self, body, n)
  }

  /**
   * Next turn with the current body, foods and n bound
   *
   * @param body  Body of the snake
   * @param foods The foods in the square
   * @param n     The bounding square side
   */
  @tailrec
  def next(self: Point, body: Body, n: Int = 10, isMoving: Boolean = true): Unit = {
    val (newSelf, newBody, stillGoing) = scala.io.StdIn.readLine().toLowerCase.headOption match {
      case Some('w') => move(Point.up, self, body, n, isMoving)
      case Some('a') => move(Point.left, self, body, n, isMoving)
      case Some('s') => move(Point.down, self, body, n, isMoving)
      case Some('d') => move(Point.right, self, body, n, isMoving)
      case _ => (self, body, true)
    }

    ReverseSnake.show(newSelf, newBody, n)

    if (!stillGoing) ()
    else next(newSelf, newBody, n, !isMoving)
  }

  /**
   * Generate the starting state
   *
   * @param n         The bound size
   * @param foodCount The amount of foods
   * @return The body of the snake, and the foods
   */
  def start(n: Int = 10, foodCount: Int = 3): (Point, Body) = {
    (Point(0, 0), Queue(Point(n / 2, n / 2)))
  }

  /**
   * Move the snake with the direction and apply game logic
   *
   * @param direction The direction point
   * @param body      The body of snake
   * @param foods     The foods available
   * @param n         The bounding size
   * @return The body of snake, the remaining foods, and a boolean for check if game ended after the movement
   */
  def move(
    direction: Point,
    self: Point,
    body: Body,
    n: Int = 10,
    isMoving: Boolean = true
  ): (Point, Body, Boolean) = {
    val newSelf = self.apply(direction, n)
    val collision = Set.from(body)
    val head = if (isMoving) body.approach(self, n) else body.last
    val withHead = if (isMoving) body.enqueue(head) else body
    if (head == newSelf || collision.contains(newSelf) || (isMoving && collision.contains(head)))
      (newSelf, withHead, false)
    else if (Random.nextBoolean())
      (newSelf, withHead, true)
    else
      (newSelf, if (isMoving) withHead.dequeue._2 else withHead, true)
  }


  /**
   * Display the snake game state
   *
   * @param body  Body of the snake
   * @param foods The foods available
   * @param n     The bound of the size
   */
  def show(self: Point, body: Body, n: Int = 10): Unit = {
    val lines = (0 to (n + 1)).map(_ => "🔳").mkString
    val grid = Vector.fill(n)(mutable.ArrayBuffer.fill(n)("⬛️"))

    grid(self.y).update(self.x, "🍏")

    body.zipWithIndex.foreach {
      case (Point(x, y), i) => grid(y).update(x, "⚪")
    }


    body.lastOption.foreach(head => grid(head.y).update(head.x, "🟠"))


    println(lines)
    grid.foreach { arr =>
      println("🔳" + arr.mkString + "🔳")
    }
    println(lines)
  }
}
