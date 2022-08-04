package object graph {
  def parse(graphString: String): (Seq[(Int, Int, Option[Int])], Boolean, Boolean, Int) = {
    graphString.trim.split('\n').map(_.trim.split(' ').toSeq).toSeq match {
      case header +: edgeLines =>
        val isWeighted = header.length == 3
        val isUndirected = header.headOption.exists(_.toUpperCase == "U")
        val n = header(1).toInt

        val edges = edgeLines.filter(_.length >= 2).map(line =>
          (line.head.toInt, line(1).toInt, if (isWeighted) line(2).toIntOption else None)
        )

        (edges, isWeighted, isUndirected, n)

      case _ => throw new Error("Invalid format for graph")
    }
  }

  implicit final class VertexPath(path: Seq[Int]) {
    def pathString: String = path.map(_.toString).mkString(" -> ")
  }

  implicit final class MaybeVertexPath(path: Option[Seq[Int]]) {
    def pathString: String = path.map(_.pathString).getOrElse("No path")
  }
}
