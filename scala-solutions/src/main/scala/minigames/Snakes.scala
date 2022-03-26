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

/**
 * Snake mini-game, where a snake chase a food and grow longer.
 */
object Snakes {

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
    val (body, foods) = Snakes.start(n, foodCount)
    Snakes.show(body, foods, n)

    next(body, foods, n)
  }

  /**
   * Next turn with the current body, foods and n bound
   *
   * @param body  Body of the snake
   * @param foods The foods in the square
   * @param n     The bounding square side
   */
  @tailrec
  def next(body: Body, foods: Foods, n: Int = 10): Unit = {
    val (newBody, newFoods, stillGoing) = scala.io.StdIn.readLine().toLowerCase.headOption match {
      case Some('w') => move(Point.up, body, foods, n)
      case Some('a') => move(Point.left, body, foods, n)
      case Some('s') => move(Point.down, body, foods, n)
      case Some('d') => move(Point.right, body, foods, n)
      case _ => (body, foods, false)
    }

    Snakes.show(newBody, newFoods, n)

    if (!stillGoing) ()
    else next(newBody, newFoods, n)
  }

  /**
   * Generate the starting state
   *
   * @param n         The bound size
   * @param foodCount The amount of foods
   * @return The body of the snake, and the foods
   */
  def start(n: Int = 10, foodCount: Int = 3): (Body, Foods) = {
    (Queue.apply(Point(n / 2, n / 2)), Set.from((1 to foodCount).map(_ => randomFood(n))))
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
  def move(direction: Point, body: Body, foods: Foods, n: Int = 10): (Body, Foods, Boolean) = {
    val head = body.last.apply(direction, n)
    val withHead = body.enqueue(head)
    val collision = Set.from(body)
    if (collision.contains(head))
      (withHead, foods, false)
    else if (foods.contains(head))
      (withHead, foods - head + randomFood(n), true)
    else
      (withHead.dequeue._2, foods, true)
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
  def show(body: Body, foods: Foods, n: Int = 10): Unit = {
    val lines = (0 to (n + 1)).map(_ => "🔘").mkString
    val grid = Vector.fill(n)(
      mutable.ArrayBuffer.fill(n)("✖️")
    )

    foods.foreach {
      case Point(x, y) => grid(y).update(x, "🍏")
    }

    val bodyLength = body.length

    body.zipWithIndex.foreach {
      case (Point(x, y), i) if (i + 1) * 100 / bodyLength >= 80 => grid(y).update(x, "🟧")
      case (Point(x, y), i) if (i + 1) * 100 / bodyLength >= 60 => grid(y).update(x, "🟨")
      case (Point(x, y), i) if (i + 1) * 100 / bodyLength >= 40 => grid(y).update(x, "🟩")
      case (Point(x, y), i) if (i + 1) * 100 / bodyLength >= 20 => grid(y).update(x, "🟦")
      case (Point(x, y), _) => grid(y).update(x, "🟪")
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