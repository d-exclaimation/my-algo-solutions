//
//  Pipeable.scala
//  dotty-solutions
//
//  Created by d-exclaimation on 2:52 PM.
//
package pipe

/**
 * Pipeable type
 */
opaque type Pipeable[T] = T

/**
 * Extension for any value that is Pipeable
 *
 * @tparam P Type of value being piped.
 */
extension[P] (p: Pipeable[P]) {
  /**
   * Pipe a function [Operator]
   *
   * _* :: Piping function can do side effects, but not perform mutation_
   *
   * @param transform Piping *pure function.
   * @tparam T Transformation result type.
   * @return A new value of type T.
   */
  def |>[T](transform: P => T): T = transform(p)

  /**
   * Pipe a function [Method]
   *
   * _* :: Piping function can do side effects, but not perform mutation_
   *
   * @param transform Piping *pure function.
   * @tparam T Transformation result type.
   * @return A new value of type T.
   */
  def pipe[T](transform: P => T): T = transform(p)

  /**
   * Tap a function with the value and return the initial value [Method]
   *
   * _* :: Effect function can do side effects, but not perform mutation_
   *
   * @param effect Effect function.
   * @return The initial value.
   */
  def tap(effect: P => Unit): P =
    effect(p)
    p
}