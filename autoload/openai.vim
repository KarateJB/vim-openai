scriptencoding utf-8

function! openai#get_visual_selection()
    " The function was wroten by xolox, see https://stackoverflow.com/a/6271254/7045253
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

function! openai#prompt_md_table()
    let l:selection = openai#get_visual_selection()
    let l:prompt = 'Format the text to markdown table, the first line is the field name and the values are separated by tab, also center the values: ' . l:selection
    return l:prompt
endfunction
