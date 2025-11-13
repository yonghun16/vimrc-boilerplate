local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- Online judge용 주석 Header (Java)
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

        -- 2. 링크 + 사용자 입력 문제번호
        d(2, function(args)
          local platform = args[1][1]
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

  -- 일반 파일용 주석 Header (Java)
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
          local filename = args[1][1]
          return filename:gsub("%.java$", "")
        end, { 1 }),
      }
    )
  ),
}
