//
//  StudentGrid.scala
//  scala-solutions
//
//  Created by d-exclaimation on 11:10 PM.
//

package matrix

import option.??
import tree.Heap

import scala.annotation.tailrec
import scala.collection.immutable.HashMap

object StudentGrid {
  def studentFiveAverages(grades: Seq[Seq[Int]]): Seq[Seq[Int]] = {
    val result = gradesDatabaseRec(grades)

    val result2 = result.map {
      case (id, grades) =>
        val top5 = (for (_ <- 1 to 5) yield grades.pop() ?? 0).sum
        Vector(id, top5 / 5)

    }

    result2.toSeq
  }

  @tailrec
  private def gradesDatabaseRec(
    input: Seq[Seq[Int]], source: HashMap[Int, Heap[Int]] = HashMap()
  ): HashMap[Int, Heap[Int]] = input match {
    // Case of not empty seq
    case head +: tail => head match {

      case Seq(id, grade) =>
        val prev = source.getOrElse(id,
          new Heap[Int](
            resolver = _ >= _,
            childCount = 3
          )
        )
        gradesDatabaseRec(tail, source updated(id, prev pushed grade))

      case _ => gradesDatabaseRec(tail, source)
    }

    // Case of empty seq, exit early
    case _ => source
  }
}
