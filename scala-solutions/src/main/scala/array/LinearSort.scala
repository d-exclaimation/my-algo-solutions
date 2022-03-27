//
//  LinearSort.scala
//  scala-solutions
//
//  Created by d-exclaimation on 1:25 PM.
//

package array

import scala.collection.mutable

object LinearSort {
  def countingSort(nums: Seq[Int]): Seq[Int] = countingSort[Int](
    arr = nums,
    key = identity
  )

  def countingSort[Element](map: Map[Element, Int]): Seq[Element] = countingSort[Element](
    arr = map.keys.toSeq,
    key = map.apply
  )

  def countingSort[Element](arr: Seq[Element], key: Element => Int): Seq[Element] = {
    val (_, b) = arr.foldLeft((keyPositions[Element](arr, key), arr.map(identity))) {
      case ((p, b), a) =>
        val ka = key(a)
        (p.updated(ka, p(ka) + 1), b.updated(p(ka), a))
    }

    b
  }

  def keyPositions[Element](arr: Seq[Element], key: Element => Int): Seq[Int] = {
    val k = arr.map(key).max

    val c0 = arr.foldLeft((0 to k).map(_ => 0)) {
      case (c, a) =>
        val ka = key(a)
        c.updated(ka, c(ka) + 1)
    }

    val (_, c) = (0 to k).foldLeft((0, c0)) {
      case ((sum, c), i) =>
        (sum + c(i), c.updated(i, sum))
    }

    c
  }

  def radixSort(arr: Seq[Int]): Seq[Int] =
    radixSort(arr, arr.map(_.inPower10).max)

  def radixSort(arr: Seq[Int], d: Int): Seq[Int] = {
    (1 to d).foldLeft(arr) {
      case (a, i) => countingSort[Int](a, _.digitAt(i))
    }
  }

  extension (i: Int) {
    def digitAt(d: Int): Int = {
      val p = scala.math.pow(10, d).toInt
      i % p * 10 / p
    }

    def inPower10: Int =
      scala.math.log10(i.toDouble).floor.toInt + 1
  }
}
