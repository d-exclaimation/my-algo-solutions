//
//  Test2.scala
//  scala-solutions
//
//  Created by d-exclaimation on 3:32 PM.
//

import org.junit.Assert.*
import org.junit.Test
import math.Divisible.sumDivisibleByThree

class Test2 {
  @Test def divisibleByThreeTest(): Unit = {
    assert(sumDivisibleByThree(List(3, 1, 2, 5, 8)) == 18)
  }
}
