//
//  DfsBacktrackable.scala
//  scala-solutions
//
//  Created by d-exclaimation on 3:33 PM.
//


package utils

trait DfsBacktrackable[Candidate, Input, Output] {
  def shouldPrune(candidate: Candidate): Boolean = false
  
  def isSolution(candidate: Candidate, input: Input): Boolean

  def children(candidate: Candidate, input: Input): Seq[Candidate]

  def addToOutput(candidate: Candidate, output: Output): Output

  def backtrack(candidate: Candidate, input: Input, output: Output): Output =
    if (shouldPrune(candidate)) output
    else if (isSolution(candidate, input)) addToOutput(candidate, output)
    else children(candidate, input).foldLeft(output) {
      case (currOut, childCandidate) => backtrack(childCandidate, input, currOut)
    }
}
