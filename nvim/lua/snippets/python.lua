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
      "",
      "TEST_MODE = True",
      "",
      "def get_inputs():",
      "    if TEST_MODE:",
      "        with open('input.txt', 'r') as f:",
      "            for line in f:",
      "                yield line.rstrip('\\n')",
      "    else:",
      "        for line in sys.stdin:",
      "            yield line.rstrip('\\n')",
      "",
      "input_gen = get_inputs()",
      "",
      "def input():",
      "    return next(input_gen)",
      "",
      ""
    })
  }),

  s("poj_comment", {
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
      "",
      "TEST_MODE = True",
      "",
      "def get_inputs():",
      "    if TEST_MODE:",
      "        with open('input.txt', 'r') as f:",
      "            for line in f:",
      "                yield line.rstrip('\\n')",
      "    else:",
      "        for line in sys.stdin:",
      "            yield line.rstrip('\\n')",
      "",
      "input_gen = get_inputs()",
      "",
      "def input():",
      "    return next(input_gen)",
      "",
      ""
    })
  }),

  s("goj_comment", {
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
      "",
      "TEST_MODE = True",
      "",
      "def get_inputs():",
      "    if TEST_MODE:",
      "        with open('input.txt', 'r') as f:",
      "            for line in f:",
      "                yield line.rstrip('\\n')",
      "    else:",
      "        for line in sys.stdin:",
      "            yield line.rstrip('\\n')",
      "",
      "input_gen = get_inputs()",
      "",
      "def input():",
      "    return next(input_gen)",
      "",
      ""
    })
  }),
}
