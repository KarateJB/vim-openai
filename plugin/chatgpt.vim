scriptencoding utf-8

" command! -nargs=0 ChatgptCurrent call s:func_chatgpt()
command! -nargs=* Chatgpt call s:func_chatgpt(<args>)
command! -range ChatgptSelection '<,'> call s:func_chatgpt_selection()

function! s:func_chatgpt_selection() range
  let s:selection = openai#get_visual_selection()
  let s:selection = substitute(s:selection,'\\n','','g')
  call s:func_chatgpt(s:selection)
endfunction

function! s:func_chatgpt(prompt = '') abort

    " g:chatgpt_apikey: API Key.
    " g:chatgpt_maxtoken: the maximum length of a sequence of tokens that a text generation model can produce.
    " g:chatgpt_focus_result: the current buffer will be on the result buffer if set to be 1, otherwise, on the last edit buffer.
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

    if a:prompt == ''
      let s:prompt = join(getline(1, '$'), '\n')
      let s:prompt = substitute(s:prompt, '\\n',' ','g')
    else
      let s:prompt = get(a:, 'prompt', '')
      let s:prompt = substitute(s:prompt, "\n",' ','g')
    endif

    if s:prompt == ''
      echo 'Cannot retrieve any prompt for ChatGPT! Please try again.'
      return
    endif

    if !exists("s:request_cmd")
      let s:request_cmd = 'curl https://api.openai.com/v1/completions -H ''Content-Type: application/json'' -H ''Authorization: Bearer ' . s:apikey . ''' -d ''{"model": "text-davinci-002", "prompt": "PROMPT", "max_tokens": ' . s:maxtoken . '}'''
    endif
    let s:request = substitute(s:request_cmd, "PROMPT", s:prompt, "")
    " let s:request = substitute(s:request,"\\\\","","g")
    " let s:response = system("./chatgpt.sh")
    if has("gui_running")
      silent let s:response = system(escape(s:request, '"'))
    else
      silent let s:response = system(s:request)
    endif

    let s:json = ''
    try
      " For local testin
      " let s:response = '{"choices":[{"finish_reason":"length","index":0,"logprobs":null,"text":"\n\n\Awesome Vim\n"}],"created":1683130927,"id":"xxx","model":"gpt-3.5-turbo-instruct","object":"text_completion","usage":{"completion_tokens":16,"prompt_tokens":10,"total_tokens":26}}'
      let s:response = matchstr(s:response, '{.*}')
      let s:json = json_decode(s:response)

      try
        let s:choice = get(s:json['choices'], 0, '')
        let s:result = split(s:choice['text'], "\n")
        new
        call setline(1, s:result)
        " execute '$read !'. s:request

        if !get(s:, 'focus_result')
          " go back to original window
          wincmd p
        endif

      catch " while cannot retieve the choice
        let s:error = s:json['error']['message']
        echom s:error
      endtry

    catch
      echom 'Cannot get correct response from ChatGPT for now. Please try again.'
    endtry
endfunction

