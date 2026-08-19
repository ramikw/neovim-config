return {
    "kamykn/spelunker.vim",
    lazy = false,
    init = function()
        vim.wo.spell = false
        -- check_type 2 = CursorHold: only scans the visible window on idle,
        -- instead of scanning the whole buffer synchronously on every
        -- BufWinEnter/BufWritePost (which is what was making big files slow
        -- to open -- see spelunker#spellbad#get_word_list_in_line in a
        -- :profile dump).
        vim.g.spelunker_check_type = 2
    end,
    keys = {
        { "z=",  function() vim.cmd [[call spelunker#correct_from_list()]] end,                   desc = "Spell suggestion" },
        { "zn",  function() vim.cmd [[call spelunker#jump_next()]] end,                           desc = "Jump to next misspelled word" },
        { "zN",  function() vim.cmd [[call spelunker#jump_prev()]] end,                           desc = "Jump to previous misspelled word" },
        { "zg",  function() vim.cmd [[call spelunker#execute_with_target_word("spellgood")]] end, desc = "Spell suggestion" },
        { "zug", function() vim.cmd [[call spelunker#execute_with_target_word("spellundo")]] end, desc = "Spell suggestion" },
    },
}
