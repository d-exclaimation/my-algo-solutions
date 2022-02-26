//
//  Clock.scala
//  Scala-Solutions
//
//  Created by d-exclaimation on 6:48 AM.
//

package math

object Clock {

  /**
   * Clock angle from the hour and minute hand
   *
   * @param hours  Floored value of the hour hand or the hour of time.
   * @param minute Value of the minute hand * 5 or the minutes passed.
   * @return A Double representing the angle.
   */
  def clockAngle(hours: Int, minute: Int): Double =
    val angleEach = 360 / 12
    val hourHand: Double = (hours + (minute / 60.0)) * angleEach
    val minuteHand: Double = (minute / 5.0) * angleEach
    val res = Math.abs(minuteHand - hourHand)
    if (res == 360) 0 else res


  extension (s: String) {
    def time24h: (Int, Int) =
      s.split(":").toSeq.flatMap(_.toIntOption) match {
        case Seq(hour, minute) =>
          (hour, minute)
        case _ =>
          (0, 0)
      }
  }

  def diffTime(time1: String, time2: String): Int =
    val (hour1, minute1) = time1.time24h
    val (hour2, minute2) = time2.time24h
    val diff1 = hour1 * 60 + minute1 - hour2 * 60 - minute2
    val diff2 = hour2 * 60 + minute2 - hour1 * 60 - minute1
    val res = Seq(diff1, diff2, 24 * 60 - diff1, 24 * 60 - diff2).map(_.abs).min
    res


  def minIntervalTimeString(times: Seq[String]): Int =
    times
      .zipWithIndex
      .map { case (str, i) =>
        times
          .indices
          .filter(_ != i)
          .map(times.apply)
          .map(curr => diffTime(str, curr))
          .min

      }
      .min

}
