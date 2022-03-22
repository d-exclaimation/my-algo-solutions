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


    def approach(other: Point, n: Int): Point = {
      val Point(x1, y1) = other.normalized(n)
      val movements = Seq(Point(x1 - x, 0), Point(0, y1 - y))
        .filter(p => p.x != 0 || p.y != 0)
        .map {
          case Point(dx, 0) if dx != 0 => Point(dx / abs(dx), 0)
          case Point(0, dy) if dy != 0 => Point(0, dy / abs(dy))
          case neither => neither
        }

      Random.shuffle(movements) match {
        case first +: _ => apply(first, n)
        case _ => Point(x, y)
      }
    }

    /**
     * Apply a direction into this point
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
  /** A food point collection in a set */
  type Foods = Set[Point]


  /**
   * Create a new game
   *
   * @param n         The side of the bounding square
   * @param foodCount The count of the food in the game
   */
  def apply(n: Int = 10, foodCount: Int = 3): Unit = {
    val (self, body, foods) = start(n, foodCount)
    ReverseSnake.show(self, body, foods, n)

    next(self, body, foods, n)
  }

  /**
   * Next turn with the current body, foods and n bound
   *
   * @param body  Body of the snake
   * @param foods The foods in the square
   * @param n     The bounding square side
   */
  @tailrec
  def next(self: Point, body: Body, foods: Foods, n: Int = 10): Unit = {
    val (newSelf, newBody, newFoods, stillGoing) = scala.io.StdIn.readLine().toLowerCase.headOption match {
      case Some('w') => move(Point.up, self, body, foods, n)
      case Some('a') => move(Point.left, self, body, foods, n)
      case Some('s') => move(Point.down, self, body, foods, n)
      case Some('d') => move(Point.right, self, body, foods, n)
      case _ => (self, body, foods, false)
    }

    ReverseSnake.show(newSelf, newBody, newFoods, n)

    if (!stillGoing) ()
    else next(newSelf, newBody, newFoods, n)
  }

  /**
   * Generate the starting state
   *
   * @param n         The bound size
   * @param foodCount The amount of foods
   * @return The body of the snake, and the foods
   */
  def start(n: Int = 10, foodCount: Int = 3): (Point, Body, Foods) = {
    (Point(0, 0), Queue(Point(n / 2, n / 2)), Set.from((1 to foodCount).map(_ => randomFood(n))))
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
  def move(direction: Point, self: Point, body: Body, foods: Foods, n: Int = 10): (Point, Body, Foods, Boolean) = {
    val newSelf = self.apply(direction, n)
    val head = body.last.approach(self, n)
    val withHead = body.enqueue(head)
    val collision = Set.from(body)
    if (head == newSelf || collision.contains(newSelf) || collision.contains(head))
      (newSelf, withHead, foods, false)
    else if (foods.contains(head) || foods.contains(newSelf))
      (newSelf, withHead, foods - head + randomFood(n), true)
    else
      (newSelf, withHead.dequeue._2, foods, true)
  }

  /**
   * A generate a new food within the bound
   *
   * @param n The bounding size
   * @return A food point
   */
  private def randomFood(n: Int): Point = {
    val x = Random.between(0, n)
    val y = Random.between(0, n)
    Point(x, y)
  }


  /**
   * Display the snake game state
   *
   * @param body  Body of the snake
   * @param foods The foods available
   * @param n     The bound of the size
   */
  def show(self: Point, body: Body, foods: Foods, n: Int = 10): Unit = {
    val lines = (0 to (n + 1)).map(_ => "🔘").mkString
    val grid = Vector.fill(n)(
      mutable.ArrayBuffer.fill(n)("✖️")
    )

    foods.foreach {
      case Point(x, y) => grid(y).update(x, "🍏")
    }

    grid(self.y).update(self.x, "🫐")

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
}
