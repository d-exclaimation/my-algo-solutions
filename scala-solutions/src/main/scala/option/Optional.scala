//
//  Optional.scala
//  dotty-solutions
//
//  Created by d-exclaimation on 17:09..
//
package option

/**
 * Extension for Option Type
 *
 * @tparam T Value wrapped in Option.
 */
extension[T] (opt: Option[T]) {
  /**
   * Fallback Operator
   *
   * @param fallback Value given if Option is None.
   * @return Value wrapped or the fallback.
   */
  def ??(fallback: T): T = opt match
    case Some(value) => value
    case None => fallback

  /**
   * Fallback Method
   *
   * @param fallback Value given if Option is None.
   * @return Value wrapped or the fallback.
   */
  def otherwise(fallback: T): T = opt.??(fallback)

  /**
   * Fallback chaining (Equivalent of `_.map`)
   * ---
   * Perform method / function chaining safely
   *
   * @tparam K Value after transformation.
   * @param perform Function being performed.
   * @return Option with the returned value wrapped.
   */
  def ?>[K](perform: T => K): Option[K] = opt match
    case Some(value) => Some(perform(value))
    case None => None

  /**
   * Fallback option chaining (Equivalent of `_.flatMap`)
   * ---
   * Perform method / function chaining safely
   *
   * @tparam K Value after transformation.
   * @param perform Function being performed.
   * @return Option with the returned value wrapped.
   */
  def ?>>[K](perform: T => Option[K]): Option[K] = opt match
    case Some(value) => perform(value)
    case None => None
}