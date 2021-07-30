//
//  Tree.scala
//  Scala-Solutions
//
//  Created by d-exclaimation on 6:48 AM.
//
package tree

import linked.Link
import option.*

/**
 * Binary Tree node
 *
 * @constructor Create a new Node with the wrapped value and optionals child nodes.d
 * @param value Wrapped value of the binary tree.
 * @param left  Left child tree node of the same type.
 * @param right Right child tree node of the same type.
 * @tparam T Any type that can hashed and immutable.
 */
case class Tree[T](
  value: T,
  left: Option[Tree[T]] = None,
  right: Option[Tree[T]] = None
) {
  /**
   * Removed a value from the bottom to up
   *
   * @param target The value being removed.
   * @return A new tree with target removed bottom-up.
   */
  def removed(target: T): Option[Tree[T]] = {
    val newLeft = left
      .?>>(_.removed(target))
    val newRight = right
      .?>>(_.removed(target))
    if (newLeft.isEmpty && newRight.isEmpty && value == target)
      None
    else
      Some(Tree(value, newLeft, newRight))
  }

  override def toString: String = {
    if (left.isEmpty && right.isEmpty)
      s"#Tree($value)"
    else
      s"#Tree<($value): $left | $right>"
  }

  /**
   * Check whether a tree contains a sub-path
   *
   * ''Giving a null Link will return true''
   *
   * @param path The sub-path given as Link object
   * @return Boolean whether it's true or not
   */
  def haveSubPath(path: Option[Link[T]]): Boolean = {
    val performRecursive = (x: Option[Tree[T]]) => x match {
      case Some(value) =>
        value.haveSubPath(if (path.isDefined) path.get.next else None)
      case None =>
        if (path.isDefined) path.get.next.isEmpty else false
    }

    path match {
      case Some(value) =>
        if (this.value == value.value)
          performRecursive(left) || performRecursive(right)
        else
          false
      case None =>
        true
    }
  }

  override def equals(obj: Any): Boolean = obj match {
    case Tree(v2, l2, r2) =>
      val valueMatch = value == v2
      val leftMatch = left.?>(_.equals(l2)).??(l2 == None)
      val rightMatch = right.?>(_.equals(r2)).??(r2 == None)
      valueMatch && leftMatch && rightMatch
    case Some(tree) => equals(tree)
    case _ => false
  }
}

object Tree {
  /**
   * Property shorthand for Tree to be null safe
   *
   * @return Option[Tree] of Some
   */
  def node[T](value: T, left: Option[Tree[T]] = None, right: Option[Tree[T]] = None): Option[Tree[T]] = Some(
    Tree(value, left, right)
  )
}
