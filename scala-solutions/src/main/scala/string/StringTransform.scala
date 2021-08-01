//
//  StringTransform.scala
//  scala-solutions
//
//  Created by d-exclaimation on 11:13 PM.
//

package string

object StringTransform {
  def transformAllOccurrence(s: String, t: String): Boolean = {
    if (s.length != t.length)
      return false
    var validator: Map[Char, Char] = Map()
    var isValid = true
    for (i <- s.indices) {
      val (lhs, rhs) = (s(i), t(i))
      if (isValid && lhs != rhs) {
        validator.get(lhs) match {
          case Some(char) => isValid = rhs == char
          case _ => validator += (lhs -> rhs)
        }
      }
    }
    return isValid
  }
}
