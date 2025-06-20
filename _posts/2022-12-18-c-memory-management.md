---
layout: post
title: "C++ Memory Management"
date: 2022-12-18 07:04:19 +0000
categories: [blog]
tags: []
---

# [](#%E7%AC%AC%E4%B8%80%E8%AE%B2-primitives)第一讲 primitives
### [](#1-overview)1. overview

- 资料： [DL Malloc](http://gee.cs.oswego.edu/dl/)

- 涉及的库

![1671347745514](https://Baymine.github.io/images/C-Memory-Management/1671347745514.png)

### [](#2%E3%80%813-%E5%86%85%E5%AD%98%E5%88%86%E9%85%8D%E7%9A%84%E6%AF%8F%E4%B8%80%E5%B1%82%E9%9D%A2%E5%8F%8A%E5%9F%BA%E6%9C%AC%E7%94%A8%E6%B3%95)2、3. 内存分配的每一层面及基本用法

![1671348085106](https://Baymine.github.io/images/C-Memory-Management/1671348085106.png)

本课程只考虑CRT以上的层次。

**基本工具**

![1671348161500](https://Baymine.github.io/images/C-Memory-Management/1671348161500.png)

**基本用法**

1
13

void* p3 = ::operator new (512);   // 512 bytes
::operator delete(p3);

#ifdef __BORLANDC__  // 不同库不同
	// 申请5个int。 一般容器中使用
	int* p4 = allocator<int>().allocate(5);
	allocator<int>().deallocate(p4, 5);
#endif

#ifdef __GNUC__   // 较早版本中
	void* p4 = alloc::allocate(512);
	alloc::deallocate(p4, 512);
 #endif

### [](#4%E3%80%815%E3%80%816%E3%80%81%E5%9F%BA%E6%9C%AC%E6%9E%84%E4%BB%B6%E2%80%94%E2%80%94new-delete-expression)4、5、6、基本构件——new delete expression
new 中实际上就是在调用malloc

1
9

$$class_name* pc = new class_name(1, 2);$$

// 编译器转换为
// 加上try catch
$$void* mem = operator new(sizeof(class_name));$$
$$pc = static_cast<class_name*>(mem);$$
pc->class_name::class_name(1, 2); // 只有编译其才能这样调用构造函数
// 但是可以直接调用析构函数

### [](#7%E3%80%81Array-new)7、Array new
当new一个数组的时候，系统会使用4个字节存放数组的一些信息，即为下图中的 `cookie`

1

Complex* pca = new Complex[3];

![1671438018665](https://Baymine.github.io/images/C-Memory-Management/1671438018665.png)

- 在进行array new的时候，单个元素不会独自进行内存对齐。
- 构建的时候是从上往下，析构的时候是由下往上
- 
![1671439085184](https://Baymine.github.io/images/C-Memory-Management/1671439085184.png)

`61h`就是cokie，需要进行内存对齐（VC6)中是16位对齐
- 对于申请的int类型的数组，可以直接使用delete，因为这些数据类型没有析构函数，

![1671440046493](https://Baymine.github.io/images/C-Memory-Management/1671440046493.png)
- 因为数组个数被写入，所以内存的整体布局会发生变化，所以不能直接用 `delete`来回收
- 
`61h`的大小计算
$$类大小*类个数=((3*4) * 3) = 36\ 上下debugger header = 32 + 4\ 两个61h=4*2=8$$
- 最后向16的倍数内存对齐最后的 `pad`

### [](#8-palcement-new)8.palcement new

允许将对象构造与已分配的内存中

![1671441329456](https://Baymine.github.io/images/C-Memory-Management/1671441329456.png)

### [](#9-random)9.random

- placement new 的重载
- 嵌入式指针使用案例（内存池）
通过一次性申请一定量的内存，减少每个内存中的cookie的数量，同时减少malloc的调用
- 整个内存是通过一个链表管理的，释放内存就是将空闲的内存插入到链表头部
- 但是申请的内存没有真正释放，所以可能会存在使用峰值的问题

![1671541094430](https://Baymine.github.io/images/C-Memory-Management/1671541094430.png)

- 可以自定义handler来让更多的空间可用，或者调用abort() 或 exit();

1

set_new_handler(handlerFunctionPoint);

- default, delete 关键字