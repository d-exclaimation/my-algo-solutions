//
//  Optional.scala
//  dotty-solutions
//
//  Created by d-exclaimation on 17:09..
//

import async.StructuredConcurrency.*
import math.Fibonacci

import java.util.UUID
import scala.concurrent.Future
import scala.util.Success

@main def main: Unit = {
  timestamp("Async await pattenr") {
    val res0 = suspendFunction(1)
    val res1 = suspendFunction(2)
    (await(res0), await(res1)) match {
      case (Success(value0), Success(value1)) => println(value0 + value1)
      case _ => println("Some failed")
    }
  }
}

def suspendFunction(time: Int): Future[Int] = async {
  Thread.sleep(time * 1000)
  time
}

def timestamp[T](name: String)(operation: => T): T = {
  val s = System.nanoTime()
  val result = operation
  println(s"[$name]: ${(System.nanoTime() - s) / 1e6} ms")
  return result
}

def timestamp[T](operation: => T): T =
  timestamp(
    name = UUID.randomUUID().toString
  )(operation = operation)
