---
layout: post
title: "Wireshark Lab: HTTP"
date: 2021-01-03 00:16:33 +0000
categories: [blog]
tags: []
---

# [](#Wireshark-Lab-HTTP)Wireshark Lab: HTTP
# [](#%E9%A2%84%E5%A4%87%E7%9F%A5%E8%AF%86)预备知识

坚持型连接&amp;非坚持型连接：是否在同一个TCP连接上完成所有的请求/应答报文的传输？Y：坚持型，N:非坚持型。

#### HTTP的非坚持型连接
现在来看看当你点击一个超链接的时候会发生什么。
1.客户机会对超链接的服务器通过80端口（TCP默认端口号）发起一个TCP连接
2.客户机通过套接字向服务器发送HTTP请求报文
3.服务器收到报文之后，从自己的内存（RAM or disk）中获取被请求的对象，并将这些对象封装至HTTP请求报文（HTLM）中，然后通过套接字发送给客户机。
4.HTTP服务器请求关闭TCP连接
5.客户机获取请求的对象，TCP连接彻底关闭。客户机从恢复报文中获取文件
6.获取其他的对象，继续循环上面的步骤

由此可见，每当一个对象被正确接收的时候，之前的建立的TCP连接都会被关闭。一般情况下，浏览器会建立5到10个并行TCP连接，这样的平行连接可以减短响应时间。

![HTLM相应时间](https://img-blog.csdnimg.cn/20210102200933336.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70#pic_center)
由上图，非坚持型下的HTLM的相应时间为：

#### HTTP的坚持型连接
非坚持型连接有以下几个缺点：
1.每一个请求对象都需要建立一次TCP连接，这样会导致额外的内存消耗

&gt; For each of these connections, TCP buffers must be allocated and TCP variables must be kept in both the client and server.

2.每一个对象的递交过程会导致两个RTT的时间消耗
##### 坚持型HTTP连接的断开

在HTTP1.1中，当TCP连接建立之后，剩余的对象都通过这个TCP连接递交。当递交结束之后，当这条TCP连接在一定的时间(a configurable timeout interval)没有被使用时，这条连接会自动关闭。

&gt; HTTP/2  builds on HTTP 1.1 by allowing multiple requests and replies to be interleaved in the same connection, and a mechanism for prioritizing HTTP message requests and replies within this connection.
（存疑）

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210102184014664.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70#pic_center)

#### HTTP的报文格式
###### 请求报文

1
2
3
4
5
6
7

//一个例子
//The great majority of HTTP request messages use the GET method.
GET /somedir/page.html HTTP/1.1 //the method field, the URL field, and the HTTP version field.
Host: www.someschool.edu  //对象所在的主机地址（Web代理缓存中需要）
Connection: close//表示非坚持型
User-agent: Mozilla/5.0 //浏览器的类型
Accept-language: fr//许多协商首部(negotiation header)中的一种

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210102204106878.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70#pic_center)
注意到上图出现的实体（Entity Body）部分，在GET方法中是空的，他在POST方法中，例如当用户提供搜索关键词的时候，POST仍然是向服务器请求获取网页，但是是网页特定的内容。
但是HTML表单（HTML form）通常用GET方法，并在URL（统一资源定位器）中加上输入的文本，就像这样：

1
2

//当你在某个网站上面搜索“monkeys” 和“bananas”的时候，URL会变成下面这个样子
 www.somesite.com/animalsearch?monkeys&amp;bananas

###### 应答报文

1
2
3
4
5
6
7
8
9

//一个例子
HTTP/1.1 200 OK//the protocol version field, a status code（状态码：请求结果）, and a corresponding status message.
Connection: close//非坚持型
Date: Tue, 18 Aug 2015 15:44:04 GMT//服务器从自己的文件系统中获取被请求对象，并将它插入到回应报文中，后将它发送给客户机时的时间
Server: Apache/2.2.3 (CentOS)//服务器类型
Last-Modified: Tue, 18 Aug 2015 15:11:03 GMT// It is critical for object caching, both in the local client and in network cache servers (also known as proxy servers).
Content-Length: 6821//被发送对象的比特数
Content-Type: text/html//发送主题的类型（HTML 文本）(The object type is officially indicated by the Content-Type: header and not by the file extension.)
(data data data data data ...)//报文核心部分（the meat of message）包含被请求的对象

报文请求结果类型：

&gt; 
&gt; **200 OK**: Request succeeded and the information is returned in the response.
**301 Moved Permanently**: Requested object has been permanently moved; the new URL is specified in Location : header of the response message. The client software will automatically retrieve the new URL.
**400 Bad Request**: This is a generic error code indicating that the request could not be understood by the server
**404 Not Found**: The requested document does not exist on this server.
**505 HTTP Version Not Supported**: The requested HTTP protocol version is not supported by the server.

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210102210031696.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70#pic_center)
状态行（state line）
表头行（header line）
(待续....)

&lt;hr style=” border:solid; width:100px; height:1px;” color=#000000 size=1”&gt;

# [](#%E6%80%BB%E7%BB%93)总结

问题：
1.HTTP/2？（unsolved）