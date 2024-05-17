import Lake
open Lake DSL

package «Specs» where
  -- add package configuration options here

lean_lib «Specs» where
  -- add library configuration options here

lean_exe «specs_test» where
  root := `Tests
  supportInterpreter := true

require Colorized from git "https://github.com/axiomed/Colorized.lean.git"
require Cli from git "https://github.com/leanprover/lean4-cli.git"
