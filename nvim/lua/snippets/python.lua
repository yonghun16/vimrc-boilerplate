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

  s("programmers_comment", {
    t({
      "'''----------------------------------------------------",
      "Sub  : [Programmers] ",
      "Link : https://school.programmers.co.kr/learn/courses/30/lessons/",
      "Level: ",
      "Tag  : Python, ",
      "Memo",
      "----------------------------------------------------'''",
      "",
      "import sys",
      "input = sys.stdin.readline",
    })
  }),

  s("goorm", {
    t({
      "'''----------------------------------------------------",
      "Sub  : [Goorm] ",
      "Link : https://level.goorm.io/exam/문제번호/문제제목/quiz/1",
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
