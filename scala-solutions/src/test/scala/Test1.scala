import array.{Crunching, NumericalSeq}
import bits.Binary._
import org.junit.Assert.*
import org.junit.Test
import string.StringTransform
import pipe.*
import tree.Tree

class Test1 {

  @Test def t1(): Unit = println("ok")

  @Test def treeTest(): Unit = {
    val start = Tree(
      1,
      Tree.node(2, Tree.node(2, Tree.node(2))),
      Tree.node(2, None, Tree.node(3))
    )

    val expected = Tree(
      1,
      None,
      Tree.node(2, None, Tree.node(3))
    )

    assert(expected equals start.removed(2))
  }

  @Test def pipeTest(): Unit = {
    "Ok"
      .|>(_.length)
      .tap(x => println(s"Actual length is $x"))
      .|>(_ + 5)
      .|>(x => println(s"Length of string is ${x - 5}"))
  }

  @Test def missingKthTest(): Unit = {
    List(1, 9, 13, 22)
      .|>(NumericalSeq.missingKth(_, 4))
      .|>(x => assert(x == 5))

    List(3, 4, 5)
      .|>(NumericalSeq.missingKth(_, 2))
      .|>(x => assert(x == 2))
  }

  @Test def largestSmallest(): Unit = {
    List(5, 5, 0, 1, 1, 4, 6)
      .|>(Crunching.largestSmallest(_, 3))
      .|>(x => assert(x == 2))

    List(4, 5, 20, 14, 19)
      .|>(Crunching.largestSmallest(_, 3))
      .|>(x => assert(x == 1))
  }

  @Test def weirdSortTest(): Unit = {
    List(3, 2, 5, 8, 2, 7)
      .|>(NumericalSeq.weirdSort(_, List(7, 8, 3)))
      .|>(x => assert(x equals List(7, 8, 3, 2, 2, 5)))
  }

  @Test def stringTransform(): Unit = {
    "abc"
      .|>(StringTransform.transformAllOccurrence(_, "bbc"))
      .|>(assert(_))

    "aba"
      .|>(StringTransform.transformAllOccurrence(_, "bbc"))
      .|>(x => assert(!x))
  }

  @Test def maxOneBits(): Unit = {
    List(0, 1, 1, 0, 1)
      .|>(oneBitsSequence)
      .|>(x => assert(x == 3))
  }
}
