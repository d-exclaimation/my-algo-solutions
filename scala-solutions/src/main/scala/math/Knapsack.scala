//
//  Knapsack.scala
//  scala-solutions
//
//  Created by d-exclaimation on 10:24 PM.
//

package math

object Knapsack {
  def greedy(limit: Int, seq: Seq[(Int, Int)]): Seq[(Int, Int)] =
    val (_, res) = seq
      .sortBy { case (b, w) => b.toDouble / w.toDouble }
      .reverse
      .foldLeft((limit, Seq.empty[(Int, Int)])) {
        case ((l, acc), (b, w)) if l >= w =>
          (l - w, acc.appended((b, w)))
        case ((l, acc), _) => (l, acc)
      }
    res
}
