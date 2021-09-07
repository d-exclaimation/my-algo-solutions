//
//  Test2.scala
//  scala-solutions
//
//  Created by d-exclaimation on 3:32 PM.
//

import array.StringChain
import bits.Binary
import math.Divisible.sumDivisibleByThree
import math.{Fibonacci, Vault}
import matrix.StudentGrid
import org.junit.Assert.*
import org.junit.Test
import tree.Branch

class Test2 {
  extension [T](lhs: Seq[T]) {
    infix def equivalent(rhs: Seq[T]): Boolean = equalsSeq(lhs, rhs)
  }


  @Test def divisibleByThreeTest(): Unit = {
    assert(sumDivisibleByThree(List(3, 1, 2, 5, 8)) == 18)
  }

  @Test def studentAveragesTest(): Unit = {
    val grades = Vector(
      Vector(1, 100), Vector(1, 50), Vector(2, 100), Vector(2, 93), Vector(1, 39),
      Vector(2, 87), Vector(1, 89), Vector(1, 87),
      Vector(1, 90), Vector(2, 100), Vector(2, 76)
    )
    val expected = Vector(Vector(1, 83), Vector(2, 91))
    val result = StudentGrid.studentFiveAverages(grades)
    assert(result.indices.map(i => expected(i) equals result(i)).reduce(_ && _))
  }

  @Test def xorValues(): Unit = {
    assert(Binary.applyXOR(3, 0) equals 6)
    assert(Binary.applyXOR(5, 3) equals 3)
  }

  @Test def vaultCodeTest(): Unit = {
    val res0 = Vault.vaultCode(Vector(1, 2, 3), 2)
    val exp0 = Vector(5, 4, 3)
    assert(equalsSeq(res0, exp0))
    println("Ok aa")
    val res1 = Vault.vaultCode(Vector(4, 1, 3), -1)
    val exp1 = Vector(3, 4, 1)
    assert(equalsSeq(res1, exp1))
  }

  @Test def chainSizeTest(): Unit = {
    val res0 = StringChain.chainSize(Vector("a", "ab", "abc"))
    val exp0 = 3
    assert(res0 == exp0)

    val res1 = StringChain.chainSize(Vector("a", "abc"))
    val exp1 = 1
    assert(res1 == exp1)
  }

  @Test def tribonaaciTest(): Unit = {
    val res0 = Fibonacci.tribonacci(25)
    val res1 = Fibonacci.optimizedTresbonacci(25)
    val res2 = Fibonacci.blazingTribonacci(25)
    val exp = 1389537
    assert(res0 == exp)
    assert(res1 == exp)
  }

  @Test def branches(): Unit = {
    val start = Branch(1,
      Seq(1, 2, 3, 4).map(x => Branch(x))
    )

    val expected = Seq(1, 1, 2, 3, 4)
    val res0 = start.preorder
    
    assert(res0 equivalent expected)
  }



  private def equalsSeq[T](lhs: Seq[T], rhs: Seq[T]): Boolean = lhs
    .indices
    .map(i => lhs(i) equals rhs(i))
    .reduce(_ && _)
}
