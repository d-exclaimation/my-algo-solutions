//
//  Crunching.scala
//  scala-solutions
//
//  Created by d-exclaimation on 8:18 PM.
//

package array

import tree.Heap

object Crunching {
  def largestSmallest(seq: Seq[Int], k: Int = 3): Int = {
    var heap = Heap.make[Int](
      data = seq.toVector,
      resolver = _ < _,
      childCount = 3
    )
    val cache = (1 to 3).foldLeft[Option[Int]](Some(0))((_, _) => heap.pop())
    val max = seq.max

    heap.peek match {
      case Some(min) => max - min
      case _ => max - cache.getOrElse(0)
    }
  }
  
  def sumUnique(seq: Seq[Int]): Int = {
    val valid = seq.foldLeft(Map.empty[Int, Int]) { (acc, curr) =>
      val prev = acc.get(curr) getOrElse 0
      acc.updated(curr, prev + 1)
    }
    
    valid
      .filter(_._2 <= 1)
      .keys
      .sum
  }

  def maxNonAdjacentSum(nums: Seq[Int]): Int = {
    val res = nums
      .indices
      .reverse
      .tail
      .foldLeft(Seq.fill(nums.length)(0)) {
        (cache, i) =>
          cache.updated(i, Seq(nums(i) + cache.applyOrElse(i + 2, _ => 0), cache.applyOrElse(i + 1, _ => 0)).max)
      }
    res.head
  }
}
