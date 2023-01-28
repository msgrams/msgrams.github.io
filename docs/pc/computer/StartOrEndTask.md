---
title: 一键开关程序
description: 自动化启动关闭程序
tags:
  - computer
---

## 任务列表：

startTask.txt

```python
wps.exe
wpp.exe
```

endTask.txt

```
QQScreenShot.exe
wpp.exe
wps.exe
Maye.exe
TIM.exe
SbieCtrl.exe
MouseInc.exe
```

## bat程序：

startTask.bat

```
@echo off
chcp 936
for /f "delims=, " %%i in (F:\Desktop\startTask.txt) do start %%i& ping -n 5 127.0.0.1
start "" "D:\Program Files\QQScreenShot\Bin\QQScreenShot.exe"
echo Process Start Complete
pause
```

endTask.bat

```
@echo off
for /f "delims=, " %%i in (F:\Desktop\endTask.txt) do taskkill /f /im %%i
echo process termination complete
pause

```
