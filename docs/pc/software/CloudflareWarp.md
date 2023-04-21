---
title: WARP无限流量
description:  WARP 应用程序使用BoringTun加密和保护来自您设备的流量，并将其直接发送到 Cloudflare 的边缘网络。
tags:
  - Software
---

>内容部分来自Cloudflare官网


#  通过本地代理的 WARP

目前，此模式仅适用于桌面客户端。当 WARP 配置为本地代理时，只有您配置为使用代理（HTTPS 或 SOCKS5）的应用程序才会通过 WARP 发送其流量。这使您可以选择要加密的流量——例如，您的网络浏览器或特定应用程序。其他所有内容都不会加密，将通过常规 Internet 连接发送。

由于此功能将 WARP 限制为仅配置为使用本地代理的应用程序，默认情况下保留所有其他互联网流量未加密，我们已将其隐藏在高级菜单**中**。打开它：

1.  导航到**Preferences** > **Advanced**并选择**Configure Proxy**。
2.  在打开的窗口中，选中该框并配置您要侦听的端口。

这将在**WARP 设置菜单中****通过本地代理启用 WARP**选项。


虽然 WARP 能够利用世界各地的许多 Clo​​udflare 数据中心为您提供更加私密和强大的连接，但 WARP+ 订阅者可以访问更大的网络。连接更多城市意味着您可能离 Cloudflare 数据中心更近——这可以减少您的设备和 Cloudflare 之间的延迟，并提高您的浏览速度。因此，站点加载速度更快，无论是在 Cloudflare 网络上还是在不在网络上。

## WARP无限

WARP Unlimited 是我们为 WARP+ 提供的月度订阅服务。目前，WARP Unlimited 只能通过 iOS 和 Android 设备购买。


## 1.1.1.1

1.1.1.1 是 Cloudflare 的公共 DNS 解析器。它提供了一种快速且私密的方式来浏览 Internet。它还通过 HTTPS 上的 DNS (DoH) 或 TLS 上的 DNS (DoT) 提供 DNS 加密服务，以提高安全性和隐私性。


## 支持架构 amd64

|               | Windows                                                      | macOS                                                        | Linux                                                        | iOS                                                          | Android                                                      |
| :------------ | :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| OS version    | Windows 8+                                                   | Mojave+ (10.14+)                                             | CentOS 8, RHEL 8, Ubuntu 16.04, Ubuntu 18.04, Ubuntu 20.04, Debian 9, Debian 10, Debian 11 | iOS 11+                                                      | Android 5.0+                                                 |
| OS type       | 64-bit                                                       | Intel & M1                                                   | 64-bit                                                       | -                                                            | -                                                            |
| Storage space | 184 MB                                                       | 75 MB                                                        | 75 MB                                                        | -                                                            | -                                                            |
| RAM           | 3 MB                                                         | 35 MB                                                        | 35 MB                                                        | -                                                            | -                                                            |
| Network types | WiFi / LAN                                                   | WiFi / LAN                                                   | WiFi / LAN                                                   | -                                                            | -                                                            |
| Download link | [App CenterOpen external link](https://install.appcenter.ms/orgs/cloudflare/apps/1.1.1.1-windows-1/distribution_groups/release) or [1.1.1.1Open external link](https://1111-releases.cloudflareclient.com/windows/Cloudflare_WARP_Release-x64.msi) | [App CenterOpen external link](https://install.appcenter.ms/orgs/cloudflare/apps/1.1.1.1-macos-1/distribution_groups/release) or [1.1.1.1Open external link](https://1111-releases.cloudflareclient.com/mac/Cloudflare_WARP.zip) | [Package downloadOpen external link](https://pkg.cloudflareclient.com/packages/cloudflare-warp) or [APT/YUM Repository SetupOpen external link](https://pkg.cloudflareclient.com/install) | [1.1.1.1: Faster InternetOpen external link](https://apps.apple.com/us/app/id1423538627) | [1.1.1.1: Faster & Safer InternetOpen external link](https://play.google.com/store/apps/details?id=com.cloudflare.onedotonedotonedotone) |


## 开始操作

1. 点击下面表中的链接，下载客户端 

2. 安装后 点击 preference - account - Use different Key 

3. 打开链接Wrap+ Bot：[https://t.me/generatewarpplusbot…](https://t.co/hKRZUGqQAm) 去Telegram，按要求输入命令进行获取warp+ unlimited license key （或者联系我哦）

4. 填入KEY中即可完成！

例如：

- 帐户类型：WARP
- 许可密钥∶：z5wRe672-273yXLS1-******* (23837126 GB)
- 剩余数据：22,200,054.00GB

>【注】安装完成客户端后，会在电脑创建一个CloudflareWARP虚拟网卡


## 参考

- [cloudflare开发文档](https://developers.cloudflare.com/warp-client/get-started/linux/ )
- [ 1.1.1.1 with WARP](https://pkg.cloudflareclient.com/packages/cloudflare-warp) 