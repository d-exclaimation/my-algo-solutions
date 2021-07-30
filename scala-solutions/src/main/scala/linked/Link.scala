
//
//  Link.scala
//  Scala-Solutions
//
//  Created by d-exclaimation on 9:47 AM.
//

package linked

/**
 * Linked list node
 *
 * @param value Wrapped value of the link.
 * @param next  Next node of the list / chain.
 * @tparam T Any type that can be hashed and immutable
 */
case class Link[T](value: T, next: Option[Link[T]] = None) {
  override def toString: String =
    if (next.isEmpty) s"#Link($value)" else s"#Link<($value): $next>"

  /**
   * Property shorthand for Link to be null safe
   *
   * @return Option[Link] of Some
   */
  def some: Some[Link[T]] = Some(this)

}

object Link {
  /**
   * Create a nullable Link Node
   *
   * @param value Value wrapped / stored in value.
   * @param next
   * @tparam T
   * @return
   */
  def node[T](
    value: T, next: Option[Link[T]] = None
  ): Option[Link[T]] =
    Some(Link(value, next))
}