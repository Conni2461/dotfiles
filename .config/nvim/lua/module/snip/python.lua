local U = require'snippets.utils'

local python = {
  ["#!"] = [[#!/bin/python]],
  ["#!2"] = [[
#!/usr/bin/env python2
# -*- coding: utf-8 -*-]],
  imp = [[import $0]],
  uni = U.match_indentation [[
def __unicode__(self):
    $0]],
  from = [[from $1 import $0]],
  docs = [[
"""
File:   ${=vim.fn.expand("%:t")}
Author: ${2=vim.g.snips_author}
Email:  ${3=vim.g.snips_email}
Github: ${4=vim.g.snips_github}
Description: $0
"""]],
  sk = [[@unittest.skip(${1:skip_reason})]],
  wh = U.match_indentation [[
while $1:
    $0]],
  dowh = U.match_indentation [[
while True:
    $1
    if $0:
        break]],
  with = [[
with ${1:expr} as ${2:var}:
    $0]],
  awith = [[
async with ${1:expr} as ${2:var}:
    $0]],
  cl = U.match_indentation [[
class $1($2):
    """${3:docstring for $1}"""
    def __init__(self, $4):
        ${5:super($1, self).__init__()}
        self.$4 = $4
        $0]],
  cla = U.match_indentation [[
class $1:
    """${2:description}"""]],
  clai = U.match_indentation [[
class $1:
    """${2:description}"""
    def __init__(self, $3):
        $0]],
  def = U.match_indentation [[
def $1($2):
    """${3:docstring for $1}"""
    $0]],
  deff = U.match_indentation [[
def $1($2):
    $0]],
  adef = U.match_indentation [[
async def $1($2):
    """${3:docstring for $1}"""
    $0]],
  adeff = U.match_indentation [[
async def $1($2):
    $0]],
  defi = U.match_indentation [[
def __init__(self, $1):
    $0]],
  defm = U.match_indentation [[
def $1(self, $2):
    $0]],
  adefm = U.match_indentation [[
async def $1(self, $2):
    $0]],
  property = U.match_indentation [[
def $1():
    doc = "${2:The $1 property.}"
    def fget(self):
        ${3:return self._$1}
    def fset(self, value):
        ${4:self._$1 = value}
    def fdel(self):
        ${5:del self._$1}
    return locals()
$1 = property(**$1())]],
  ["if"] = U.match_indentation [[
if $1:
    $0]],
  el = U.match_indentation [[
else:
    $0]],
  ei = U.match_indentation [[
elif $1:
    $0]],
  ["for"] = U.match_indentation [[
for ${1:item} in $2:
    $0]],
  cutf8 = [[# -*- coding: utf-8 -*-]],
  clatin1 = [[# -*- coding: latin-1 -*-]],
  cascii = [[# -*- coding: ascii -*-]],
  ld = [[${1:var} = lambda ${2:vars} : ${3:action}]],
  ret = [[return $0]],
  sa = [[self.$1 = $1]],
  try = U.match_indentation [[
try:
    $1
except $2 as ${3:e}:
    ${4:raise $3}]],
  trye = U.match_indentation [[
try:
    $0
except $2 as ${3:e}:
    ${4:raise $3}
else:
    $1]],
tryf = U.match_indentation [[
try:
    $0
except $2 as ${3:e}:
    ${4:raise $3}
finally:
    $1]],
  tryef = U.match_indentation [[
try:
    $0
except $2 as ${3:e}:
    ${4:raise $3}
else:
    $5
finally:
    $1]],
  ifmain = U.match_indentation [[
if __name__ == '__main__':
    $0]],
  ["_"] = [[__${1:init}__]],
  pdb = [[__import__('pdb').set_trace()]],
  bpdb = [[__import__('bpdb').set_trace()]],
  ipdb = [[__import__('ipdb').set_trace()]],
  iem = [[__import__('IPython').embed()]],
  rpdb = [[__import__('rpdb').set_trace()]],
  wdb = [[__import__('wdb').set_trace()]],
  ptpython = [[__import__('ptpython.repl', fromlist=('repl')).embed(globals(), locals(), vi_mode=${1:False}, history_filename=${2:None})]],
  pudb = [[__import__('pudb').set_trace()]],
  pudbr = U.match_indentation [[
from pudb.remote import set_trace
set_trace()]],
  nosetrace = [[__import__('nose').tools.set_trace()]],
  pprint = [[__import__('pprint').pprint($1)]],
  ["\""] = U.match_indentation [[
"""${1:doc}
"""]],
  ["a="] = [[self.assertEqual($1, $2)]],
  test = U.match_indentation [[
def test_${1:description}($2):
    $0]],
  testcase = U.match_indentation [[
class ${1:ExampleCase}(unittest.TestCase):
    def test_${2:description}(self):
        $0]],
  tgwt = U.match_indentation [[
# given: $1
# when: $2
# then: $3]],
  fut = [[from __future__ import $0]],
  getopt = U.match_indentation [[
try:
    # Short option syntax: "hv:"
    # Long option syntax: "help" or "verbose="
    opts, args = getopt.getopt(sys.argv[1:], "${1:short_options}", [${2:long_options}])

except getopt.GetoptError, err:
    # Print debug info
    print str(err)
    ${3:error_action}

for option, argument in opts:
    if option in ("-h", "--help"):
        $0
    elif option in ("-v", "--verbose"):
        verbose = argument]],
  addp = [[parser = ${1:argparse.}ArgumentParser()]],
  addsp = [[$1 = parser.add_subparsers().add_parser("$2")]],
  addarg = [[parser.add_argument("${1:short_arg}", "${2:long_arg}", default=${3:None}, help="${4:Help text}")]],
  addnarg = [[parser.add_argument("${1:arg}", nargs="${2:*}", default"${3:None}, help="${4:Help text}")]],
  addaarg = [[parser.add_argument("${1:arg}", "${2:long_arg}", action="${3:store_true}", default=${4:False}, help="${5:Help text}")]],
  pargs = [["${1:return }"parser.parse_args()]],
  glog = U.match_indentation [[
import logging
LOGGER = logging.getLogger(${1:__name__})]],
  le = [[LOGGER.error(${1:msg})]],
  lg = [[LOGGER.debug(${1:msg})]],
  lw = [[LOGGER.warning(${1:msg})]],
  lc = [[LOGGER.critical(${1:msg})]],
  li = [[LOGGER.info(${1:msg})]],
  epydoc = U.match_indentation [[
"""${1:Description}

@param ${2:param}: ${3: Description}
@type  $2: ${4: Type}

@return: ${5: Description}
@rtype : ${6: Type}

@raise e: ${7: Description}
"""]],
  dol = U.match_indentation [[
def ${1:__init__}(self, *args, **kwargs):
    super(${2:ClassName}, self).$1(*args, **kwargs)]],
  kwg = [[self.${1:var_name} = kwargs.get('$1', ${2:None})]],
  lkwg = [[${1:var_name} = kwargs.get('$1', ${2:None})]],
  args = [[*args${1:,}$0]],
  kwargs = [[**kwargs${1:,}$0]],
  akw = [[*args, **kwargs${1:,}$0]],
  lcp = [===[[$1 for $2 in $3]$0]===],
  dcp = [[{$1: $2 for $3 in $4}$0]],
  scp = [[{$1 for $2 in $3}$0]],
  contain = U.match_indentation [[
def __len__(self):
    ${1:pass}

def __getitem__(self, key):
    ${2:pass}

def __setitem__(self, key, value):
    ${3:pass}

def __delitem__(self, key):
    ${4:pass}

def __iter__(self):
    ${5:pass}

def __reversed__(self):
    ${6:pass}

def __contains__(self, item):
    ${7:pass}]],
  context = U.match_indentation [[
def __enter__(self):
    ${1:pass}

def __exit__(self, exc_type, exc_value, traceback):
    ${2:pass}]],
  attr = U.match_indentation [[
def __getattr__(self, name):
    ${1:pass}

def __setattr__(self, name, value):
    ${2:pass}

def __delattr__(self, name):
    ${3:pass}]],
  desc = U.match_indentation [[
def __get__(self, instance, owner):
    ${1:pass}

def __set__(self, instance, value):
    ${2:pass}

def __delete__(self, instance):
    ${3:pass}]],
  cmp = U.match_indentation [[
def __eq__(self, other):
    ${1:pass}

def __ne__(self, other):
    ${2:pass}

def __lt__(self, other):
    ${3:pass}

def __le__(self, other):
    ${4:pass}

def __gt__(self, other):
    ${5:pass}

def __ge__(self, other):
    ${6:pass}

def __cmp__(self, other):
    ${7:pass}]],
  repr = U.match_indentation [[
def __repr__(self):
    ${1:pass}

def __str__(self):
    ${2:pass}

def __unicode__(self):
    ${3:pass}]],
  numeric = [[
def __add__(self, other):
    ${1:pass}

def __sub__(self, other):
    ${2:pass}

def __mul__(self, other):
    ${3:pass}

def __div__(self, other):
    ${4:pass}

def __truediv__(self, other):
    ${5:pass}

def __floordiv__(self, other):
    ${6:pass}

def __mod__(self, other):
    ${7:pass}

def __divmod__(self, other):
    ${8:pass}

def __pow__(self, other):
    ${9:pass}

def __lshift__(self, other):
    ${10:pass}

def __rshift__(self, other):
    ${11:pass}

def __and__(self, other):
    ${12:pass}

def __xor__(self, other):
    ${13:pass}

def __or__(self, other):
    ${14:pass}

def __neg__(self):
    ${15:pass}

def __pos__(self):
    ${16:pass}

def __abs__(self):
    ${17:pass}

def __invert__(self):
    ${18:pass}

def __complex__(self):
    ${19:pass}

def __int__(self):
    ${20:pass}

def __long__(self):
    ${21:pass}

def __float__(self):
    ${22:pass}

def __oct__(self):
    ${22:pass}

def __hex__(self):
    ${23:pass}

def __index__(self):
    ${24:pass}

def __coerce__(self, other):
    ${25:pass}]],
}

local m = {}

m.get_snippets = function()
  return python
end

return m
