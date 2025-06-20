---
layout: post
title: "Basic Knoledge"
date: 2022-11-29 12:44:45 +0000
categories: [blog]
tags: []
---

# [](#%E6%9D%82%E9%A1%B9)杂项

- 

Small tricks

// 取中间的数：
int mid = (left + right) / 2; // 有溢出的风险
int mid = left + ((right - left) &gt;&gt; 1); // 这样更好

- 当异常发⽣时，C++通常会调⽤对象的析构函数来释放资源
- 指向虚函数表的指针 `vptr`需要在构造函数中进⾏初始化
- 
如何让类不能实例化

将类定义位抽象类（包含纯虚函数）
- 将构造器声明为 `private`

虚继承

- 在菱形继承的场景下，会产生两份基类数据，浪费空间，同时访问基类还需要通过域运算符
- 利用虚继承，在间接继承共同基类时是保留一份基类成员。创建派生类实例的时候，只需要调用一次基类的构造函数


class A{}
class B : virtual public A{}

在 C 语言中，数据类型指的是用于声明不同类型的变量或函数的一个广泛的系统。变量的类型决定了变量存储占用的空间，以及如何解释存储的位模式。
#### [](#Linux-%E5%92%8C-UNIX-%E7%9A%84%E5%85%B3%E7%B3%BB-%E5%8C%BA%E5%88%AB)Linux 和 UNIX 的关系/区别

- 
Linux 是一个类似 Unix 的操作系统，Unix 要早于 Linux，Linux 的初衷就是要替代 UNIX，并在功能和用户体验上进行优化，所以 Linux 模仿了 UNIX（但并没有抄袭 UNIX 的源码），使得 Linux 在外观和交互上与 UNIX 非常类似。

析构函数

类类型：如 `struct`、`class`、`union`

- 没有自定义析构函数，那么编译器就会为它们生成内联(inline)、public 的析构函数。

对于析构函数的调用，需要是 public 的访问权限，否则会导致编译错误。

# [](#Git)Git

\text{工作区}\stackrel{add}{\rightarrow}\text{暂存区}\stackrel{commit}{\rightarrow}\text{本地仓库}\stackrel{push}{\rightarrow}\text{远程仓库}\stackrel{pull}{\rightarrow}\text{本地}

![1672140678237](https://Baymine.github.io/images/Basic_must_known/1672140678237.png)


# In the work directory
git config --global user.name "yourName"
git config --global user.email yourEmail

git init # initialize the repository
git status # repository information
git add fileName
git commit -m "commit msg"EADADWE
git log  # 查看以前的版本

touch .gitignore  # 不追踪的文件

# 创建新分支
git branch branchName

# 两种切换分支的命令
git checkout branchName
	- git checkout -d branchName  # 删除分支
	- git checkout -b temp  # 创建并切换到新建的分支
git switch branchName

# 合并分支
git merge temp

# add 和 commit合在一起写
git commit -a -m "msg"  # 或者-am

# 下载远程内容
#### 直接下载zip是不会下载版本信息的，所以需要使用以下命令
git clone

 ESDAW

# [](#C-C)C/C++
### [](#%E6%9D%A1%E4%BB%B6%E5%8F%98%E9%87%8F%E7%9A%84%E8%99%9A%E5%81%87%E5%94%A4%E9%86%92)[条件变量的虚假唤醒](https://www.cnblogs.com/tqyysm/articles/9765667.html)


// wait 端
lock(mutex);
while(queue.empty()){  // 如果使用if可能会导致虚假唤醒
	cond.wait();
}
x = queue.pop();
unlock(mutex);

// signal/broadcast端
lock(mutex);
queue.push_back(x);
unlock(mutex);
cond.notify();

当条件变量满足的时候，挂起的线程会被唤醒，当他准备获取锁之前，有其他线程将变量改变了，这时候条件变量不满足了，所以这次唤醒是虚假的。

当某个条件满足的时候（即wait端中while中的条件），之后就进入挂起状态，用if语句那么挂起状态结束以后，就会继续往下，但是这个时候条件不一定满足（虚假唤醒时），所以应该利用while，这样可以**进行第二次判断**，这样就不会因为虚假唤醒的情况而被唤醒。

### [](#Function-pointer)[Function pointer](https://stackoverflow.com/questions/840501/how-do-function-pointers-in-c-work)



int addInt(int n, int m) {
    return n+m;
}

int (*functionPtr)(int,int); // Declare
functionPtr = &amp;addInt;  // Assigment
int sum = (*functionPtr)(2, 3); // usage: sum == 5

// As a parameter
int add2to3(int (*functionPtr)(int, int)) {
    return (*functionPtr)(2, 3);
}

// this is a function called functionFactory which receives parameter n
// and returns a pointer to another function which receives two ints
// and it returns another int
int (*functionFactory(int n))(int, int) {
    printf("Got parameter %d", n);
    int (*functionPtr)(int,int) = &amp;addInt;
    return functionPtr;
}

// note that the typedef name is indeed myFuncDef
// Confused here ???????
typedef int (*myFuncDef)(int, int);

myFuncDef functionFactory(int n) {
    printf("Got parameter %d", n);
    myFuncDef functionPtr = &amp;addInt;
    return functionPtr;
}


int addInt(int n, int m) {
    return n+m;
}

int (*functionPtr)(int,int); // Declare
functionPtr = &amp;addInt;  // Assigment

cout &lt;&lt; addInt &lt;&lt; endl; // Return 1

> 
cout 打印函数返回1的[原因](https://blog.csdn.net/Q_1849805767/article/details/107391572)：
C++调用非静态的成员函数时，采用的是一种 __thiscall 的函数调用方式。采用这种调用方式，编译器在编译的时候，会在调用的函数形参表中增加一个指向调用该成员函数的指针，也就是我们经常说的this指针。调用的形式类似于Base::f1(Base* this, otherparam…)，在函数体中，涉及到对象的成员变量或者其他成员函数，都会通过这个this指针来调用，从而达到在成员函数中处理调用对象所对应的数据，而不会错误处理其他对象的数据。可见，虽然我们必须通过对象来调用动态函数，但是其实我们访问的都是同一个成员函数。所以我们采用&amp;Base::f1来获取成员函数地址是没错的，动态函数同样是跟类绑定而不是跟对象绑定的。

出错的原因是，`输出操作符&lt;&lt;没有对void(__thiscall A:: *)()类型重载，编译器将这种类型转换为bool类型，所以输出了1；`

对于静态函数，其调用方式并非**thiscall，&lt;&lt;有对它的重载，因此类的静态函数可以直接用cout输出函数地址。我们可以用printf输出，因为他可以接收任意类型的参数，包括**thiscall类型

## [](#Upcasting)[Upcasting](http://c.biancheng.net/view/2284.html)


class A { void func1(); }
class B : A{ void func1(); }

A a; B b;
// b = a; // Downcasting
a = b; // Upcasting. 派生类成员变量将会被舍去，只保留基类成员变量

// 对象之间的赋值不会影响成员函数，也不会影响 this 指针
a.func1(); // 调用的是A中的函数。

> 
这种转换关系是不可逆的，只能 `用派生类对象给基类对象赋值`，而 `不能`用基类对象给派生类对象赋值。理由很简单，基类不包含派生类的成员变量，无法对派生类的成员变量赋值。同理，同一基类的不同派生类对象之间也不能赋值。(如果多出数据，编译器会舍弃，但是少数据了，那么编译器就不知道如何填充剩下的内存了)

**将派生类指针赋值给基类指针**

> 

将派生类指针赋值给基类指针时，通过基类指针只能使用派生类的成员变量，但不能使用派生类的成员函数.

编译器通过指针访问成员变量，但是不会通过指针访问成员函数，而是通过指针类型来访问。所以，当指针变化的时候，改变的只是指向的内存，也就是对应的类成员变量存储的位置变成了赋值类中的成员变量。

## [](#MMAP)[MMAP](https://zhuanlan.zhihu.com/p/357820303)

- 

传统IO

整个过程发生了**4次用户态和内核态的上下文切换**和**4次拷贝(1.用户发起read，2.读缓存拷贝到用户缓存，3.用户发起write，4.拷贝到网卡)**

- ![img](https://Baymine.github.io/images/Basic_must_known/readio.webp)
- 

DMA拷贝

IO操作，都是通过CPU发出对应的指令来完成，但是相比CPU来说，IO的速度太慢了，CPU有大量的时间处于等待IO的状态。因此就产生了**DMA（Direct Memory Access**)直接内存访问技术，本质上来说他就是一块 `主板上独立的芯片`，通过它来进行内存和IO设备的数据传输，从而减少CPU的等待时间。

零拷贝

- 计算机执行操作时，CPU不需要先将数据从某处内存复制到另一个特定区域，这种技术通常用于通过网络传输文件时节省CPU周期和内存带宽。
- 减少用户态和内核态的切换次数以及CPU拷贝的次数。
- 

常见的几种零拷贝技术

mmap + write
使用 `mmap`替换了read+write中的read操作，减少了一次CPU的拷贝。
- 
`mmap`主要实现方式是将读缓冲区的地址和用户缓冲区的地址进行映射
- 
**4次用户态和内核态的上下文切换**和**3次拷贝**（1.mmap调用，2.mmap返回，3.用户调用write，4.拷贝到网卡）
- ![img](https://Baymine.github.io/images/Basic_must_known/mmap+write.webp)
- 
`mmap`的方式节省了一次CPU拷贝，同时由于用户进程中的内存是虚拟的，只是映射到内核的读缓冲区，所以可以节省一半的内存空间，比较适合大文件的传输。

sendfile
- Linux2.1内核版本后引入的一个系统调用函数，通过使用 `sendfile`数据可以直接在内核空间进行传输，因此避免了用户空间和内核空间的拷贝
- 
**2次用户态和内核态的上下文切换**和**3次拷贝**

- ![img](https://Baymine.github.io/images/Basic_must_known/sendfile.webp)
- sendfile方法IO数据对用户空间完全不可见，所以只能适用于完全不需要用户空间处理的情况，比如静态文件服务器。

sendfile + DMA Scatter/Gather
- 对 `sendfile`做了进一步优化，通过引入新的硬件支持，这个方式叫做DMA Scatter/Gather 分散/收集功能。
- 
**2次用户态和内核态的上下文切换**和 **2次拷贝** ，其中更重要的是完全没有CPU拷贝
- ![](https://Baymine.github.io/images/Basic_must_known/DMS.webp)

****## [惊群效应](https://zhuanlan.zhihu.com/p/385410196)

- 应用程序是通过 socket 和协议栈交互的，socket 隔离了应用程序和协议栈，socket 是两者之间的接口，对于应用程序，它代表协议栈；而对于协议栈，它又代表应用程序
- 

一个典型的accept惊群现象，及解决措施

inux 内核通过睡眠队列来组织所有等待某个事件的 task，而wakeup 机制则可以异步唤醒整个睡眠队列上的 task
- 在唤醒睡眠队列的时候，会遍历队列链表上的每一个节点，并调用对应的callback，这样一个connect到达的时候，会将队列中所有的线程唤醒，但只有一个返回task，其他返回-1(EAGAIN: Resource temporarily unavailable)
- 添加了一个 WQ_FLAG_EXCLUSIVE 标记告诉内核进行排他性的唤醒，即唤醒一个进程后即退出唤醒的过程

select/poll/Epoll “惊群”现象

- 某一时刻多个进程(线程)阻塞在 select/poll/epoll_wait 系统调用上，当一个请求上来的时候，多个进程都会被 select/poll/epoll_wait 唤醒去 accept，但只有一个是有效的。
- Niginx的解决方法
一次仅允许一个进程将 listen fd 放入自己的 epoll 来监听其 READ 事件的方式来达到 listen fd”惊群”避免
- 同一时刻仅允许一个 worker 进程监听 listen fd 的可读事件的方式

Epoll”惊群”之 LT(水平触发模式)、ET(边沿触发模式)
被Poll的fd, 必须在实现上支持内核的Poll技术，比如fd是某个字符设备,或者是个socket, 它必须实现file_operations中的poll操作, 给自己分配有一个等待队列头wait_queue_head_t，主动poll fd的某个进程task必须分配一个等待队列成员, 添加到fd的等待队列里面去, 并指定资源ready时的回调函数，用socket做例子, 它必须有实现一个poll操作, 这个Poll是发起轮询的代码必须主动调用的, 该函数中必须调用poll_wait(),poll_wait会将发起者作为等待队列成员加入到socket的等待队列中去，这样socket发生事件时可以通过队列头逐个通知所有关心它的进程。

[简易版本](https://zhuanlan.zhihu.com/p/37861062)

- 出现场景
accept
多线程中的accept函数同时监听一个listenfd，当这个fd可读的时候，等待队列中的所有进程就会被唤醒
- 解决：当内核接受到一个连接之后，只会唤醒等待队列上的第一个线程

epoll
- 使用多线程epoll对同一个fd进行监控的时候，当fd事件到来时，内核会把所有epoll线程唤醒
- 由于当事件来临的时候，不清楚需要几个线程，所以只能将所有线程唤醒（而在accept中，已知只会需要一个线程）
- 解决：多个进程将listenfd加入到epoll之前，首先尝试获取一个全局的accept_mutex互斥锁，只有获得该锁的进程才可以把listenfd加入到epoll中

线程池
- 当我们往任务队列中放入任务时，需要唤醒等待的线程来处理任务，如果我们使用C++标准库中的函数notify_all()来唤醒线程，则会将所有的线程都唤醒
- 解决方案：对于只需要唤醒一个线程的情况，我们需要使用notify_one()函数代替notify_all()只唤醒一个线程，从而避免惊群问题。

## [](#CPU%E8%B0%83%E5%BA%A6%E7%AE%97%E6%B3%95)CPU调度算法
## [](#QUIC)QUIC

![](https://Baymine.github.io/images/Basic_must_known/QUIC%E5%B0%81%E8%A3%85%E8%BF%87%E7%A8%8B.png)

- 0-RTT

不用看：env_monitor、moses  启动：tool_chain_config.py