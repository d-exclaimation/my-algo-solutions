//
//  Optional.scala
//  dotty-solutions
//
//  Created by d-exclaimation on 17:09..
//

import array.{Crunching, NumericalSeq}
import math.{Clock, Employees}
import string.Cipher
import string.Cipher.toCharInts
import unions.UnionApproaches
import unions.UnionApproaches.{Charitable, Helpful}

@main def main(): Unit = {
  //  val result = Cipher.repeatedSubstring(
  //    str = "FVLYPIPGLULYPQHFFSDEMDHEVOKNCBGEPSMFNCKYGSSBUPURKIUFOHHQZRYSFUHELCXSAPBUOVAEIFYLUPWEDSWGFKZBFGEGUIHLUPQEUFPUBDKBOVKYFTZPQUMRBOLUHNNHNRWMAQPABCFIPSMHKBUHEDOVHEMOSGIFBCFKVUGBBGKCXXXX",
  //    reps = 2
  //  )
  //  Cipher.reverseSubstring(
  //    str = "FVLYPIPGLULYPQHFFSDEMDHEVOKNCBGEPSMFNCKYGSSBUPURKIUFOHHQZRYSFUHELCXSAPBUOVAEIFYLUPWEDSWGFKZBFGEGUIHLUPQEUFPUBDKBOVKYFTZPQUMRBOLUHNNHNRWMAQPABCFIPSMHKBUHEDOVHEMOSGIFBCFKVUGBBGKCXXXX",
  //  )
  //  val result = Cipher.vigenere("iamvincent", "code")
  val data = Seq("00:00", "12:23", "05:50", "23:12")
  println(Clock.minIntervalTimeString(data))
}
