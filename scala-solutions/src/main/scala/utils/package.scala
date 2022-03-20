package object utils {
  extension (b: Boolean) {
    def not: Boolean = !b
  }

  def dfsBacktrack[Candidate, Input, Output](
    candidate: Candidate,
    input: Input,
    output: Output,
    isSolution: (Candidate, Input) => Boolean,
    shouldPrune: (Candidate) => Boolean,
    children: (Candidate, Input) => Seq[Candidate],
    addToOutput: (Candidate, Output) => Output
  ): Output =
    if (shouldPrune(candidate)) output
    else if (isSolution(candidate, input)) addToOutput(candidate, output)
    else children(candidate, input).foldLeft(output) {
      case (out, childCandidate) => dfsBacktrack(
        childCandidate, input, out, isSolution, shouldPrune, children, addToOutput
      )
    }

}
