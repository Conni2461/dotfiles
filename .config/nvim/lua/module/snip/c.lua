local indent = require'snippets.utils'.match_indentation

local c = {
  inc = [[#include <${1:stdio}.h>]],
  Inc = [[#include "${=vim.fn.expand("%:t:r")}.h"]],
  main = [[
int main(int argc, char *argv[]) {
  $0
  return 0;
}]],
  mainn = [[
int main(void) {
  $0
  return 0;
}]],
  ndef = [[
#ifndef $1
#define $1 $2
#endif /* ifndef $1 */]],
  def = [[#define $0]],
  ifdef = [[
#ifdef $1
${2:#define $0}
#endif]],
  ["#if"] = [[
#if $1
  $0
#endif // $1]],
  guard = [[
#ifndef _${1:header name|S.v:upper():gsub("%s+", "_")}_H_
#define _$1_H_
$0
#endif // _${|S[1]:gsub("%s+", "_")}_H_]],
  nocxx = [[
#ifdef __cplusplus
extern "C" {
#endif
$0
#ifdef __cplusplus
} // extern "C"
#endif]],
  ["if"] = indent [[
if (${1:true}) {
  $0
}]],
  ife = indent [[
if (${1:true}) {
  $2
} else {
  $0
}]],
  el = indent [[
else {
  $0
}]],
  elif = indent [[
else if (${1:true}) {
  $0
}]],
  ifi = [[if (${1:true}) $0;]],
  t = [[$1 ? $2 : $3;]],
  switch = indent [[
switch ($1) {
  case $2:
    $0
    ${3:break;}$4
  default:
    $5
}]],
  switchndef = indent [[
switch ($1) {
  case $2:
    $0
    ${3:break;}$4
}]],
  case = indent [[
case $1:
  $0
  ${2:break;}$3]],
  ret = [[return $0;]],
  ["for"] = indent [[
for (int ${1:i} = 0; $1 < ${2:count}; $1${3:++}) {
  $0
}]],
  forr = indent [[
for (int ${1:i} = ${2:0}; ${3:$1 < 10}; $1${4:++}) {
  $0
}]],
  wh = indent [[
while ($1) {
  $0
}]],
  ["do"] = indent [[
do {
  $0
} while ($1);]],
  fun = indent [[
${1:void} $2($3) {
  $0
}]],
  fun0 = indent [[
${1:void} $2() {
  $0
}]],
  dfun0 = indent [[
/*! \brief ${1:Brief function description here}
 *
 *  ${2:Detailed description of the function}
 *
 * \return ${3:Return parameter description}
 */
${4:void} $5()
{
  $0
}]],
  fun1 = indent [[
${1:void} $2($3 $4)
{
  $0
}]],
  dfun1 = indent [[
/*! \brief ${1:Brief function description here}
 *
 *  ${2:Detailed description of the function}
 *
 * \param $3 ${4:Parameter description}
 * \return ${5:Return parameter description}
 */
${6:void} $7($8 $3)
{
  $0
}]],
  fun2 = indent [[
${1:void} $2($3 $4, $5 $6)
{
  $0
}]],
  dfun2 = indent [[
/*! \brief ${1:Brief function description here}
 *
 *  ${2:Detailed description of the function}
 *
 * \param $3 ${4:Parameter description}
 * \param $5 ${6:Parameter description}
 * \return ${7:Return parameter description}
 */
${8:void} $9($10 $3, $11 $5)
{
  $0
}]],
  fun3 = indent [[
${1:void} $2($3 $4, $5 $6, $7 $8)
{
  $0
}]],
  dfun3 = indent [[
/*! \brief ${1:Brief function description here}
 *
 *  ${2:Detailed description of the function}
 *
 * \param $3 ${4:Parameter description}
 * \param $5 ${6:Parameter description}
 * \param $7 ${8:Parameter description}
 * \return ${9:Return parameter description}
 */
${10:void} $11($12 $3, $13 $5, $14 $7)
{
  $0
}]],
  fund = [[${1:void} $2($3);]],
  td = [[typedef ${1:int} ${2:MyCustomType};]],
  st = indent [[
/*! \struct $1
 *  \brief ${2:Brief struct description}
 *
 *  ${3:Detailed description}
 */
struct $1 {
  $0
};]],
  tds = indent [[
/*! \struct $1
 *  \brief ${2:Brief struct description}
 *
 *  ${3:Detailed description}
 */
typedef struct {
  $0
} $1;]],
  enum = indent [[
/*! \enum $1
 *
 *  ${2:Detailed description}
 */
enum $1 { $0 };]],
  tde =  indent[[
/*! \enum $1
 *
 *  ${2:Detailed description}
 */
typedef enum {
  $0
} $1;]],
  pr = [[printf("${1:%s}\n", $2);]],
  fpr = [[fprintf(${1:stderr}, "${2:%s}\n", $3);]],
  prd = [[printf("$1 = %d\n", $1);]],
  prf = [[printf("$1 = %f\n", $1);]],
  prx = [[printf("$1 = %$2\n", $1);]],
  getopt =  indent[[
int choice;
while (1) {
  static struct option long_options[] = {
    /* Use flags like so:
    {"verbose", no_argument, &verbose_flag, 'V'}*/
    /* Argument styles: no_argument, required_argument, optional_argument */
    {"version", no_argument, 0, 'v'},
    {"help", no_argument, 0, 'h'},
    $1
    {0,0,0,0}
  };

  int option_index = 0;

  /* Argument parameters:
    no_argument: " "
    required_argument: ":"
    optional_argument: "::" */

  choice = getopt_long( argc, argv, "vh", long_options, &option_index);

  if (choice == -1)
    break;

  switch(choice) {
    case 'v':
      $2
      break;

    case 'h':
      $3
      break;

    case '?':
      /* getopt_long will have already printed an error */
      break;

    default:
      /* Not sure how to get here... */
      return EXIT_FAILURE;
  }
}

/* Deal with non-option arguments here */
if (optind < argc) {
  while (optind < argc) {
    $0
  }
}]],
}

local m = {}

m.get_snippets = function()
  return c
end

return m
