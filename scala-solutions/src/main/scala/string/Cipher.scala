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

  extension (i: Int) {
    def toChar26: Char = (i + 97 + (if (i < 0) 26 else 0)).toChar
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
      (p - k).toChar26
    }
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

  object RSA {
    abstract class System(
      private val p: Int,
      private val q: Int,
      val e: Int
    ) {
      def n: Int = p * q

      private lazy val phi: Int = (p - 1) * (q * 1)

      private lazy val d: Int = math.inverseInZ(phi, e)

      abstract def encrypt(m: String): String

      abstract def decrypt(c: String): String
    }


    def cipher(p: Int, q: Int, e: Int) = {
      val properE = if (math.gcd((p - 1) * (q - 1), e) == 1) e else 1
      new System(p, q, properE) {
        def encrypt(m: String)  = m
          .filter(_.isLetter)
          .toCharInts
          .map(mi => math.powerInZ(n, mi, e))
          .map(_.toChar26)
          .mkString

        def decrypt(c: String) = c
          .filter(_.isLetter)
          .toCharInts
          .map(ci => math.powerInZ(n, ci, d))
          .map(_.toChar26)
          .mkString
      }
    }

    def sign(p: Int, q: Int, e: Int) = {
      val properE = if (math.gcd((p - 1) * (q - 1), e) == 1) e else 1
      new System() {
        def encrypt(m: String) = m
          .filter(_.isLetter)
          .toCharInts
          .map(mi => math.powerInZ(n, mi, d))
          .map(_.toChar26)
          .mkString

        def decrypt(c: String) = c
          .filter(_.isLetter)
          .toCharInts
          .map(ci => math.powerInZ(n, ci, e))
          .map(_.toChar26)
          .mkString
      }
    }
  }

}
