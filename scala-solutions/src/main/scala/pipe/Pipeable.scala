//
//  PipeOperation.scala
//  Scala-Solutions
//
//  Created by d-exclaimation on 12:51 PM.
//

package pipe

import scala.language.implicitConversions

/** Pipeable value which any value
  *
  * @param wrapped
  *   Any
  * @tparam T
  *   Any
  */
class Pipeable[T](val wrapped: T) {

  /** Pipe a function [Operator]
    *
    * ''* :: Piping function can do side effects, but not perform mutation''
    *
    * @param pipe
    *   Piping *pure function.
    * @tparam K
    *   Transformation result type.
    * @return
    *   A new value of type K.
    */
  def |>[K](pipe: (T) => K): K = pipe(this.wrapped)

  /** Pipe a function [Method]
    *
    * ''* :: Piping function can do side effects, but not perform mutation''
    *
    * @param pipe
    *   Piping *pure function.
    * @tparam K
    *   Transformation result type.
    * @return
    *   A new value of type K.
    */
  def pipe[K](pipe: (T) => K): K = pipe(this.wrapped)

  /** Perform a tap on the value and return original value
    *
    * @param effect
    *   Side effect perform (Must not mutate the data piped).
    * @return
    *   The initial value piped.
    */
  def tap(effect: (T) => Unit): T = {
    effect(this.wrapped);
    this.wrapped
  }

  /** Checking whether this value can be piped
    *
    * @return
    *   boolean
    */
  def isPipeable: Boolean = true
}

object Pipeable {

  /** To make value pipeable
    *
    * @param s
    *   Value being transformed.
    * @tparam T
    *   Type of the value.
    * @return
    *   Pipeable[T]
    */
  implicit def valueToPipeable[T](s: T): Pipeable[T] = new Pipeable[T](s)

}
