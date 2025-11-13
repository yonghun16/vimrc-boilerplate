local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local fmt = require("luasnip.extras.fmt").fmt
local f = ls.function_node

return {
  -- Online judge용 주석 Header (Python)
  s(
    "header-comment_oj",
    fmt(
      [[
"""
------------------------------------------------------------
Sub    : [{}] {}
Link   : {}
Level  : 
Tag    : Python, 
Memo
------------------------------------------------------------
"""

import sys

# [환경 설정]
TEST_MODE = True

# [입력 처리 함수]
def get_inputs():
    # 로컬 테스트 (input.txt 파일 읽기)
    if TEST_MODE:
        with open('input.txt', 'r') as f:
            for line in f:
                yield line.rstrip('\n')
    else:
    # 제출 환경 (표준 입력)
        for line in sys.stdin:
            yield line.rstrip('\n')

input_gen = get_inputs()

def input():
    return next(input_gen)


]],
      {
        -- 1. 플랫폼 선택
        c(1, { i(nil, "BOJ"), i(nil, "Programmers") }),

        -- 2. 문제 제목
        i(2, "문제 제목"),

        -- 3. 링크 자동 생성
        d(3, function(args)
          local platform = args[1][1] or ""
          local prefix = ""
          if platform == "BOJ" then
            prefix = "https://www.acmicpc.net/problem/"
          elseif platform == "Programmers" then
            prefix = "https://school.programmers.co.kr/learn/courses/30/lessons/"
          end
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
"""
------------------------------------------------------------
File     : {}
Brief    : 
Author   : {}
Date     : {}
Version  : 
History
------------------------------------------------------------
"""

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
