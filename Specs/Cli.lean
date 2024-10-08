import Specs.Core
import Specs.Runner
import Specs.Matchers
import Cli

namespace Specs
open Specs.Core Specs.Runner Cli

/-!
Module for interacting with the command line.
-/

private def runCmd (specs: Specs) (parsed : Parsed) : IO UInt32 := do
  -- TODO: turn this into a config file
  let config := Config.mk
    (parsed.hasFlag "verbose")
    (parsed.hasFlag "bail")
    (parsed.hasFlag "noColors")
  executeIO config specs

private def specsCmd (specs: Specs) : Cmd := `[Cli|
  testsCmd VIA runCmd specs; ["0.0.1"]
  "A utility to run tests for a project"

  FLAGS:
    verbose; "Prints more information about each test"
    bail; "Stops the test suite after the first failure"
    noColors; "Disables colored output"
]

/-- Runs a test suite using the given arguments. -/
def runCli (suite: Specs) (args : List String) : IO UInt32 :=
  (specsCmd suite).validate args

end Specs
