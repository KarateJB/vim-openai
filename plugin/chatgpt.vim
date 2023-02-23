scriptencoding utf-8

com -nargs=1 Chatgpt call s:func_chatgpt(<args>)

function s:func_chatgpt(prompt) abort

    " g:chatgpt_apikey: API Key.
    " g:chatgpt_maxtoken: the maximum length of a sequence of tokens that a text generation model can produce.
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
    
    if !exists("s:request_cmd")
      let s:request_cmd = 'curl https://api.openai.com/v1/completions -H ''Content-Type: application/json'' -H ''Authorization: Bearer ' . s:apikey . ''' -d ''{"model": "text-davinci-002", "prompt": "PROMPT", "max_tokens": ' . s:maxtoken . '}'''
    endif
    let s:request = substitute(s:request_cmd,"PROMPT",a:prompt,"")
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
    new
    call setline(1, split(s:choice['text'], "\n"))
    " execute '$read !'. s:request

    " go back to original window
    wincmd p
endfunction


