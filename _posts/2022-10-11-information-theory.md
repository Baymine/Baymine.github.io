---
layout: post
title: "机器学习中的数学：信息论(Information Theory)"
date: 2022-10-11 14:19:24 +0000
categories: [blog]
tags: []
---

@[toc]

> 

参考：*Dive into Deep Learning A. zhang ect* Chapter 18 **Appendix: Mathematics for Deep Learning**

利用信息论我们可以测量或者比较在不同的信号（signals）中信息。在这部分，我们主要讨论机器学习对信息论的一些概念和应用。
首先我们先简要描述介绍一下机器学习和信息论之间的关系。机器学习的主要的任务就是从数据中提取出有价值的信息，然后利用这些信息去做一些预测。而信息论主要研究信息的编码、解码、转换和操作（sencoding, decoding, transmitting, and manipulating information）。所以，我们可以利用信息论来讨论机器学习在训练中对信息的处理过程。

# [](#%E4%BF%A1%E6%81%AF%EF%BC%88Information%EF%BC%89)信息（Information）

**信息**就是能够将所有事情通过一种或者是多种编码格式编码成一个特定的序列。但是怎么样编码才能正确地表述事物所具有的信息量呢？在我们描述一个事件的时候，如果这件事情是不寻常的，这时候我们需要更多的信息来描述，反之需要更少的信息。这就好比说一个普通的碗和清朝乾隆皇帝御用的碗，后者是比较少见的，需要更多的必要信息才能描述清楚它的特征。所以可以将信息表示为事件发生的抽象概率。

# [](#%E8%87%AA%E4%BF%A1%E6%81%AF%EF%BC%88Self-information%EF%BC%89)自信息（Self-information）

香农（Shannon）将**比特**（bit）作为信息的单位，这将时间发生的概率转换成比特数。这样，对于一个长度为的二进制序列所包含的信息为比特。
假设二进制序列每一个位置为1或者0的概率相等（都为）,所以对于一个事件,这个事件为：一个长度为二进制序列，每种序列出现的概率为,香农定义了**自信息**，将事件的概率转换成了比特数：

I(x) = -\log_2(p)

举例来说，对于一个序列“0010”的自信息为：

I("0010") = -\log_2(p("0010"))=-\log_2(\frac{1}{2^4})=4\ bits

* `在本章节中，我们省略log的下标，如无特殊说明都表示` 

# [](#%E7%86%B5%EF%BC%88Entropy%EF%BC%89)熵（Entropy）

自信息只能描述一个离散事件的信息，这部分介绍能够任意随机变量的描述方式。

## [](#%E6%8F%90%E5%87%BA%E7%86%B5%E7%9A%84%E5%8A%A8%E6%9C%BA%EF%BC%88Motivating-Entropy%EF%BC%89)提出熵的动机（Motivating Entropy）

熵的形式受限于**香农熵定理**：

2
3
4

我们可以将抛掷一个完全均匀的硬币所得到的信息为1比特作为基准，以消除使用不同的基本单位而导致的对同一事件的信息量上的差异。

## [](#%E5%AE%9A%E4%B9%89%EF%BC%88Definition%EF%BC%89)定义（Definition）

对于一个随机变量, 遵循概率分布,概率密度函数或概率质量函数为,我们利用熵来描述信息的期望值：

H(x)=-E_{x\sim P}[\log p(x)]

具体来说：

H(X)=\left\{\begin{aligned}
& -\sum_i p_i\log p_i, \quad p_i = P(X_i)\quad X 是离散型随机变量 \\
& -\int_x p(x)\log p(x) dx\quad X是连续型随机变量
\end{aligned}
\right.

连续性随机变量的熵也被称为**微分熵**（Differential Entropy） 

## [](#%E8%A7%A3%E9%87%8A%EF%BC%88Interpretation%EF%BC%89)解释（Interpretation）

在这一节中，主要解释两个关于上述公式的问题。

2

2
3

## [](#%E7%86%B5%E7%9A%84%E6%80%A7%E8%B4%A8%EF%BC%88Properties-of-Entropy%EF%BC%89)熵的性质（Properties of Entropy）

下面考虑随机事件, 它对应的概率分布为

- 对所有离散型随机变量

:(连续性随机变量的熵可能会是负数)
- 假设一个随机事件，我们想用一个新的概率分布来估计则有：H(X)=-E_{x\sim P}[\log p(x)]\le -E_{x\sim P}[\log q(x)]   当的时候，取得等号。
对于一个随机变量, 将会传递最多的信息，如果他能将这些信息均匀地分布在所有可能的结果上。具体来说，对于一个概率分布的k种相互独立的输出:H(X)\le \log(k), with\ equality\ if \ and \ only \ if \ p_i=\frac{1}{k},\forall_i但是如果是一个连续性随机变量，那么处理过程就会很麻烦了。我们假设P在一个有限的区间内，那么，如果这个随机变量在这个区间上满足均匀分布，那么这个随机变量的熵的值将会是最大的。# [](#%E4%BA%92%E4%BF%A1%E6%81%AF%EF%BC%88Mutual-Information%EF%BC%89)互信息（Mutual Information）在这部分，我们联合变量的熵。在本节中，我们使用的联合变量遵循联合概率分布,概率密度函数为,其中## [](#%E8%81%94%E5%90%88%E7%86%B5-Joint-Entropy)联合熵(Joint Entropy)联合熵与先前定义的熵的形式一致：H(X,Y)=-E_{(x,y)\sim P}[\log p_{X,Y}(x,y)]\tag {*}具体形式为：H(X,Y)=\left\{\begin{aligned}
&-\sum_x\sum_yp_{X,Y}(x,y)\log p_{X,Y}(x,y),\quad 离散型\\
&-\int_{x,y}p_{X,Y}(x,y)\log p_{X,Y}(x,y)dxdy,\quad 连续型
\end{aligned}\right.表示一对随机变量的全部的不确定性。当的时候，,当X与Y相互独立的时候,所以有：H(X),H(Y)\le H(X,Y)\le H(X)+H(Y)

## [](#%E6%9D%A1%E4%BB%B6%E7%86%B5%EF%BC%88Conditional-Entropy%EF%BC%89)条件熵（Conditional Entropy）
在机器学习中，我们更多的时候，我们更关注条件上而不是联合熵。例如我们要根据图片判断图片的标签，这就可以理解为在图片像素信息条件下的对标签的信息。条件熵的定义与之前的几种熵的定义相似：

H(Y|X)=-E_{(x,y)\sim P}[\log p(y|x)]

其中：.条件熵与熵和联合熵的关系为：

H(Y|X)=H(X,Y)-H(X)

这样条件熵既可以理解为存在于Y中的而不存在与X中的的信息。

## [](#%E4%BA%92%E4%BF%A1%E6%81%AF%EF%BC%88Mutual-Information%EF%BC%89-1)互信息（Mutual Information）

上面我们讨论了联合变量之中独有的信息，现在我们讨论两个变量之间共有的信息。所以根据定义可以得到（互信息:）

I(X,Y) = H(X,Y)-H(Y|X)-H(X|Y)

将原先的定义式带入，整理可得：

I(X,Y)=E_xE_y\left\{
p_{X,Y}(x,y)\log \frac{p_{X,Y}(x,y)}{p_X(x)p_Y(y)}
\right\}

在本节中提到的定义之间的关系如下图：
![在这里插入图片描述](https://img-blog.csdnimg.cn/013c87570cd9401fb52ba8c3dd7d9da8.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_Q1NETiBATGVhcm5pbmdEZWVwbHk=,size_29,color_FFFFFF,t_70,g_se,x_16)

## [](#%E4%BA%92%E4%BF%A1%E6%81%AF%E7%9A%84%E6%80%A7%E8%B4%A8-Properties-of-Mutual-Information)互信息的性质(Properties of Mutual Information)

- 对称性：

- 非负性：

- 如果两个随机变量是相互独立的，那么

- 如果X是Y的可逆函数：

## [](#%E7%82%B9%E9%97%B4%E4%BA%92%E4%BF%A1%E6%81%AF%EF%BC%88Pointwise-Mutual-Information%EF%BC%89)点间互信息（Pointwise Mutual Information）
点间互信息:就是互信息定义中的对数部分：

pmi(x,y) = \log\frac{p_{X,Y}(x,y)}{p_X(x)p_Y(y)}

他描述的是两个联合事件发生的概率比分别发生的概率的具体的数值关系。

## [](#%E4%BA%92%E4%BF%A1%E6%81%AF%E7%9A%84%E5%BA%94%E7%94%A8%EF%BC%88Applications-of-Mutual-Information%EF%BC%89)互信息的应用（Applications of Mutual Information）

在自认语言处理中，**歧义消除**（Ambiguity Resolution）是一件比较难的事情。也就是一些词在文中的含义不是很明确。例如先前出现的新闻“亚马逊起火了”，我们不知道是公司起火了，还是那个雨林起火了。这时候就产生了歧义。我们先找出一组词，这些词与亚马逊公司有较大互信息。同样找到与亚马逊雨林有较大互信息的词，然后分析这些那些在文中有更高的出现频率。利用这个，我们能够了解新闻是关于公司的还是雨林的。

# [](#Kullback%E2%80%93Leibler-%E6%95%A3%E5%BA%A6%EF%BC%88Kullback%E2%80%93Leibler-Divergence%EF%BC%89)Kullback–Leibler 散度（Kullback–Leibler Divergence）

我们可以利用范数来表示任何维度两点之间的距离。现在我们想知道两个概率分布之间的距离（相似程度）。**KL散度**就是一种测量两种分布之间相似程度的量。

## [](#%E5%AE%9A%E4%B9%89%EF%BC%88Definition%EF%BC%89-1)定义（Definition）

对于一个随机变量遵循概率分布,概率密度分布为.我们利用另一个概率分布(),那么和之间的KL散度（相对熵，Relative Entropy）定义为：

D_{KL}(P\|Q)=E_{x\sim P}[\log\frac{p(x)}{q(x)}]

可见DL散度就是在描述两个随机变量之间不确定性程度的相对关系。

## [](#%E6%80%A7%E8%B4%A8%EF%BC%88Properties%EF%BC%89)性质（Properties）

- 非对称性：

- 非负性：,当时取得等号。
- 如果则

- 以下三种表达式等价：D_{KL}(P(X,Y)\| P(X)P(Y))E_Y\{D_{KL}(P(X|Y))\|P(X))\}E_X\{D_{KL}(P(Y|X)\|P(Y))\}> 
For the first term, we interpret mutual information as the KL divergence between P(X, Y ) and the product of P(X) and P(Y ), and thus is a measure of how different the joint distribution is from the distribution if they were independent. For the second term, mutual information tells us the average reduction in uncertainty about Y that results from learning the value of the ʼs distribution. Similarly to the third term.

# [](#%E4%BA%A4%E5%8F%89%E7%86%B5%EF%BC%88Cross-Entropy%EF%BC%89)交叉熵（Cross-Entropy）

对于一个二分类问题，预测值为.预测结果为1的概率为：所以log似然方程为：

\begin{aligned}
l(\theta)&=\log L(\theta)\\
&=\log \prod^n_{i=1}\pi_i^{y_i}(1-\pi_i)^{1-y_i}\\
&=\sum^n_{i=1}y_i \log(\pi_i)+(1-y_i)\log(1-\pi_i)
\end{aligned}

我们的目标就是最大化这个似然函数，这种方法就是极大似然估计。看到式中的自然对数，我们可以联想到之前提到一些信息论的概念。这暗示我们这个函数可以从信息论的角度理解。

## [](#%E6%AD%A3%E5%BC%8F%E5%AE%9A%E4%B9%89%EF%BC%88Formal-Definition%EF%BC%89)正式定义（Formal Definition）

我们假设有两个随机变量:(前者是真实值的分布，后者是预测值的分布).，我们可以通过交叉熵来描述两种分布之间的散度：

CE(P,Q)=-E_{x\sim P}[\log (q(x))]

通过之前提到的关系式，可以将上式转化为：

CE(P,Q) = H(P)+D_{KL}(P\|Q)## [](#%E6%80%A7%E8%B4%A8%EF%BC%88Properties%EF%BC%89-1)性质（Properties）

交叉熵可以用于优化问题的损失函数，以下几种说法是等价的：

- 最大化分布对于分布P的预测概率(最大化

)
- 最小化交叉熵

- 最小化KL散度

这些性质可以从交叉熵的定义中得出。注意因为P是真实值的分布，所以是一个常量。

## [](#%E4%BA%A4%E5%8F%89%E7%86%B5%E4%BD%9C%E4%B8%BA%E5%A4%9A%E5%85%83%E5%88%86%E7%B1%BB%E9%97%AE%E9%A2%98%E7%9A%84%E7%9B%AE%E6%A0%87%E5%87%BD%E6%95%B0%EF%BC%88Cross-Entropy-as-An-Objective-Function-of-Multi-class-Classification%EF%BC%89)交叉熵作为多元分类问题的目标函数（Cross-Entropy as An Objective Function of Multi-class Classification）

现在考虑一个k分类问题，这个分类问题的标签用独热编码（One-hot encoding）表示,预测标签值为：

\hat y_i=p_\theta(y_i|x_i)=\sum^k_{j=1}y_{ij}p_\theta(y_{ij}|x_i)

所以交叉熵可以表示为：

CE(y,\hat y)=-\sum^n_{i=1}y_i\log\hat y_i=-\sum^n_{i=1}\sum^k_{j=1}y_{ij}\log(y_{ij}|x_i)

另一方面，我们可以利用极大似然估计来解决这个问题。假设一个随机变量满足k分类多元伯努利分布，对应的概率为,也就是：

p(z)=p(z_1,\cdots,z_k)=Multi(p_1,\cdots,p_k),\ where\ \sum^k_{i=1}p_i=1

z的联合概率质量函数为:

p^z=\prod^k_{j=1}p^{z_j}_j

所以对应的log似然方程为：

l(\theta)=\log L(\theta)=\log\prod^n_{i=1}p^{y_i}=\log\prod^n_{i=1}\prod_{j=1}^{k}p^{y_{ij}}=\sum^n_{i=1}\sum^k_{j=1}y_{ij}\log p_j

所以对于多分类问题最大化log似然函数等价于最小化交叉熵损失