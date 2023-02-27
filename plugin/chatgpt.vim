scriptencoding utf-8

" command! -nargs=0 ChatgptCurrent call s:func_chatgpt()
command! -nargs=* Chatgpt call s:func_chatgpt(<args>)

function! s:func_chatgpt(prompt = '') abort

    " g:chatgpt_apikey: API Key.
    " g:chatgpt_maxtoken: the maximum length of a sequence of tokens that a text generation model can produce.
    " g:chatgrp_focus_result: the current buffer will be on the result buffer if set to be 1, otherwise, on the last edit buffer.
    if !exists('g:chatgpt_apikey')
      echo 'API Key is not set. Please set g:chatgpt_apikey in your vimrc file.'
      return
    else
      let s:apikey = get(g:, 'chatgpt_apikey')
    endif

    if !exists('g:chatgpt_maxtoken')
      let s:maxtoken = 1000
    else
      let s:maxtoken = get(g:, 'chatgpt_maxtoken')
    endif

    if !exists('g:chatgpt_focus_result')
      let s:focus_result = 0
    else 
      let s:focus_result = 1
    endif
    echo s:focus_result

    if a:prompt == ''
      let s:prompt = join(getline(1, '$'), '\n')
      " Replace the newline with empty string, because the newline will be escapted as ^@ and cause the request fails.
      let s:prompt = substitute(s:prompt,'\\n','','g')
    else
      let s:prompt = get(a:, 'prompt', '')
    endif
    if !exists("s:request_cmd")
      let s:request_cmd = 'curl https://api.openai.com/v1/completions -H ''Content-Type: application/json'' -H ''Authorization: Bearer ' . s:apikey . ''' -d ''{"model": "text-davinci-002", "prompt": "PROMPT", "max_tokens": ' . s:maxtoken . '}'''
    endif
    let s:request = substitute(s:request_cmd,"PROMPT",s:prompt,"")
    " let s:request = substitute(s:request,"\\\\","","g")
    " let s:response = system("./chatgpt.sh")
    if has("gui_running")
      silent let s:response = system(escape(s:request, '"'))
    else
      silent let s:response = system(s:request)
    endif

    let s:response = matchstr(s:response, '{.*}')
    let s:json = json_decode(s:response)
    let s:choice = get(s:json['choices'], 0, '')
    let s:result = split(s:choice['text'], "\n")
    new
    call setline(1, s:result, "\n"))
    " execute '$read !'. s:request

    if !get(s:, 'focus_result')
      " go back to original window
      wincmd p
    endif
endfunction


