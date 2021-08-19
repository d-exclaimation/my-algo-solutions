//
//  Logger.scala
//  scala-solutions
//
//  Created by d-exclaimation on 12:19 PM.
//

package logging

import java.util.UUID

object Log {

  import java.time.LocalDateTime

  def time[T](f: => T): T = {
    val start = System.nanoTime()
    val result = f
    val end = System.nanoTime()
    log(s"${(end - start) / 1e6}ms")
    return result
  }

  def scope[T](name: String)(f: => T): T = {
    log(s"$name started!")
    val result = f
    log(s"$name ended!")
    return result
  }

  def timeScope[T](name: String)(f: => T): T = {
    log(s"$name started!")
    val start = System.nanoTime()
    val result = f
    val end = System.nanoTime()
    log(s"$name ended with (${(end - start) / 1e6}ms)")
    return result
  }

  def req[T](method: String, path: String)(f: => T): T = {
    val start = System.nanoTime()
    val result = f
    val end = System.nanoTime()
    log(s"$method [ $path ] (${(end - start) / 1e6}ms)")
    return f
  }

  def log(message: Any): Unit = {
    val timestamp = LocalDateTime.now().toString()
    log(name = timestamp, s"$message")
  }

  def log(name: String, message: String): Unit =
    println(s"[$name]: $message")
}