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
}
