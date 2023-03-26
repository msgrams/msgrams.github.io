---
title: PyMdown使用
description: PyMdown使用
tags:
  - Mkdocs
---

### 基本用法：

mkdocs new dir-name - 创建一个新项目.
mkdocs serve - 启动实时重新加载文档服务器.
mkdocs build - 构建文档站点.
mkdocs -h - 打印帮助信息并退出.

<font style="background: linear-gradient( to right, #ff1616, #ff7716, #ffdc16, #36c945, #10a5ce, #0f0096, #a51eff, #ff1616);">太阳太阳，给我们带来，七色光彩</font>


更多有趣的符号参见 [PyMdown Extensions](https://facelessuser.github.io/pymdown-extensions/)



<details>
  <summary>展开查看</summary>
  <pre><code> 
     System.out.println("Hello");
  </code></pre>
</details>


<details>
<summary>点击查看折叠代码块</summary>
    System.out.println("Hello");
</details>

???+ note "开放式细节"

    ??? danger "危险“嵌套细节！"
        还有更多内容。

??? success
     内容

??? warning classes
     内容

!!! note
    this is a tip


=== "Tab 1"
    Markdown **content**.

    Multiple paragraphs.

=== "Tab 2"
    More Markdown **content**.

    - list item a
    - list item b


=== "Tab 1"
    Markdown **content**.

    Multiple paragraphs.

=== "Tab 2"
    More Markdown **content**.

    - list item a
    - list item b

===! "Tab A"
    Different tab set.

=== "Tab B"
    ```
    More content.
    ```


Task List

- [X] item 1
    * [X] item A
    * [ ] item B
        more text
        + [x] item a
        + [ ] item b
        + [x] item c
    * [X] item C
- [ ] item 2
- [ ] item 3


嵌入本地 PNG、JPEG 和 GIF 图像引用

![胡歌](https://qnimg.yi2.net/FhU9fQqfN0T7FmxlWv6sGUCJ2oss "胡歌")

<img src="https://qnimg.yi2.net/FhU9fQqfN0T7FmxlWv6sGUCJ2oss" alt="胡歌"
title="胡歌" width="50%" height="10%" />


下划线：^^Insert me^^

上角标：H^2^0

上角标：text^a\ superscript^

这是一些 {--*incorrect*--} Markdown。 我在这里添加这个{++ ++}。 这里还有一些 {--text我正在删除--}文本。 这里还有更多 {++text 我正在++}添加。{~~ ~>  ~~}段落被删除并替换为一些空格。{~~ ~>~~}空格被删除并添加了一个段落。这是对 {==some 的评论text==}{>>这很好用。 我只是想对此发表评论。<<}。 替换 {~~is~>are~~} 很棒！

块处理

{--

* 测试删除
* 测试删除
* 测试删除
     * 测试删除
* 测试删除

--}

{++

* 测试添加
* 测试添加
* 测试添加
     * 测试添加
* 测试添加

++}


:smile: :heart: :thumbsup:

`#!php-inline $a = array("foo" => 0, "bar" => 1);`

这是一些代码： `#!py3 import pymdownx; pymdownx.__version__`.

模拟 shebang 将在此处被视为文本： ` #!js var test = 0; `.

++ctrl+alt+"My Special Key"++

++cmd+alt+"&Uuml;"++

- 像这样直接在文档中粘贴链接: https://121rh.com.
- 甚至是电子邮件地址: fyabwz@126.com.

@121rh

@twitter:twitter


@facelessuser/pymdown-extensions

@gitlab:pycqa/flake8

#1

backrefs#1

Python-Markdown/markdown#1

gitlab:pycqa/flake8#385

!13

backrefs!4

Python-Markdown/markdown!598

gitlab:pycqa/flake8!213

==mark me==

==smart==mark==


<!--我们只允许 strip_comments 和 strip_js_on_attributes
      在这个例子中。 -->

Here is a <strong onclick="myFunction();">test</strong>.
<script>
    function myFunction(){
        alert("弹窗测试");
    }
</script>
Here is a <button onClick="myAlert()" >test</button>.
<script>
function myAlert(){
    alert("测试");
}
</script>


```{.python .extra-class #id linenums="1"}
import hello_world
```

```
============================================================
T	Tp	Sp	D	Dp	S	D7	T
------------------------------------------------------------
A	F#m	Bm	E	C#m	D	E7	A
A#	Gm	Cm	F	Dm	D#	F7	A#
B♭	Gm	Cm	F	Dm	E♭m	F7	B♭
```


```py3
import foo.bar
```

``` {linenums="1"}
import foo.bar
```

``` {linenums="2"}
import foo.bar
```

``` {linenums="1 1 2"}
"""Some file."""
import foo.bar
import boo.baz
import foo.bar.baz
```

```{.py3 title="My Cool Header"}
import foo.bar
import boo.baz
import foo.bar.baz
```

```python
import foo.bar
import boo.baz
import foo.bar.baz
```


```pycon
>>> 3 + 3
6
```

~~Delete me~~
