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
      "const TEST_MODE = true;",
      "",
      "let input;",
      "",
      "if (TEST_MODE) {",
      "  const filePath = require('path').join(__dirname, 'input.txt');",
      "  input = require('fs').readFileSync(filePath, 'utf-8').trim().split('\\n');",
      "}",
      "else {",
      "  input = require('fs').readFileSync(0, 'utf-8').trim().split('\\n');",
      "}",
      "",
      ""
    })
  }),

  s("poj_comment", {
    t({
      "/*-----------------------------------------------------",
      "Sub  : [Programmers] ",
      "Link : https://school.programmers.co.kr/learn/courses/30/lessons/",
      "Level: ",
      "Tag  : JS, ",
      "Memo",
      "-----------------------------------------------------*/",
      "",
      "const TEST_MODE = true;",
      "",
      "let input;",
      "",
      "if (TEST_MODE) {",
      "  const filePath = require('path').join(__dirname, 'input.txt');",
      "  input = require('fs').readFileSync(filePath, 'utf-8').trim().split('\\n');",
      "}",
      "else {",
      "  input = require('fs').readFileSync(0, 'utf-8').trim().split('\\n');",
      "}",
      "",
      ""
    })
  }),

  s("goj_comment", {
    t({
      "/*-----------------------------------------------------",
      "Sub  : [Goorm] ",
      "Link : https://level.goorm.io/exam/문제번호/문제제목/quiz/1",
      "Level: ",
      "Tag  : JS, ",
      "Memo",
      "-----------------------------------------------------*/",
      "",
      "const TEST_MODE = true;",
      "",
      "let input;",
      "",
      "if (TEST_MODE) {",
      "  const filePath = require('path').join(__dirname, 'input.txt');",
      "  input = require('fs').readFileSync(filePath, 'utf-8').trim().split('\\n');",
      "}",
      "else {",
      "  input = require('fs').readFileSync(0, 'utf-8').trim().split('\\n');",
      "}",
      "",
      ""
    })
  }),
}
