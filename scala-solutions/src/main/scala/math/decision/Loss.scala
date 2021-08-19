//
//  Loss.scala
//  scala-solutions
//
//  Created by d-exclaimation on 10:05 PM.
//

package math.decision

case class Alternatives(name: String, futures: Seq[FutureDemand])

case class FutureDemand(risk: Double, payoff: Double)

object Loss {
  def expectedOppurtunityLoss(table: Seq[Alternatives]): (String, Double) = {
    if (table.isEmpty) {
      return ("None", 0)
    }
    val highestOfEach = table(0)
      .futures.indices
      .map { i => table.map(_.futures.apply(i)) }
      .map { seq => seq.reduce((acc, curr) => if (acc.payoff >= curr.payoff) acc else curr) }
      .map { case FutureDemand(_, payoff) => payoff }

    table
      .map {
        case Alternatives(label, values) => {
          val demands = values.indices.map(i => FutureDemand(values(i).risk, highestOfEach(i) - values(i).payoff))
          Alternatives(label, demands)
        }
      }
      .map {
        case Alternatives(label, futures) => (label, futures.map(x => x.risk * x.payoff).sum)
      }
      .reduce { (acc, curr) =>
        if (acc._2 <= curr._2) acc else curr
      }
  }
}
