//
//  Risk.scala
//  scala-solutions
//
//  Created by d-exclaimation on 10:03 PM.
//

package math.decision



object Risk {
  case class Alternatives(name: String, futures: Seq[FutureDemand])

  case class FutureDemand(risk: Double, payoff: Double)
}
