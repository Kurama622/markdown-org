# Markdown-Org

![vim](https://img.shields.io/badge/vim-neovim-red)

[ENGLISH](./README.md)  |  中文版

## 展示

![codeblock](./sceenshot/markdown-org-codeblock.gif)

![language](./sceenshot/markdown-org-language.gif)

## 介绍

1. 你可以在markdown中对预览每一个代码块的运行结果，结果以浮动窗口的形式展示出来，它不会打乱你现有的窗口布局。

2. 如果你的markdown中有多种语言，你可以选择运行其中一种语言，它会帮你把所有这种语言的代码块挑选出来，并按照在文中出现的次序，依次运行，结果以浮动窗口的形式展示出来。

## 安装

如果你用`vim-plug`，你可以通过下面命令安装
```vim
Plug 'demonlord1997/markdown-org', {'for':'markdown'}
```
如果你用`dein`，你可以通过下面命令安装
```vim
[[plugins]]
repo = 'demonlord1997/markdown-org'
on_ft = 'markdown'
```

## 配置

### 默认

