---
title: learn主题
description: learn主题简码
tags:
  - Hugo
---
# learn主题简码

> ## 附件

```
｛｛%attachments title="Related files" pattern=".*\.(pdf|mp4)$"/%}}

｛｛%attachments style="orange" /%}}

｛｛%attachments style="grey" /%}}

｛｛%attachments style="blue" /%}}

｛｛%attachments style="green" /%}}

｛｛%attachments title="Related files" style="blue" pattern=".*\.(pdf|mp4)$"/%}}

```

{{%attachments title="Related files" style="blue" pattern=".*\.(pdf|mp4)$"/%}}
{{%expand "附件图片"%}}
![附件图片](http://e.e.121rh.com/img/1.jpg "附件图片")
{{% /expand%}}

> ## 按钮

```
｛｛% button href="https://cn.bing.com/" icon="fab fa-tencent-weibo" icon-position="right" %}}Bing搜索｛｛% /button %｝｝
```

{{% button href="https://cn.bing.com/" icon="fab fa-tencent-weibo" icon-position="right" %}}Bing搜索{{% /button %}}

> ## 拓展

```
｛｛% expand "点击我" %}} 童鞋，你好呀！ ｛｛% /expand%｝｝
```

{{%expand "点击我" %}}

童鞋，你好呀！

{{% /expand%}}

> ## 免责声明

```
｛｛% notice note %}}
注意
｛｛% /notice %}}

｛｛% notice info %}}
信息
｛｛{% /notice %}}

｛｛% notice tip %}}
提示
｛｛% /notice %}}

｛｛% notice warning %}}
警告
｛｛% /notice %}}


```

{{% notice note %}}
注意
{{% /notice %}}

{{% notice info %}}
信息
{{% /notice %}}

{{% notice tip %}}
提示
{{% /notice %}}

{{% notice warning %}}
警告
{{% /notice %}}

> ## 站点参数

```
`站点` 参数: {{% siteparam "editURL" %}}
```

`站点` 参数: {{% siteparam "editURL" %}}

> ## 选项卡

```
｛｛< tabs >}}
｛｛% tab name="姓名" %}}
···
姓名：小明
···
｛｛% /tab %}}
```



{{< tabs >}}
{{% tab name="姓名" %}}

```
姓名：小明
```

{{% /tab %}}
{{% tab name="身高" %}}

```
身高：180
```

{{% /tab %}}
{{% tab name="性别" %}}

```
性别：男
```

{{% /tab %}}
{{% tab name="爱好" %}}

```
爱好：吃吃吃
```

{{% /tab %}}
{{< /tabs >}}

> ## 孩子

```
｛｛% children  %}}

｛｛% children description="true" %}}

｛｛% children depth="3" showhidden="true" %}}

｛｛% children style="h2" depth="3" description="true" %}}

｛｛% children style="div" depth="999" %}}



```

> ## github摘要

```
https://gist.github.com/github用户名
｛｛< gist 121rh 62c2d4f04a572049cb946e1903f5d502 >}}
｛｛< gist 121rh 2204a6502bf75e5536fe0360f15c1107  >}}
```

博主在写文章时通常希望包含 GitHub 要点。假设我们想在以下 url 使用要点：我们可以通过从 URL 中提取的用户名和 gist ID 将 gist 嵌入到我们的内容中：
{{< gist 121rh 62c2d4f04a572049cb946e1903f5d502 >}}
{{< gist 121rh 2204a6502bf75e5536fe0360f15c1107  >}}

> ## 插入代码

```
｛｛< highlight go >}} A bunch of code here ｛｛< /highlight >}}
```

{{< highlight go >}} A bunch of code here {{< /highlight >}}

> ## 插入图片

```
｛｛< figure src="/images/gopher-404.jpg" title="404页面" >}}
```

{{< figure src="/images/gopher-404.jpg" title="404页面" >}}


## 自定义简码

> ### 豆瓣-书
```
｛｛<douban src = "https://book.douban.com/subject/35153298/">}}
```
{{<douban src = "https://book.douban.com/subject/35153298/">}}

> ### 豆瓣-电影
```
｛｛< douban src ="https://movie.douban.com/subject/34861178/">}}
```

{{< douban src ="https://movie.douban.com/subject/34861178/">}}

> ### 内置PDF文件
```
｛｛<ppt src = "/pdf/1.pdf">}}
```

> ### 内置网页
```
｛｛<ppt src = "https://s.weibo.com/top/summary">}}  
```

> ### 哔哩哔哩视频
```
｛｛<bilibili BV1vv41177jq>}}

```
{{<bilibili BV1vv41177jq>}}