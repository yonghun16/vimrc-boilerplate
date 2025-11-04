local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s(
    "header-comment_oj",
    fmt(
      [[
/** 
 * ------------------------------------------------------------
 * Sub    : [{}]
 * Link   : {}
 * Level  :   
 * Tag    : Java, 
 * Memo
 * ------------------------------------------------------------
 */

public class Main {{
    public static void main(String[] args) {{
        
    }}
}}
]],
      {
        -- 1. 플랫폼 선택
        c(1, { i(nil, "BOJ"), i(nil, "Programmers") }),

        -- 2. 플랫폼 선택 후 링크 자동 생성
        f(function(args)
          local platform = args[1][1]
          if platform == "BOJ" then
            return "https://www.acmicpc.net/problem/"
          elseif platform == "Programmers" then
            return "https://school.programmers.co.kr/learn/courses/30/lessons/"
          else
            return ""
          end
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

public class {} {{
    public static void main(String[] args) {{
        
    }}
}}
]],
      {
        i(1, "Main.java"),
        i(2, "송용훈"),
        f(function()
          return os.date "%Y-%m-%d"
        end, {}),
        f(function(args)
          -- 파일 이름에서 확장자 제거
          local filename = args[1][1]
          return filename:gsub("%.java$", "")
        end, { 1 }),
      }
    )
  ),
}
