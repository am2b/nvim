local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
    s(
        {
            trig = ";rfl",
            dscr = "read file by line",
            snippetType = "autosnippet",
        },

        fmta(
            [[
                file, err := os.Open(<>)
                if err != nil {
                    log.Fatal(err)
                }
                defer file.Close()

                scanner := bufio.NewScanner(file)
                for scanner.Scan() {
                    line := scanner.Text()
                    <>
                }

                if err := scanner.Err(); err != nil {
                    log.Fatal(err)
                }

                <>
            ]],

            { i(1), i(2), i(0) }
        )
    ),
}
