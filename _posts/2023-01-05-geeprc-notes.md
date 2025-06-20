---
layout: post
title: "GeePRC notes"
date: 2023-01-05 08:48:47 +0000
categories: [blog]
tags: []
---

## [](#%E9%A1%B9%E7%9B%AE%E5%A4%A7%E7%BA%B2)项目大纲

- 

codec.go

报文Header
- 消息体编码解码的接口 Codec
读取报头
- 读取主体
- 写入报头的方法

Codec的构造函数
可选用的编码方式
- 存储在一个map中
不同的编码方式调用不同的codec构造函数

gob.go

- gob结构体
- GobCodec实现接口codec

server.go

- Option
标识
Magic number

编码方式
默认的Option

main.go

- 创建一个监听者
通过一个协程在执行
- 协程中的得到的地址通过管道通知主线程

确定编码方式
发送接收
- 创建报头
- 写入
cc.Write()

接收回应
- cc.ReadHeader()

## [](#bug)bug

day5, go run main.go:
rpc server: register Foo.Sum
rpc server debug path: /debug/geerpc
call Foo.Sum error:rpc server: request handle timeout: expect within 10ns
exit status 1

## [](#Chanllenge)Chanllenge
### [](#%E7%BD%91%E7%BB%9C%E7%B2%98%E5%8C%85)网络粘包

执行 `go test -v` 会有一定概率出现测试卡死无响应的bug
[issue](https://github.com/geektutu/7days-golang/issues/26)

## [](#Great-designs)Great designs
### [](#%E4%BD%BF%E7%94%A8%E9%80%9A%E9%81%93%E5%AE%9E%E7%8E%B0%E8%B6%85%E6%97%B6%E5%88%A4%E6%96%AD)使用通道实现超时判断

在goroutine中，完成一步之后往管道内传入`struct {}{}`这样，在goroutine外部就可以接收到这些信息，这样外部就知道goroutine内部某个函数完成了，

1
12

callChannel := make(chan struct{})
go func(){
  err := call(args)
  callChannel <- struct{}{}
}()

select {
  case <-time.After(timeout):  // 处理超时
    timeout handling
  case <-callChannel:
    function finished
}

## [](#Knowledges)Knowledges
### [](#%E5%A6%82%E4%BD%95%E7%BB%93%E6%9D%9F%E4%B8%80%E4%B8%AAgoroutine)如何结束一个goroutine

利用管道传入一个结束信息（这里是true），然后返回函数即可

1
16

quit := make(chan bool)
go func() {
    for {
        select {
        case <- quit:
            return
        default:
            // Do other stuff
        }
    }
}()

// Do stuff

// Quit goroutine
quit <- true

### [](#encoding-gob)encoding/gob

- Package gob 管理 gobs 流 - 在编码器（发送器）和解码器（接收器）之间交换的二进制值
- 
```
enc := gob.NewEncoder(&network) // 将写入网络。
dec := gob.NewDecoder(&network) // 将从网络上读取。
// Encoding（发送）一些值。
err := enc.Encode(P{3, 4, 5, "Pythagoras"})
// 接收
var q Q
err = dec.Decode(&q)
```

### [](#%E5%8F%8D%E5%B0%84)反射
### [](#Context-package)Context package

- context 主要用来在 goroutine 之间传递上下文信息，包括：取消信号、超时时间、截止时间、k-v 等。
- 一句话：context 用来解决 goroutine 之间 `退出通知`、`元数据传递`的功能。
- ![](https://pic3.zhimg.com/80/v2-6a27526f536505cea08a5813ccce05b2_720w.webp)