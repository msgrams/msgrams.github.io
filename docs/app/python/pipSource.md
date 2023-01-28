---
title: pip源及path路径
description: pip源及path路径
tags:
  - Python
---
# pip配置
## 1、path路径问题
之后出现pip --version 报错 ，pip报错如下：
```
C:\Users\fya>pip list
Fatal error in launcher: Unable to create process using '"c:\python27\python.exe"  "C:\Python27\Scripts\pip.exe" list': ???????????
C:\Users\fya>pip3 list
Fatal error in launcher: Unable to create process using '"c:\python38\python3.exe"  "C:\Python38\Scripts\pip3.exe" list': ???????????
```

运行以下命令，来重新创建python文件和pip的关联：

```
python -m pip install --upgrade pip

python2 -m pip install --upgrade pip
```

结果我这里提示pip版本已经是最新的，这种情况的话，其实只需要强制重装pip即可，命令如下：
```

python  -m pip install --upgrade --force-reinstall pip

python2  -m pip install --upgrade --force-reinstall pip

```

如果网速太慢，可以在后面加上国内的源：
```
-i https://mirrors.aliyun.com/pypi/simple/
```


## 2、pip源设置：
```
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
```

恢复默认源
```
pip config set global.index-url https://pypi.python.org/simple/
```

推荐国内源：

```
清华大学：https://pypi.tuna.tsinghua.edu.cn/simple
阿里云：http://mirrors.aliyun.com/pypi/simple/
豆瓣：http://pypi.douban.com
中国科技大学 https://pypi.mirrors.ustc.edu.cn/simple/
华中理工大学：http://pypi.hustunique.com/
山东理工大学：http://pypi.sdutlinux.org/ 
```

运行：
```
C:\Users\fya>pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
Writing to C:\Users\fya\AppData\Roaming\pip\pip.ini
```

文件路径：
file:///C:/Users/fya/AppData/Roaming/pip

pip.ini文件里面内容分为：
```
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
```

