-- ~/.config/nvim/lua/custom/snippets/javascript_common.lua
local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- Online judge용 주석 Header (JavaScript)
  s(
    "header-comment_oj",
    fmt(
      [[
/** 
 * -----------------------------------------------------------
 * Sub    : [{}]
 * Link   : {}
 * Level  :   
 * Tag    : JS, 
 * Memo
 * -----------------------------------------------------------
 */

// [환경 설정]
const TEST_MODE = true;
let input;

// [입력 처리]
if (TEST_MODE) {{
  // 로컬 테스트 (input.txt 파일 읽기)
  const filePath = require('path').join(__dirname, 'input.txt');
  input = require('fs').readFileSync(filePath, 'utf-8').trim().split('\n');
}} else {{
  // 제출 환경 (표준 입력)
  input = require('fs').readFileSync(0, 'utf-8').trim().split('\n');
}}
]],
      {
        -- 1. 플랫폼 선택
        c(1, { i(nil, "BOJ"), i(nil, "Programmers") }),

        -- 2. 링크 + 사용자 입력 가능
        d(2, function(args)
          local platform = args[1][1]
          local prefix = ""
          if platform == "BOJ" then
            prefix = "https://www.acmicpc.net/problem/"
          elseif platform == "Programmers" then
            prefix = "https://school.programmers.co.kr/learn/courses/30/lessons/"
          end
          -- prefix 포함 insert node, 사용자가 뒤에 문제 번호 입력 가능
          return sn(nil, i(1, prefix))
        end, { 1 }),
      }
    )
  ),

  -- 일반 파일용 주석 Header
  s(
    "header-comment_file",
    fmt(
      [[
/** 
 * ------------------------------------------------------------
 * File     : {}
 * Brief    : 
 * Author   : {}
 * Date     : {}
 * Version  : 
 * History
 * ------------------------------------------------------------
 */

]],
      {
        i(1, "current_file"),
        i(2, "송용훈"),
        f(function()
          return os.date "%Y-%m-%d"
        end, {}),
      }
    )
  ),
}
