---
title: 安装Mkdocs
description: 安装和配置Mkdocs
tags:
  - mkdocs
---

## 安装步骤：
安装 Python3，然后通过命令
```
pip install mkdocs
```
但因为该主题属于第三方主题样式，我们需要使用前面安装 MkDocs 使用的 pip 工具进行安装：
```
pip install mkdocs-material
```
安装完成后，我们只需要在 mkdocs.yml 文件中进行配置即可：
```
theme:
  name: material
```
## 插件：
```
//显示页面最后一次 git 修改的日期
pip install mkdocs-git-revision-date-localized-plugin 

//显示来自 git 的作者
pip3 install mkdocs-git-authors-plugin

//mkdocs-rss-插件 1.1.0
pip install mkdocs-rss-plugin

//MkDocs 自动链接插件
pip install mkdocs-autolinks-plugin

//mkdocs 博客时间排序
pip install mkdocs-blogging-plugin

//PyMdown 扩展
pip install pymdown-extensions

//MkDocs 的主题
pip install mkdocs-material

//创建页面重定向的插件（例如，用于移动/重命名的页面）
pip install mkdocs-redirects
```

## 用法：
### 【1】页面最后一次修改日期
详情：https://timvink.github.io/mkdocs-git-revision-date-localized-plugin/available-variables/

详情：https://pypi.org/project/mkdocs-git-revision-date-localized-plugin/

### 【2】git 作者插件

详情：https://timvink.github.io/mkdocs-git-authors-plugin/index.html

```
{{ git_page_authors }}页面作者的摘要。输出包裹在<span class='git-page-authors'>
{{ git_site_authors }}您网站中所有页面的所有作者的摘要。输出包裹在<span class='git-site-authors'>
```
例如，添加Tim Vink可以插入：
```
<span class='git-page-authors'><a href='mailto:jane@abc.com'>Jane Doe</a><a href='mailto:john@abc.com'>John Doe</a></span>
```

mkdocs-材料主题
如果您使用mkdocs-material主题，您可以通过覆盖模板块来实现 git-authors ：main.html
1）在以下位置创建一个新文件docs/overrides：

```
{% extends "base.html" %}
{% block content %}
  {{ super() }}
  {% if git_page_authors %}
    <div class="md-source-date">
      <small>
          Authors: {{ git_page_authors | default('enable mkdocs-git-authors-plugin') }}
      </small>
    </div>
  {% endif %}
{% endblock %}

```
2）mkdocs.yml确保指定具有主题覆盖的自定义目录：
```
theme:
    name: material
    custom_dir: docs/overrides
```

### 【3】mkdocs-rss-插件 1.1.0
详情：https://guts.github.io/mkdocs-rss-plugin/
最低mkdocs.yml配置：
```
site_description: 必需。用作 Feed 强制频道描述。
site_name: 必需。用作 Feed 强制频道标题和项目来源 URL 标签。
site_url ：必填。用于构建提要项目 URL。
```

最小插件选项：
```
plugins:
  - rss
```

完整选项：
```
plugins:
  - rss:
      abstract_chars_count: 160  # -1 for full content
      categories:
        - tags
      comments_path: "#__comments"
      date_from_meta:
        as_creation: "date"
        as_update: false
        datetime_format: "%Y-%m-%d %H:%M"
      enabled: true
      feed_ttl: 1440
      image: https://upload.wikimedia.org/wikipedia/commons/thumb/4/43/Feed-icon.svg/128px-Feed-icon.svg.png
      length: 20
      pretty_print: false
      match_path: ".*"
      url_parameters:
        utm_source: "documentation"
        utm_medium: "RSS"
        utm_campaign: "feed-syndication"
```

### 【4】MkDocs 自动链接插件
详情：https://github.com/midnightprioriem/mkdocs-autolinks-plugin

一个 MkDocs 插件，可简化文档之间的相对链接。Autolinks 插件允许您链接到 MkDocs 站点中的页面和图像，而无需提供文档结构中文件的完整相对路径。

激活插件mkdocs.yml：
```
plugins:
  - search
  - autolinks
```

注意：如果您的配置文件中还没有plugins条目，您可能还需要添加search插件。如果没有plugins设置条目，MkDocs 默认启用它，但现在您必须显式启用它。
用法
要使用此插件，只需创建一个链接，该链接仅包含您希望链接到的文件的文件名。
例如，假设您有这样的文档结构：
```
docs/
├── guides/
│  ├── onboarding.md
│  └── syntax_guide.md
├── software/
│  ├── git_flow.md
│  └── code_reviews.md
└── images/
    ├── avatar.png
    └── example.jpg

```
通常，如果您想git_flow.md从 inside创建一个链接onboarding.md，您需要提供相对路径：
 onboarding.md
[Git Flow](../software/git_flow.md)
这个链接很脆弱；如果有人决定重新安排站点结构，所有这些相关链接都会中断。更不用说必须弄清楚相对路径。
使用 Autolinks 插件，您只需要提供您希望链接到的文件名。假设文件存在于您的文档结构中，该插件将预处理您的所有降价文件并将文件名替换为正确的相对路径
 onboarding.md
[Git Flow](git_flow.md)
Autolinks 插件适用于以下扩展类型：
MD、PNG、jpg、JPEG、bmp、gif、svg、网页

### 【5】mkdocs 博客时间排序
详情：https://liang2kl.codes/mkdocs-blogging-plugin/

一个 mkdocs 插件，它生成一个列出所选页面的博客页面，按时间排序。

演示站点：https ://liang2kl.github.io/mkdocs-blogging-plugin-example

这是所需的最低配置。
```
mkdocs.yml
plugins:
  - blogging:
       dirs: # The directories to be included
         - blog
```

在要插入博客内容的页面中，在所需位置添加一行：

博客索引页面
```
# Blogs
{{ blog_content ｝｝

```
就这样。您可以打开您插入的页面并查看它是如何工作的。

更多配置¶
或者，在您的文章中，添加提供标题和描述的元标签，这些标签将显示在博客页面上：
文章
---
title: Lorem ipsum dolor sit amet
description: Nullam urna elit, malesuada eget finibus ut, ac tortor.
---
您还可以为所有文章设置标签。首先，在配置中开启这个功能：
```
mkdocs.yml
plugins:
  - blogging:
      features:
        tags: {}
```
在文章中：
文章
---
tags:
  - mkdocs
  - blogging
---

### 【6】PyMdown 扩展
详情：https://facelessuser.github.io/pymdown-extensions/extensions/arithmatex/

用法
所有扩展都在pymdownx. 假设我们想指定 MagicLink 扩展的使用，我们会将它包含在 Python Markdown 中，如下所示：
```
>>> import markdown
>>> text = "A link https://google.com"
>>> html = markdown.markdown(text, extensions=['pymdownx.magiclink'])
```
```
'<p>A link <a href="https://google.com">https://google.com</a></p>'
```
查看每个扩展的文档以了解有关如何配置和使用每个扩展的更多信息。

### 【7】mkdocs重定向
详情：https://www.cnpython.com/pypi/mkdocs-redirects

使用

若要使用此插件，请在mkdocs.yml插件的redirect_maps设置中指定所需的重定向：

```
plugins:-redirects:redirect_maps:'old.md':'new.md''old/file.md':'new/file.md''some_file.md':'http://external.url.com/foobar'
注意：不要忘记，如果尚未设置plugins设置，则指定该设置将覆盖默认设置！有关详细信息，请参见this page。
```
