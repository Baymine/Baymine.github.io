---
layout: post
title: "《Computer Systems: A Programmer Perspective 3rd ed》"
date: 2021-01-09 12:45:14 +0000
categories: [blog]
tags: []
---

# [](#%E7%AC%AC%E4%B8%80%E7%AB%A0-A-Tour-of-Computer-Systems)第一章 A Tour of Computer Systems

&#8195这本书的前言部分主要介绍了本书主要包含的内容（the hardware architecture, the operating system, the compiler, the network）还有一些学习的预备知识（C语言、Lunux系统）。

&#8195全文展开的逻辑是介绍Hello.c文件从编写到输出主要经历了什么

## [](#1-1-Information-Is-Bits-Context)1.1 Information Is Bits + Context

这一部分主要讲程序文件在计算机中的存贮方式

1
6

#include <stdio.h>

int main(){
	printf("Hello,world!\n");
	return 0;
}

这段代码在计算机中使用ASCII码存贮的，如下图：
<!-- Image removed: CSDN link no longer accessible -->

> 

Most computer systems represent text characters using the ASCII standard
that represents each character with a unique byte-size integer value.
The hello.c program is stored in a file as a sequence of bytes

注意每一行都是以换行符结束的，而换行符的ASCII码为10.
*包含ASCII字符的文件为文本文件，其他的文件为二进制文件。*
最后的注释部分介绍了C语言的优点，还有缺点：

> 

C pointers are a common source of confusion and programming errors.

<hr style=” border:solid; width:100px; height:1px;” color=#000000 size=1”>

## [](#1-2-Programs-Are-Translated-by-Other-Programs-into-Different-Forms)1.2 Programs Are Translated by Other Programs into Different Forms

<!-- Image removed: CSDN link no longer accessible -->
文件运行的时候会有四个阶段：
在预处理阶段，预处理器会处理带有#的语句，并将它直接插入到程序文本中。
编译阶段将文本文件转义成汇编语言文件，汇编语言相当于一种通用语言，能够使得不同的高级语言在同一个机器上运行。
汇编阶段将*hello.s*转换成机器语言，并将结果存储在*hello.o*文件当中，这时候的文件是可迁移的（relocatable object program）
链接阶段将程序文件中调用的一些函数方法的执行程序与主程序合并，使主程序调用的函数可以顺利运行，这时候的文件为*hello*,这时的文件已经准备好被加载入内存中，后被运行了。

## [](#1-4-Processors-Read-and-Interpret-Instructions-Stored-in-Memory)1.4 Processors Read and Interpret Instructions Stored in Memory

<!-- Image removed: CSDN link no longer accessible -->
What’s happening when we entering a sequence of command.
<!-- Image removed: CSDN link no longer accessible -->

## [](#1-5-Cache-Matter)1.5 Cache Matter

Note that we spend a lot of time to move data form disk to main memory by bus. Which is so-call *processor-memory gap* .In order to improve the performance of the operations,we use a Cache Memory between Main memory and Register which will store the information which is most likely to need in the near future.It maybe small to store data but fast to fletch when we need it.

> 

Because of physical laws, larger storage devices are slower than smaller storage devices.

<!-- Image removed: CSDN link no longer accessible -->

## [](#1-6-Storage-Devices-Form-a-Hierarchy)1.6 Storage Devices Form a Hierarchy

<!-- Image removed: CSDN link no longer accessible -->

## [](#1-7-The-Operating-System-Manages-the-Hardware)1.7 The Operating System Manages the Hardware

<!-- Image removed: CSDN link no longer accessible -->

### [](#1-7-1-Processes)1.7.1 Processes

<!-- Image removed: CSDN link no longer accessible -->

To be continue

# [](#%E6%80%BB%E7%BB%93)总结

1.英文术语：
interpreted language ：

> 

直译语言（英语：Interpreted language），又称直译式语言，是一种编程语言。这种类型的编程语言，会将代码一句一句直接运行，不需要像编译语言（Compiled language）一样，经过编译器先行编译为机器码，之后再运行。这种编程语言需要利用解释器，在运行期，动态将代码逐句直译（interpret）为机器码，或是已经预先编译为机器码的的子程序，之后再运行。
理论上，任何编程语言都可以是编译式，或直译式的。它们之间的区别，仅与程序的应用有关。许多编程语言同时采用编译器与解释器来实作，其中包括Lisp，Pascal，C，BASIC 与 Python。JAVA及C#采用混合方式，先将代码编译为bytecode，在运行时再进行直译。

magnetic-disk & solid state drives：磁盘和固态硬盘
lingking：链接器

> 

链接器（英语：Linker），又译为链结器、链接器，是一个进程，将一个或多个由编译器或汇编器生成的目标文档外加库链接为一个可执行文档。

metadata：

> 

元数据（Metadata），又称元数据、诠释数据、中继数据元数据，为描述数据的数据（data about data），主要是描述数据属性（property）的信息，用来支持如指示保存位置、历史数据、资源寻找、文档记录等功能。元数据算是一种电子式目录，为了达到编制目录的目的，必须在描述并收藏数据的内容或特色，进而达成协助数据检索的目的。

context exchange：

> 

上下文交换(英语：context switch)，又称环境切换，电脑术语，是一个保存和重建CPU的状态 (内文)，因此令多个进程(process)可以分享单一CPU资源的计算过程。要交换CPU上的进程时，必需先行保存目前进程的状态，再将欲运行的进程之状态读回CPU中。

System Call:

> 

在计算机中，系统调用（英语：system call），又称为系统调用，指运行在用户空间的进程向操作系统内核请求需要更高权限运行的服务。系统调用提供用户进程与操作系统之间的接口。大多数系统交互式操作需求在内核态执行。如设备IO操作或者进程间通信。