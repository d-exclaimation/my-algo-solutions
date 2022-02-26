//
//  Cipher.scala
//  scala-solutions
//
//  Created by d-exclaimation on 6:19 PM.
//

package string

object Cipher {
  extension (s: String) {
    def toCharInts: Seq[Int] =
      s.toLowerCase.map(_.toByte).map(_.toInt).map(_ - 97)

    def extend(length: Int): String =
      if (s.length > length) s.substring(0, length)
      else (s ++ s).extend(length)
  }

  extension (c: Char) {
    def toCharInt: Int = c.toLower.toByte.toInt - 97
  }


  def vigenere(plain: String, key: String): String = plain
    .toCharInts
    .zip(
      key.extend(plain.length).toCharInts
    )
    .map { case (p, k) =>
      (p + k) % 26 + 97
    }
    .map(_.toChar)
    .mkString

  def deVigenere(plain: String, key: String): String = plain
    .toCharInts
    .zip(
      key.extend(plain.length).toCharInts
    )
    .map { case (p, k) =>
      (p - k) + (if (p < k) 26 else 0) + 97
    }
    .map(_.toChar)
    .mkString

  def repeatedSubstring(str: String, reps: Int = 4): Seq[String] = {
    var res = Seq.empty[String]

    def substringUntil(i: Int): String = {
      (0 until reps).reverse.map(i - _).map(str.apply).mkString
    }

    for (i <- 3 until str.length) {
      var count = 0
      val base = substringUntil(i)
      println(s"$base ->")
      for (j <- i until str.length) {
        val each = substringUntil(j)
        if (base == each && j - i - 1 == 19) {
          println(s"-> $each at ($i and $j))")
          count += 1
        }
      }
      if (count >= 1) {
        res = res :+ base
      }
    }
    res
  }

  def reverseSubstring(str: String, reps: Int = 2) = {

    def substringUntil(i: Int): String = {
      (0 until reps).reverse.map(i - _).map(str.apply).mkString
    }

    for (i <- 3 until str.length) {
      var count = 0
      val base = substringUntil(i)
      println(s"$base ->")
      for (j <- i until str.length) {
        val each = substringUntil(j).reverse
        if (base == each) {
          println(s"-> $each (diff ${j - i})")
          count += 1
        }
      }
    }
  }
}
