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

When there is no argument, the command `Chatgpt` takes current buffer's all content as prompt to ChatGPT.

```
:Chatgpt
```

### Input prompt from selection

When in Visual Mode, we can pass the selected text as prompt to ChatGPT by command `ChatgptSelection`.

```
:'<,'>ChatgptSelection
```

## Demo

![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjC7Ovb-jUPkUa8mSh9FWXr7fmqEZCc7RgCatVMviw_JzwjWwyenmdPQFpJ-SsA2-JrNciRj5XzMi3uXc8dHJOPoWLA0RQGtHlJ8eNMtVxBM-ZfsO-FAbMHYqDjd8_5mThHq4x2rf-7jnKpVclTL4B4mTDbUcp-0yidHJN6vtaqqFEwfC_S3cTS4Ygg/s16000/vim-openai-chatgpt-01.gif.gif)

![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEipqT0LyhIp20lTu_qaqHFwssFqCY0w9faFqbjAdPgzterGmO8XGsDfT-4Nz3FqqUqx0WDENbSorggoR6DJqUcXyUDd_EVpP7mkK0-79kliUhAejSCWxdS5LlRl_SjnrSSFQLR62QXqN2nx1hBN02DkyZ2Sk-CvERXKpZFkyYhbbGel0kWFOA93TyY9/s16000/vim-openai-chatgpt-02.gif.gif)


## License

Copyright (c) KarateJB. Distributed under the same terms as Vim itself. See `:help license`.
