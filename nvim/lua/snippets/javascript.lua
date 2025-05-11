local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
  s("boj_comment", {
    t({
      "/*-----------------------------------------------------",
      "Sub  : [BOJ] ",
      "Link : https://www.acmicpc.net/problem/",
      "Level: ",
      "Tag  : JS, ",
      "Memo",
      "-----------------------------------------------------*/",
      "",
      "const input = require('fs').readFileSync(0, 'utf-8').trim().split('\\n');"
    })
  }),

  s("programmers_comment", {
    t({
      "/*-----------------------------------------------------",
      "Sub  : [Programmers] ",
      "Link : https://school.programmers.co.kr/learn/courses/30/lessons/",
      "Level: ",
      "Tag  : JS, ",
      "Memo",
      "-----------------------------------------------------*/",
      "",
      "const input = require('fs').readFileSync(0, 'utf-8').trim().split('\\n');"
    })
  }),

  s("goorm_comment", {
    t({
      "/*-----------------------------------------------------",
      "Sub  : [Goorm] ",
      "Link : https://level.goorm.io/exam/문제번호/문제제목/quiz/1",
      "Level: ",
      "Tag  : JS, ",
      "Memo",
      "-----------------------------------------------------*/",
      "",
      "const input = require('fs').readFileSync(0, 'utf-8').trim().split('\\n');"
    })
  }),
}
