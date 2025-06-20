---
layout: post
title: "Wireshark Lab:Getting Started"
date: 2021-01-02 08:46:57 +0000
categories: [blog]
tags: []
---

# [](#Wireshark-Lab-Getting-Started)Wireshark Lab:Getting Started

《计算机网络自顶向下方法7e》实验

# [](#%E5%89%8D%E8%A8%80)前言

第一次实验主要就是介绍Wireshark应该怎么用，还有大致讲了Wireshark的工作原理。

# [](#%E4%B8%80%E3%80%81How-Wireshark-Works)一、How Wireshark Works?

<!-- Image removed: CSDN link no longer accessible -->
包嗅探器（Packet Sniffer）
其本身不主动运行，只是观察应用发送和接收的数据包，并保存这些数据包的一个备份。

> 

嗅探（Sniffers）是一种黑客的窃听手段，一般是指使用嗅探器对数据流的数据截获与封包分析（Packet analysis）。

包捕捉器：接受数据链路层的帧，因为在这一层，数据包是最完整的（发送来的数据报没有被解封装，发送的数据报在这一层完成了所有的封装）。
包分析器：能够识别数据包的协议，以便将各层的协议部分从下一层的数据报中分离出来。

# [](#%E4%BA%8C%E3%80%81Wireshark%E7%9A%84%E7%95%8C%E9%9D%A2%E4%BB%8B%E7%BB%8D)二、Wireshark的界面介绍

<!-- Image removed: CSDN link no longer accessible -->

# [](#%E4%B8%89%E3%80%81%E5%AE%9E%E9%AA%8C%E8%BF%87%E7%A8%8B)三、实验过程

i）运行Wireshark，然后在浏览器中访问[http://gaia.cs.umass.edu/wireshark-labs/INTRO-wireshark-file1.html](http://gaia.cs.umass.edu/wireshark-labs/INTRO-wireshark-file1.html)
ii）停止Wireshak，在过滤器中输入http。
<!-- Image removed: CSDN link no longer accessible -->

在对应层可以看到对应协议的一些信息，例如在IP层可以看到数据包的发送者和接收者的IP地址。

# [](#%E6%80%BB%E7%BB%93)总结

How long did it take from when the HTTP GET message was sent until the HTTP
OK reply was received?（Unsolved）