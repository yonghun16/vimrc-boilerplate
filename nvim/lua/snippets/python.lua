local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
  s("boj_comment", {
    t({
      "'''----------------------------------------------------",
      "Sub  : [BOJ] ",
      "Link : https://www.acmicpc.net/problem/",
      "Level: ",
      "Tag  : Python, ",
      "Memo",
      "----------------------------------------------------'''",
      "",
      "import sys",
      "input = sys.stdin.readline",
    })
  }),
}
