# vim-openai

vim-openai is a Vim plugin to integrate OpenAI API.

## Features

- ChatGPT: Text Completion

## Install

Just use your Vim plugin manager to install the plugin, or clone this repository into plugin directory, such as `~/.vim/pack/bundle/start/`.

## Options

Set the following variables in your vimrc file.

| Variable | Type | Required | Description |
|:---------|:----:|:--------:|:------------|
| g:chatgpt_apikey | string | required | Your API key. |
| g:chatgpt_maxtoken | number | optional | The number of max token. The default value is `1000`. |
| g:chatgpt_focus_result | boolean | optional | 0: go back to the last edit buffer, 1: move the cursor to the new buffer with result. The default value is `0`. |


## How to use

### Input prompt in Command Mode

```
:Chatgpt "List the 3 popular NBA players"
```

It will open a new buffer and show the completion response.

### Input prompt from current buffer

```
:Chatgpt
```

That will take current buffer's all content as prompt to ChatGPT.


## License

Copyright (c) KarateJB. Distributed under the same terms as Vim itself. See `:help license`.
