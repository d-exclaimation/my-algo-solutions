//
//  Character.scala
//  scala-solutions
//
//  Created by d-exclaimation on 7:14 PM.
//

package string

import scala.annotation.tailrec


object Character {
  def decodeCharacters(s: String): String = {
    val tokens = "(\\d+|\\*|\\+|\\/|\\-|\\]|\\[|\\^|\\w)".r.findAllIn(s).toSeq

    val (res, _) = tokens
      .map { token => (token, token.toIntOption) }
      .foldLeft((List.empty[String], List.empty[Int])) {
        case ((chars, multipliers), (_, Some(multiplier))) => (chars, multiplier +: multipliers)

        case ((chars, multipliers), ("]", None)) =>
          val ::(mul, newMultipliers) = multipliers
          val (words, newChars) = headUntil(chars, false) {
            case "[" => true
            case _ => false
          }
          val word = words.reverse.mkString

          ((1 to mul).map(_ => word).mkString :: newChars, newMultipliers)

        case ((chars, multipliers), (char, None)) => (char +: chars, multipliers)
      }


    res.reverse.mkString
  }
  
  @tailrec
  private def headUntil[T](l: List[T], include: Boolean = true, carry: List[T] = Nil)(predicate: T => Boolean): (List[T], List[T]) = l match {
    case Nil => (carry, Nil)
    case ::(head, next) if predicate(head) && include => (head :: carry, next)
    case ::(head, next) if predicate(head) && !include => (carry, next)
    case ::(head, next) =>
      headUntil[T](l = next, include, head :: carry)(predicate)
  }
}
