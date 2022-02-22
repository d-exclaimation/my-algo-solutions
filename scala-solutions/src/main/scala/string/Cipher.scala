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


  def vigenere(plain: String, key: String): String =
    val newKey = key.extend(plain.length).toCharInts
    val newPlain = plain.toCharInts
    newPlain.zip(newKey)
      .map { case (p, k) =>
        (p + k) % 26 + 97
      }
      .map(_.toChar)
      .mkString

  def deVigenere(plain: String, key: String): String =
    val newKey = key.extend(plain.length).toCharInts
    val newPlain = plain.toCharInts
    newPlain.zip(newKey)
      .map { case (p, k) =>
        (p - k) + (if (p < k) 26 else 0) + 97
      }
      .map(_.toChar)
      .mkString
}
