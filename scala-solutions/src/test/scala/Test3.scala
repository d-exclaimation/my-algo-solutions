//
//  Test3.scala
//  scala-solutions
//
//  Created by d-exclaimation on 8:47 PM.
//

import minigames.Candies.eatingCandy
import org.junit.Assert.*
import org.junit.Test

class Test3 {
  @Test def eatingCandyTest(): Unit = {
    assert(eatingCandy(3, 3) == 4)
    assert(eatingCandy(3, 4) == 3)
    assert(eatingCandy(0, 1) == 0)
    assert(eatingCandy(4, 2) == 7)
  }
}
