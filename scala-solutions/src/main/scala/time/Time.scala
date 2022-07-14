//
//  Time.scala
//  scala-solutions
//
//  Created by d-exclaimation on 13:41.
//

package time

import scala.annotation.targetName


case class Time(totalSeconds: Int) {
  def seconds: Int = totalSeconds % 60
  def minutes: Int = totalSeconds % (60 * 60) / 60
  def hours: Int = totalSeconds % (60 * 60 * 24) / (60 * 60)
  def days: Int = totalSeconds % (60 * 60 * 24 * 30) / (60 * 60 * 24)
  def months: Int = totalSeconds % (60 * 60 * 24 * 365) / (60 * 60 * 24 * 30)
  def years: Int = totalSeconds / (60 * 60 * 24 * 365)

  override def toString = s"${
    if (years > 0) s"$years year(s), " else ""
  }${
    if (months > 0) s"$months month(s), " else ""
  }${
    if (days > 0) s"$days day(s), " else ""
  }${
    if (hours > 0) s"$hours hour(s), " else ""
  }${
    if (minutes > 0) s"$minutes minute(s), " else ""
  }${
    if (seconds > 0) s"$seconds second(s), " else ""
  }"

  @targetName("Add")
  def +(other: Time) = new Time(totalSeconds + other.totalSeconds)

  @targetName("Subtract")
  def -(other: Time) = new Time(scala.math.max(totalSeconds - other.totalSeconds, 0))
}

object Time {
  extension (i: Int) {
    def seconds = new Time(i)
    def minutes = new Time(i * 60)
    def hours = new Time(i * 3600)
    def days = new Time(i * 3600 * 24)
    def months = new Time(i * 3600 * 24 * 30)
    def years = new Time(i * 3600 * 24 * 366)
  }
}
