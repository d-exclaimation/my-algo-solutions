//
//  CharBranch.scala
//  dotty-solutions
//
//  Created by d-exclaimation on 14:17..
//
package branch

class CharBranch[T](
  val value: T,
  var isWord: Boolean = false,
  var branches: Array[CharBranch[T]] = Array()
) {

  def add(node: CharBranch[T]): Unit =
    println(s"$node")
    branches.:+=(node)

  def member(value: T): Option[CharBranch[T]] =
    branches.find(x => x.value == value)

  override def toString: String =
    s"($value) -> [${branches.map(_.toString).mkString(", ")}]"
}

object CharBranch {
  def construct(vec: Seq[String]): CharBranch[Char] = {
    var root = new CharBranch(' ', false, Array())
    var curr = root
    for (elem <- vec) do

      // Iterate over the chars and create the Branch
      for (char <- elem) do

        // If already exist just continue, otherwise create and append
        var next = curr.member(char) match
          case Some(node) =>
            node
          case None =>
            val newNode = new CharBranch(char, false, Array())
            curr.add(newNode)
            newNode
        curr = next
      end for

      curr.isWord = true
      curr = root
    end for
    root
  }

  def substringsOfAnother(vec: Seq[String]): Seq[String] = {
    val root = construct(vec)
    vec.filter { word =>
      var isValid = true
      var curr = root
      for char <- word do
        curr.member(char) match
          case Some(node) =>
            curr = node
          case None =>
            isValid = false
      end for
      curr.branches.length > 0
    }
  }

}
