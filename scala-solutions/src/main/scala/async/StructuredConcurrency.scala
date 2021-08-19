//
//  StructuredConcurrency.scala
//  scala-solutions
//
//  Created by d-exclaimation on 8:03 PM.
//

package async

import scala.concurrent.duration.Duration
import scala.concurrent.{Await, ExecutionContext, Future, Promise}
import scala.util.{Failure, Success, Try}

object StructuredConcurrency {

  // -- Structured Asynchronous Programming

  /**
   * Async function wrapped on Future
   *
   * @param scope   Function scope to be executed.
   * @param context Execution Context Created at.
   * @tparam T Value returned from future.
   * @return Future[T}
   */
  def async[T](scope: => T, context: ExecutionContext = ExecutionContext.global) = Future(scope)(context)


  /**
   * Await function and catch error / failure (s).
   *
   * @param f        Future object being resolved.
   * @param duration Duration allowed to be waited, default to until it's done.
   * @tparam T Returned value from function.
   * @return a try of success with T or failure with error.
   */
  def await[T](f: Future[T], duration: Duration = Duration.Inf) = {
    val future = Await.ready(f, duration)
    future.value match {
      case Some(value) => value
      case _ => Failure(new Error("Async function is never resolved in time"))
    }
  }

  /**
   * Unsafe await version throws an error instead of coupling it on a Try[T]
   *
   * @param f        Future object being resolved.
   * @param duration Duration allowed to be waited, default to until it's done.
   * @tparam T Value returned from future.
   * @return Value returned from future.
   */
  def await_![T](f: Future[T], duration: Duration = Duration.Inf) = Await.result(f, duration)


  // -- Structured Timing Concurrency

  /**
   * Timeout wrapper for future to be cancellable
   *
   * @param f Future of nothing.
   */
  class Timeout(f: Future[Unit]) {
    def cancel(): Unit = {
      async {
        try {
          await_!(f, Duration.Zero)
        } catch {
          case _ => {}
        }
      }
    }
  }

  /**
   * Create a simple timeout mechanism.
   *
   * @param action  Action peformed on timeout.
   * @param timeout Time before execution in miliseconds.
   * @return Future that can be cancelled
   */
  def timeout(action: () => Unit, timeout: Long): Timeout = new Timeout(
    async {
      Thread.sleep(timeout)
      action()
    }
  )

  extension[T] (t: Try[T]) {
    /**
     * Handle try with fallback
     *
     * @param fallback Value given on failure.
     * @return T from Success or the fallback.
     */
    def or(fallback: T): T = t match {
      case Success(value) => value
      case _ => fallback
    }

    /**
     * Get the value directly
     *
     * @return T or throw an exception
     */
    def ! : T = t.get
  }

  //  // Scala 2 Implicit Extensions
  //  implicit class Failable[T](t: Try[T]) {
  //    /**
  //     * Handle try with fallback
  //     *
  //     * @param fallback Value given on failure.
  //     * @return T from Success or the fallback.
  //     */
  //    def or(fallback: T): T = t match {
  //      case Success(value) => value
  //      case _ => fallback
  //    }
  //  }
}
