//
//  Optional.scala
//  dotty-solutions
//
//  Created by d-exclaimation on 17:09..
//

import array.{Crunching, NumericalSeq}
import math.Employees
import string.Cipher
import unions.UnionApproaches
import unions.UnionApproaches.{Charitable, Helpful}

@main def main(): Unit = {
  val result = Cipher.repeatedSubstring(
    str = "FVLYPIPGLULYPQHFFSDEMDHEVOKNCBGEPSMFNCKYGSSBUPURKIUFOHHQZRYSFUHELCXSAPBUOVAEIFYLUPWEDSWGFKZBFGEGUIHLUPQEUFPUBDKBOVKYFTZPQUMRBOLUHNNHNRWMAQPABCFIPSMHKBUHEDOVHEMOSGIFBCFKVUGBBGKCXXXX",
    reps = 2
  )
//  Cipher.reverseSubstring(
//    str = "FVLYPIPGLULYPQHFFSDEMDHEVOKNCBGEPSMFNCKYGSSBUPURKIUFOHHQZRYSFUHELCXSAPBUOVAEIFYLUPWEDSWGFKZBFGEGUIHLUPQEUFPUBDKBOVKYFTZPQUMRBOLUHNNHNRWMAQPABCFIPSMHKBUHEDOVHEMOSGIFBCFKVUGBBGKCXXXX",
//  )
  println(result)
//  val person1 = new Helpful with Charitable {
//    val name = "Person1"
//
//    def help() = println(s"I ($name) help people")
//
//    def donate(money: Double) = println(s"I ($name) donate some money of $money amount")
//
//    def giveMoney(): Double = 100.25
//  }
//
//
//  UnionApproaches.handleBoth(person1)
}
