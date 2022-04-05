//
//  Schedule.scala
//  scala-solutions
//
//  Created by d-exclaimation on 10:08 PM.
//

package math

object Schedule {
  def interval(jobs: Seq[(Int, Int)]): Set[(Int, Int)] = {
    val (set, _) = jobs
      .sortBy(_._2)
      .foldLeft(Set.empty[(Int, Int)], 0) {
        case ((set, time), (start, end)) if start >= time =>
          (set + ((start, end)), end)
        case ((set, time), _) =>
          (set, time)
      }
    set
  }
}
