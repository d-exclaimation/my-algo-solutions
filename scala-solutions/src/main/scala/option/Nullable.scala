//
//  Nullable.scala
//  Scala-Solutions
//
//  Created by d-exclaimation on 6:11 PM.
//

package option

import scala.language.implicitConversions

/**
 * Nullable Extension for Option
 *
 * @param wrapped Option value wrapped.
 * @tparam T Value inside the Option.
 */
class Nullable[T](val wrapped: Option[T]) {
  /**
   * Get the value given or splits out the fallback
   *
   * @param fallback Any value of the same non-null type.
   * @return The wrapped type value or the fallback if none.
   */
  def ??(fallback: T): T = wrapped match {
    case Some(value) => value
    case None => fallback
  }

  /**
   * Get the value given or splits out the fallback
   *
   * @param fallback Any value of the same non-null type.
   * @return The wrapped type value or the fallback if none.
   */
  def otherwise(fallback: T): T = ??(fallback)

  /**
   * Perform method or function unless None given which just return None.
   * (Method equivalent of `_.map`)
   *
   * @param continuation Function performing the method / function on the value.
   * @tparam K Value transformation result type
   * @return Option of Value returned from continuation or None
   */
  def ?>[K](continuation: (T) => K): Option[K] = wrapped match {
    case Some(value) => Some(continuation(value))
    case None => None
  }



  /**
   * Perform method or function that return Option and flatten it.
   * (Method equivalent of `_.flatMap`)
   *
   * @param continuation Function performing the method / function on the value.
   * @tparam K Value transformation result type
   * @return Option of Value returned from continuation or None
   */
  def ?>>[K](continuation: (T) => Option[K]): Option[K] = wrapped match {
    case Some(value) => continuation(value)
    case None => None
  }

}

object Nullable {
  /**
   * To make option value nullable
   *
   * @param opt Value being transformed.
   * @tparam T Type of the value.
   * @return Nullable[T]
   */
  implicit def optionToNullable[T](opt: Option[T]): Nullable[T] = new Nullable[T](opt)

}