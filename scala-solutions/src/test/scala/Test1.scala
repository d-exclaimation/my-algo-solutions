import org.junit.Assert.*
import org.junit.Test
import tree.Tree
import pipe._

class Test1:
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
