---
title: 树莓派rclone+Webdav
description:  挂载rclone + 服务器Webdav
tags:
  - Raspberry
---

>rclone挂载阿里云盘，其他网盘都可以，[官方文档](https://rclone.org/docs/)

## 一、官方有提供脚本安装

```bash
curl https://rclone.org/install.sh | sudo bash
```

安装之后，输入 `rclone config` 配置，命令行配置。

```c
pi@raspberrypi:/etc/systemd/system $ rclone config
Current remotes:

Name                 Type
====                 ====
aliyun               webdav

e) Edit existing remote
n) New remote
d) Delete remote
r) Rename remote
c) Copy remote
s) Set configuration password
q) Quit config
e/n/d/r/c/s/q> n

Enter name for new remote.
name> aliyunTwo

Option Storage.
Type of storage to configure.
Choose a number from below, or type in your own value.
46 / WebDAV
   \ (webdav)
47 / Yandex Disk
   \ (yandex)
48 / Zoho
   \ (zoho)
49 / premiumize.me
   \ (premiumizeme)
50 / seafile
   \ (seafile)
Storage> 46

Option url.
URL of http host to connect to.
E.g. https://example.com.
Enter a value.
url> http://192.168.0.108:8777  

Option vendor.
Name of the WebDAV site/service/software you are using.
Choose a number from below, or type in your own value.
Press Enter to leave empty.
 1 / Nextcloud
   \ (nextcloud)
 2 / Owncloud
   \ (owncloud)
 3 / Sharepoint Online, authenticated by Microsoft account
   \ (sharepoint)
 4 / Sharepoint with NTLM authentication, usually self-hosted or on-premises
   \ (sharepoint-ntlm)
 5 / Other site/service or software
   \ (other)
vendor> 5

Option user.
User name.
In case NTLM authentication is used, the username should be in the format 'Domain\User'.
Enter a value. Press Enter to leave empty.
user> admin

Option pass.
Password.
Choose an alternative below. Press Enter for the default (n).
y) Yes, type in my own password
g) Generate random password
n) No, leave this optional password blank (default)
y/g/n> y
Enter the password:
password:
Confirm the password:
password:

Option bearer_token.
Bearer token instead of user/pass (e.g. a Macaroon).
Enter a value. Press Enter to leave empty.
bearer_token> 666666d56666666666666666

Edit advanced config?
y) Yes
n) No (default)
y/n> 

Configuration complete.
Options:
- type: webdav
- url: http://192.168.0.108:8777
- vendor: other
- user: admin
- pass: *** ENCRYPTED ***
- bearer_token: 666666d56666666666666666
Keep this "aliyunTwo" remote?
y) Yes this is OK (default)
e) Edit this remote
d) Delete this remote
y/e/d> 
Current remotes:

Name                 Type
====                 ====
aliyun               webdav
aliyunTwo            webdav

e) Edit existing remote
n) New remote
d) Delete remote
r) Rename remote
c) Copy remote
s) Set configuration password
q) Quit config

```

- 阿里云盘Token获取方式：打开网页版登录，F12打开开发者工具，找到应用位置->存储->复制refresh_token后面引号中的值，我用的谷歌浏览器。

##  二、配置路径

```c
/home/pi/.config/rclone
```

配置完成，并打开rclone.conf，看到文件内容

```c
[aliyun]
type = webdav
url = http://192.168.0.108:8711
vendor = other
user = admin
pass = 3yZhK6666666666
bearer_token = 78f36666666666d56666666666666666
```

##  三、挂载树莓派本地目录

```c
rclone mount aliyun:/raspberry_bak /home/pi/soft/aliDrive --allow-other --allow-non-empty --vfs-cache-mode writes --daemon
```

- aliyun:/raspberry_bak 刚才rclone新建的名字，raspberry_bak阿里云盘中的目录名字
- /home/pi/soft/aliDrive 本地目录

## 四、查看挂载

```c
# 查看是否挂载
df -h
```

发现`aliyun:raspberry_bak  3.4T  1.4T  2.1T  40% /home/pi/soft/aliDrive`，则挂载成功

```c
# 进入目录，有文件证明挂载成功
cd  /home/pi/soft/aliDrive
```


## 五、开机自启

首先需要卸载掉aliyun

```bash
fusermount -uqz aliyun
```

新建启动文件

```c
vi /etc/systemd/system/rclone-aliyun.service
```

写入
```c
[Unit]
Description=Rclone
After=network-online.target

[Service]
Type=simple
ExecStart=/usr/bin/rclone mount aliyun:/raspberry_bak /home/pi/soft/aliDrive  --use-mmap --umask 000 --default-permissions --no-check-certificate --allow-other --allow-non-empty --dir-cache-time 24h --cache-dir=/tmp --vfs-cache-mode full --buffer-size 256M --vfs-read-ahead 512M --vfs-read-chunk-size 32M --vfs-read-chunk-size-limit 128M --vfs-cache-max-size 20G --low-level-retries 200 --config /home/pi/.config/rclone/rclone.conf
Restart=on-abort
User=root

[Install]
WantedBy=default.target

```

设置开机自启

```c
# 重载配置
sudo systemctl daemon-reload
# 启动
sudo systemctl start rclone
# 查看状态
systemctl status rclone.service
# 设置自启动
sudo systemctl enable rclone.service
```

最后验证 rclone config

```c
pi@raspberrypi:~/soft/webdav $ rclone config show
[aliyun]
type = webdav
url = http://192.168.0.108:8711
vendor = other
user = admin
pass = 3yZhKnOd6T66666666666
bearer_token = 78f3c6d37777777777777777

[aliyunTwo]
type = webdav
url = http://192.168.0.108:8777
vendor = other
user = admin
pass = 4mSNn3GwLtRC666666666666
bearer_token = 666666d56666666666666666

```


## 六、阿里云盘转成Webdav


先配置 rclone，即配置网盘的 Token。

docker-compose.yaml

```c
version: "3.0"
services:
  aliyundrive-webdav:
    image: messense/aliyundrive-webdav:latest
    container_name: aliyundriver
    environment:
      - REFRESH_TOKEN=78f3c6d66666666666666666
      - WEBDAV_AUTH_USER=admin
      - WEBDAV_AUTH_PASSWORD=admin
    volumes:
      - /home/pi/soft/aliDrive/:/etc/aliyundrive-webdav/
    ports:
      - 8711:8080

```

- volumes: ` /home/pi/soft/aliDrive/` 树莓派本地目录，`/etc/aliyundrive-webdav/` 容器目录
- ports：8711 树莓派本地端口，8080容器端口

最后在浏览器中输入地址 `http://192.168.0.108:8711/` ，输入账号密码：admin，即进入！！！



## 七、定时打包自动上传阿里云盘

>简单的脚本让AI完成啦！

### ChatGPT

如果您需要在排除文件夹的时候，遍历`exclude_folders`数组中的所有文件夹名字，可以使用循环语句来实现。以下是修改后的代码：

```sh
#!/bin/bash

# 定义变量
source_dir="/path/to/source/dir"
exclude_folders=("logs" "cache")
filename=$(date +%Y%m%d_%H%M%S)

# 打包文件
exclude_arg=""
for folder in "${exclude_folders[@]}"
do
    exclude_arg+="--exclude=$folder "
done

tar $exclude_arg-czvf ${filename}.tar.gz $source_dir

# 创建目录并复制文件
destination_dir="/path/to/destination/dir"
mkdir -p $destination_dir
cp ${filename}.tar.gz $destination_dir
```

我们使用一个`for`循环来遍历数组`exclude_folders`中的所有元素，并将每个元素的值拼接到一个字符串变量`exclude_arg`中。然后在打包文件时，将该变量作为`tar`命令的参数之一传入即可。

通过这种方式，您不仅可以排除`exclude_folders`数组中的所有文件夹，而且可以更加灵活地控制排除哪些文件夹。


如果您希望定时自动执行该脚本，可以使用Linux系统中的定时任务功能 `crontab`。以下是具体步骤：

1.  打开终端，输入以下命令，编辑当前用户的 `crontab` 文件：

复制代码

`crontab -e`

2.  在打开的文件中，添加以下一行代码：

复制代码

`0 3 * * * /path/to/your/script.sh`

这一行代码的含义是：每天凌晨3点自动执行 `/path/to/your/script.sh` 脚本。如果您希望在其他时间运行脚本，请修改该行代码。其中，数字代表时间，星号代表任意值。例如，上面的代码中，`*`表示任意月份、任意日期。如果需要更详细的设置，请参考`crontab`格式。

3.  保存并关闭文件。使用以下命令验证是否成功添加定时任务：

复制代码

`crontab -l`

这样，您就可以通过定时任务来实现自动执行脚本了。

-------
自此完成：Rclone + Webdav + 定时上传云盘任务！