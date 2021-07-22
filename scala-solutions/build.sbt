ThisBuild / scalaVersion := "2.13.6"
ThisBuild / organization := "io.solutoon"

lazy val app = (project in file("."))
  .settings(
    name := "Scala-Solutions"
  )