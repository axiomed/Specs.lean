import Lean
import Specs.Runner
import Specs.Config
import Specs.Core
import Specs.Display

namespace Specs.Macro

/-! Module for macros for execution of tests -/

def executeTest (term : Specs.Core.Specs) : Lean.Elab.TermElabM Unit :=
  let result := Specs.Runner.executePure default term
  let string := Specs.Display.displayMultiple result
  if Array.any result (·.testTree.failed) then
    throwError string
  else
    Lean.logInfo string

macro "#test " term:term : command => `(#eval Specs.Macro.executeTest $term)

macro "suite" name:ident ":=" term:term : command => `(def $name : Specs.Core.Specs := $term)

end Specs.Macro
