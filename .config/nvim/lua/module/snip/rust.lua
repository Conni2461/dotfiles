local indent = require'snippets.utils'.match_indentation

local rust = {
  ["fn"] = indent [[
fn $1($2)$3 {
  $0
}]],
  ["pfn"] = indent [[
pub fn $1($2)$3 {
  $0
}]],
  ["afn"] = indent [[
async fn $1($2)$3 {
  $0
}]],
["pafn"] = indent [[
pub async fn $1($2)$3 {
  ${0}
}]],
["bench"] = indent [[
#[bench]
fn $1(b: &mut test::Bencher) {
  b.iter(|| {
    $0
  })
}]],
["new"] = indent [[
pub fn new($2) -> ${1:Self} {
  $1 { $3 }
}]],
["main"] = indent [[
pub fn main() {
  $0
}]],
  ["let"]   = [[let $1 = $2;]],
  ["lett"]  = [[let $1: $2 = $3;]],
  ["letm"]  = [[let mut $1 = $2;]],
  ["lettm"] = [[let mut $1: $2 = $3;]],
  ["pri"]   = [[print!("$1");]],
  ["pln"]   = [[println!("$1");]],
  ["fmt"]   = [[format!("$1{$2}", $3);]],
  ["d"]     = [[dbg!($0)]],
  ["d;"]    = indent [[
dbg!(&${1});
${0}]],
  ["ec"] = [[extern crate $1;]],
  ["ecl"] = indent [[
#[macro_use]
extern crate log;]],
  ["mod"] = indent [[
mod $1 {
  $0
} /* $1 */]],
  ["as"] = [[assert!(${1:predicate});]],
  ["ase"] = [[assert_eq!(${1:expected}, ${2:actual});]],
  ["test"] = indent [[#[test]
fn $1_test() {
  $0
}]],
  ["testmod"] = indent[[#[cfg(test)]
mod tests {
  use super::*;

  test$0
}]],
  ["ig"] = "#[ignore]",
  ["allow"] = "#[allow(${1:unused_variables})]",
  ["cfg"] = '#[cfg(${1:target_os = "linux"})]',
  ["feat"] = '#![feature($1)]',
  ["der"] = '#[derive(${1:Debug})]',
  ["attr"] = '#[${1:inline}]',
  ["crate"] = [===[// Crate name
#![crate_name = "${1:crate_name}"]
// Additional metadata attributes
#![desc = "${2:Descrption.}"]
#![license = "${3:MIT}"]
#![comment = "${4:Comment.}"]
// Specify the output type
#![crate_type = "${5:lib}"]]===],
  ["opt"] = [[Option<${1:i32}>]],
  ["res"] = [[Result<${1:~str}, ${2:()}>]],
  ["if"] = indent [[if ${1} {
  $0
}]],
  ["ife"] = indent [[if $1 {
  $0
} else {
  $2
}]],
  ["ifl"] = indent [[if let ${1:Some($2)} = $3 {
  $0
}]],
  ["el"] = indent [[else {
  $0
}]],
  ["eli"] = indent [[else if $1 {
  $0
}]],
  ["mat"] = indent [[match $1 {
  $2 => $3
}]],
  ["case"] = [[${1:_} => ${2:expression}]],
  ["="] = [[=> $0]],
  ["loop"] = indent [[loop {
  $0
}]],
  ["wh"] = indent [[while ${1:condition} {
  $0
}]],
  ["whl"] = indent [[while let ${1:Some($2)} = $3 {
  $0
}]],
  ["for"] = indent [[for ${1:i} in $2 {
  $0
}]],
  ["st"] = indent [[struct $1 {
  $0
}]],
  ["impl"] = indent [[impl ${1:Type/Trait}${2: for $3} {
  $0
}]],
  ["stn"] = indent [[pub struct $1 {
  $0

impl$2 $1$2 {
  pub fn new($4) -> Self {
    $1 { $5 }
  }
}
}]],
  ["ty"] = [[type ${1:NewName} = $2]],
  ["enum"] = indent [[enum ${1:Name} {
  $2,
}]],
  ["penum"] = indent [[pub enum ${1:Name} {
  $2,
}]],
  ["trait"] = indent [[trait ${1:Name} {
  $0
}]],
  ["drop"] = indent [[impl Drop for $1 {
  fn drop(&mut self) {
    $0
  }
}]],
  ["ss"] = [[static $1: &'static str = "$0";]],
  ["stat"] = [[static $1: ${2:usize} = $0;]],
  ["scoped"] = indent [[thread::scoped(${1:move }|| {
  $0
});]],
  ["spawn"] = indent [[thread::spawn(${1:move }|| {
  ${0}
});]],
  ["chan"] = [[let (${1:tx}, ${2:rx}): (Sender<${3:i32}>, Receiver<${4:i32}>) = channel();]],
  ["asref"] = indent [[impl AsRef<${1:Ref}> for ${2:Type} {
  fn as_ref(&self) -> &${3:$1} {
    &self.${0:field}
  }
}]],
  ["asmut"] = indent [[impl AsMut<${1:Ref}> for ${2:Type} {
  fn as_mut(&mut self) -> &mut ${3:$1} {
    &mut self.${0:field}
  }
}]],
  ["fd"] = [[${1:name}: ${2:Type},]],
  ["||"] = [[${1:move }|$2| { $3 }]],
  ["|}"] = [[${1:move }|$2| {
  $3
}]],
  ["macro"] = indent [[macro_rules! ${1:name} {
  (${2:matcher}) => (
    $3
  )
}]],
  ["boxp"] = [[Box::new($0)]],
  ["rc"] = [[Rc::new($0)]],
  ["unim"] = [[unimplemented!()]],
  ["use"] = [[use ${1:std::$2};]]
}

local m = {}

m.get_snippets = function()
  return rust
end

return m
