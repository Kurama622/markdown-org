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

在你的配置文件（`.vimrc`/`init.vim`）中，写入
```vim
let g:default_quick_keys = 1
```
将启用默认配置

### 默认快捷键和参数

| 参数/快捷键               | 功能                                         |
|---------------------------|----------------------------------------------|
| `Alt+b`                   | 展开当前代码片段的运行结果                   |
| `Alt+l`                   | 运行某种语言的所有代码片段，会弹出语言选择框 |
| `g:language_path`         | 设置语言的环境路径                           |
| `g:org#style#border`      | 设置边框的风格（0,1,2,3,4,5），0为无边框     |
| `g:org#style#bordercolor` | 设置边框颜色                                 |
| `g:org#style#color`       | 设置结果文本的颜色                           |

#### 0

