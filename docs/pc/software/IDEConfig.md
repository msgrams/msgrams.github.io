---
title: IDEA配置
description: IdeaConfig
tags:
  - Software
---

# IDEA配置

## 安装多个idea

前提：电脑内有一个idea版本

> 如果在一台电脑内安装多个idea，正常用.exe安装或者.zip解压后打不开程序，所以需要进行以下配置：

  
1.[下载 IntelliJ IDEA Ultimat(把.exe换.zip)]( https://www.jetbrains.com/zh-cn/idea/download/#section=windows )

2.把ideaIU-2022.2.1.win-Development 解压到某目录下

3.修改/ideaIU-2022.2.1.win-Development/bin/idea.properties的配置

```html
#---------------------------------------------------------------------
# Uncomment this option if you want to customize a path to the settings directory.
#---------------------------------------------------------------------
idea.config.path=${user.home}/.IntelliJIdea2022.2.1/config

#---------------------------------------------------------------------
# Uncomment this option if you want to customize a path to the caches directory.
#---------------------------------------------------------------------
idea.system.path=${user.home}/.IntelliJIdea2022.2.1/system

#---------------------------------------------------------------------
# Uncomment this option if you want to customize a path to the user-installed plugins directory.
#---------------------------------------------------------------------
idea.plugins.path=${idea.config.path}/plugins

#---------------------------------------------------------------------
# Uncomment this option if you want to customize a path to the logs directory.
#---------------------------------------------------------------------
idea.log.path=${idea.system.path}/log

```

4.在C:\Users\用户\目录下创建 “.IntelliJIdea2022.2.1”文件夹。让上面配置文件找到“用户”下的文件夹。


5.清除缓存文件，如果有打不开的情况那么需要清除缓存 file:///C:/Users/用户/AppData/Roaming/JetBrains

6.打开idea进行激活



## IDEA激活

> 激活请关注公众号：【雨落无影】

> [雨落无影 激活码](https://www.jiweichengzhu.com/idea/code)

[IntelliJ IDEA 2022.2 版本最新永久激活方法](https://www.bilibili.com/read/cv17790047/)



## IDEA插件

<details>
  <summary>插件666</summary>
  1、Vuesion Theme
  <pre><code> 
     默认的皮肤是黑白色，这款Vuesion拥有代码高亮主题
  </code></pre>
  2、Atom Material ICons
  <pre><code> 
     美化图标插件，提高了辨识度，一眼就查出哪是类、哪是接口！
  </code></pre>
  3、Vuesion Theme
  <pre><code> 
     它能在Idea里直接打开Jar包，并且反编译代码查看。
  </code></pre>
  4、GitToolBox
   <pre><code> 
     在项目上提示有多少文件没提交，远程还有多少文件没更新下来。
  </code></pre>
  5、Maven Helper
   <pre><code> 
     Idea开发者的标配插件：排查Jar包依赖
  </code></pre>
  6、Translation
   <pre><code> 
     支持google翻译，有道翻译，百度翻译，阿里翻译。
  </code></pre>
  7、arthas idea
   <pre><code> 
     java在线诊断工具
  </code></pre>
  8、Search In Repository
   <pre><code> 
     该插件把中央仓库的查找集成到了Idea里面。
  </code></pre>
  9、VisualGC
   <pre><code> 
     诊断JVM堆栈，可视化界面
  </code></pre>
  10、Zoolytic
   <pre><code> 
     一款zookeeper节点的查看分析插件
  </code></pre>
  11、Alibaba Java Coding Guidelines
   <pre><code> 
     阿里巴巴官方出品的一款代码静态检查插件，它可以针对整个项目或者单个文件进行检查，扫描完成后会生成一份检查报告，根据报告修改代码。
  </code></pre>
  12、CodeGlance
   <pre><code> 
     如果一个文件有上千行代码，可以直接在预览区里拖动快速定位到对应的代码行。
  </code></pre>
  13、Free MyBatis plugin
   <pre><code> 
     实现从mapper接口跳转到mybatis的xml文件中
  </code></pre>
  14、JavaDoc
   <pre><code> 
     JavaDoc工具可以一键生成注释
  </code></pre>
  15、ignore
   <pre><code> 
     插件安装完成后会在项目中生成一个.ignore文件，编辑该文件忽略一些动态生成的文件，如class文件，maven的target目录
  </code></pre>
  16、Rainbow Brackets
   <pre><code> 
     彩虹括号，代码中有多个括号会显示不同的颜色。
  </code></pre>
  17、Grep Console
   <pre><code> 
     运行项目后在console（控制台）输出日志，通过配置不同日志级别的颜色，可以很明显的识别错误信息，便于项目调试。
  </code></pre>
  18、Stackoverflow
   <pre><code> 
     遇到的问题搜索找到回答
  </code></pre>
  19、FindBugs
   <pre><code> 
     更深入的去检查异常
  </code></pre>
  20、GsonFormat
   <pre><code> 
     代码生成插件。在类中使用，粘贴一段 Json 文本，能自动生成对象的嵌套结构代码。
  </code></pre>

</details>