local indent = require'snippets.utils'.match_indentation

local cpp = {
  incc = [[#include <${1:iostream}>]],
  array = [[std::array<${1:T}, ${2:N}> $3;]],
  vector = [[std::vector<${1:T}> $2;]],
  deque = [[std::deque<${1:T}> $2;]],
  flist = [[std::forward_list<${1:T}> $2;]],
  list = [[std::list<${1:T}> $2;]],
  set = [[std::set<${1:T}> $2;]],
  map = [[std::map<${1:Key}, ${2:T}> $3;]],
  mset = [[std::multiset<${1:T}> $2;]],
  mmap = [[std::multimap<${1:Key}, ${2:T}> $3;]],
  uset = [[std::unordered_set<${1:T}> $2;]],
  umap = [[std::unordered_map<${1:Key}, ${2:T}> $3;]],
  umset = [[std::unordered_multiset<${1:T}> $2;]],
  ummap = [[std::unordered_multimap<${1:Key}, ${2:T}> $3;]],
  stack = [[std::stack<${1:T}> $2;]],
  queue = [[std::queue<${1:T}> $2;]],
  pqueue = [[std::priority_queue<${1:T}> $2;]],
  msp = [[std::shared_ptr<${1:T}> $2 = std::make_shared<$1>($3);]],
  amsp = [[auto $1 = std::make_shared<${2:T}>($3);]],
  mup = [[std::unique_ptr<${1:T}> $2 = std::make_unique<$1>($3);]],
  amup = [[auto $1 = std::make_unique<${2:T}>($3);]],
  pri = [[private]],
  pro = [[protected]],
  pub = [[public]],
  fr = [[friend]],
  mu = [[mutable]],
  cl = indent [[
/*! \class $1
 *  \brief ${3:Brief class description}
 *
 *  ${4:Detailed description}
 */
class $1
{
public:
  $1(${2});
  virtual ~$1();

protected:
  m_${5}; /*!< ${6:Member description} */
};]],
  mfun = indent [[
${4:void} $1::$2($3) {
  $0
}]],
  dmfun0 = indent [[
/*! \brief ${4:Brief function description here}
 *
 *  ${5:Detailed description}
 *
 * \return ${6:Return parameter description}
 */
${3:void} $1::$2() {
  $0
}]],
  dmfun1 = indent [[
/*! \brief ${6:Brief function description here}
 *
 *  ${7:Detailed description}
 *
 * \param $4 ${8:Parameter description}
 * \return ${9:Return parameter description}
 */
${5:void} $1::$2($3 $4) {
  $0
}]],
  dmfun2 = indent [[
/*! \brief ${8:Brief function description here}
 *
 *  ${9:Detailed description}
 *
 * \param $4 ${10:Parameter description}
 * \param $6 ${11:Parameter description}
 * \return ${12:Return parameter description}
 */
${7:void} $1::$2($3 $4,$5 $6) {
  $0
}]],
  ns = indent [[
namespace $1 {
  $0
} /* namespace $1 */]],
  ans = indent [[
namespace {
  $0
}]],
  cout = [[std::cout << $1 << std::endl;]],
  cin = [[std::cin >> $1;]],
  sca = [[static_cast<${1:unsigned}>(${2:expr})${3}]],
  dca = [[dynamic_cast<${1:unsigned}>(${2:expr})${3}]],
  rca = [[reinterpret_cast<${1:unsigned}>(${2:expr})${3}]],
  cca = [[const_cast<${1:unsigned}>(${2:expr})${3}]],
  fore = indent [[
for (${1:auto} ${2:i} : ${3:container}) {
  $0
}]],
  iter = indent [[
for (${1:std::vector}<${2:type}>::${3:const_iterator} ${4:i} = ${5:container}.begin(); $4 != $5.end(); ++$4) {
  $0
}]],
  itera = indent [[
for (auto ${1:i} = ${2:container}.begin(); $1 != $2.end(); ++$1) {
  ${3:std::cout << *$1 << std::endl;}
}]],
  ld = [[[$1]($2){$3};]],
  lld = indent [[
[$1]($2) {
  $3
};]],
  try = indent [[
try {
  $0
} catch($2) {
  $1
}]],
  af = indent [[
auto ${1:name}($2) -> ${3:void} {
  $0
};]],
}

local m = {}

m.get_snippets = function()
  return vim.tbl_extend('force', require('module/snip/c').get_snippets(), cpp)
end

return m
