//
//  Branch.scala
//  scala-solutions
//
//  Created by d-exclaimation on 9:42 AM.
//


package tree

case class Branch[T](
  value: T,
  branches: Seq[Branch[T]] = Seq.empty[Branch[T]]
) {
  def preorder: Seq[T] = value +: (if (branches.isEmpty) Seq() else branches.flatMap(_.preorder))
}
