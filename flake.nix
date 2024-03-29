{
  description = ''Game Engine'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."alasgar-main".dir   = "main";
  inputs."alasgar-main".owner = "nim-nix-pkgs";
  inputs."alasgar-main".ref   = "master";
  inputs."alasgar-main".repo  = "alasgar";
  inputs."alasgar-main".type  = "github";
  inputs."alasgar-main".inputs.nixpkgs.follows = "nixpkgs";
  inputs."alasgar-main".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}