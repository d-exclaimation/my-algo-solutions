//
//  Optional.scala
//  dotty-solutions
//
//  Created by d-exclaimation on 17:09..
//

import async.StructuredConcurrency.timeout

@main def hello: Unit = {
  val ref = timeout(() => println("DONE"), 5000)
  ref.cancel()
  println("ok")
}



