//
//  Optional.scala
//  dotty-solutions
//
//  Created by d-exclaimation on 17:09..
//

import array.{Crunching, NumericalSeq}
import graph.*
import math.{Clock, Employees, Euler, bezoutIdentity, gcd, inverseInZ, isPrime, zStarMembers}
import string.Cipher
import string.Cipher.toCharInts
import unions.UnionApproaches
import unions.UnionApproaches.{Charitable, Helpful}

@main def main(): Unit = {
  val q1 = 3
  val q2 = 5
  val p1 = p(q1)
  val p2 = p(q2)

  val n = p1 * p2
  println("Phi1")
  val phi1 = Euler.phi(n)
  println("Phi12")
  val expected = s"${Euler.phi(phi1)}/$phi1"
  val res = s"${2 * (q1 - 1) * (q2 - 1)}/$phi1"
  println(s"expected: $expected, given: $res")
  println(s"${(1 to phi1).count(m => gcd(phi1, m) == 1)}")
  println(s"${(1 to phi1).length}")
}

def p(q: Int): Int = 2 * q + 1
