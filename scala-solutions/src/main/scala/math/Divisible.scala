//
//  Divisible.scala
//  scala-solutions
//
//  Created by d-exclaimation on 2:03 PM.
//

package math

object Divisible {
  def sumDivisibleByThree(nums: Seq[Int]): Int = {
    // Perfect factors will sum to multiple of 3 and does not affect the others
    val perfectSum = nums.filter(_ % 3 == 0).sum

    val imperfects = nums.filter(_ % 3 != 0)
    val currSum = imperfects.sum

    if (currSum % 3 == 0) perfectSum + currSum
    else perfectSum + currSum - recursiveRemainder(imperfects, currSum % 3, currSum)

  }

  // O(n) time, O(1) space
  private def recursiveRemainder(imperfects: Seq[Int], remainder: Int, cap: Int): Int = {
    val res = findExactOrTwoSum(imperfects, remainder)
      .map { case (l, r) => l + r }
    res match {
      case Some(value) => value
      case _ =>
        if (remainder + 3 >= cap) 0
        else recursiveRemainder(imperfects, remainder + 3, cap)
    }
  }

  // O(n) time, O(n) space
  def findExactOrTwoSum(nums: Seq[Int], target: Int, set: Set[Int] = Set()): Option[(Int, Int)] = nums match {
    case head +: tail => {
      val needed = target - head
      if (needed == 0 || set.contains(needed)) Some((head, needed))
      else findExactOrTwoSum(tail, target, set + head)
    }
    case _ => None
  }
}
