//
//  Optional.scala
//  dotty-solutions
//
//  Created by d-exclaimation on 17:09..
//

import async.StructuredConcurrency.*
import linked.Link
import logging.Log
import math.Fibonacci
import math.decision.Uncertainty

import java.util.UUID
import scala.concurrent.Future
import scala.util.Success

@main def main: Unit = {
  Log.timeScope("Async await pattenr") {
    val (label, value) = await_!(
      Uncertainty.maximin(
        Vector(
          ("Small", Vector(10, 10, 10)),
          ("Medium", Vector(7, 12, 12)),
          ("Small", Vector(-4, 2, 16)),
        )
      )
    )
    println(s"Maximin choice is $label with value of $value")
  }
}

def suspendFunction(time: Int): Future[Int] = async {
  Thread.sleep(time * 1000)
  time
}