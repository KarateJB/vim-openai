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
| g:chatgpt_apikey | string | Required | Your API key. |
| g:chatgpt_maxtoken | number | optional | The number of max token. The default value is 1000. |


## How to use

```
:Chatgpt "List the 3 popular NBA players"
```

It will open a new buffer and show the completion response.


## License

Copyright (c) KarateJB. Distributed under the same terms as Vim itself. See `:help license`.
