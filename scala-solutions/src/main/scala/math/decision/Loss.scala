//
//  Loss.scala
//  scala-solutions
//
//  Created by d-exclaimation on 10:05 PM.
//

package math.decision

import math.decision.Risk.*

object Loss {
  def expectedOppurtunityLoss(table: Seq[Alternatives]): (String, Double) = {
    if (table.isEmpty) {
      return ("None", 0)
    }
    // Find highest of each column to be deducted when calculating regrets
    val highestOfEach = table(0)
      .futures.indices
      .map { i => table.map(_.futures.apply(i)) }
      .map { seq => seq.reduce((acc, curr) => if (acc.payoff >= curr.payoff) acc else curr) }
      .map { case FutureDemand(_, payoff) => payoff }

    table
      .map {
        case Alternatives(label, values) => {
          // Reduce the highest of each column and reduce it by each value to find regret
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