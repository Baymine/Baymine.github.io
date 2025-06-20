---
layout: post
title: "机器学习中的数学：（五）概率与分布(Probability and Distributions)"
date: 2021-05-11 02:17:57 +0000
categories: [blog]
tags: []
---

<!-- Image removed: CSDN link no longer accessible -->

# [](#%E6%A6%82%E7%8E%87%E7%A9%BA%E9%97%B4%E7%9A%84%E6%9E%84%E9%80%A0%EF%BC%88Construction-of-a-Probability-Space%EF%BC%89)概率空间的构造（Construction of a Probability Space）
## [](#%E5%93%B2%E5%AD%A6%E9%97%AE%E9%A2%98%EF%BC%88Philosophical-Issues%EF%BC%89)哲学问题（Philosophical Issues）

这部分是对概率的一个解释。概率论是推理系统的一个基础，个人理解就是推理实际上就是找到对某件事情的可能性最大的结果。这里引入了一个**合理性**（plausibility），并用数学标准描述出来了。

在机器学习中，对概率的解释有两种，一种是**贝叶斯式**（the Bayesian）还有一种是**频率论**（Frequentist）前者用概率描述事物的不确定性，后者用在特定时间段中发生特定事情的频率。

## [](#%E6%A6%82%E7%8E%87%E5%92%8C%E9%9A%8F%E6%9C%BA%E5%8F%98%E9%87%8F%EF%BC%88Probability-and-Random-Variables%EF%BC%89)概率和随机变量（Probability and Random Variables）

**几个概念**：
**样品空间**（sample space）：一个实验可能出现的所有的结果的集合。
**事件空间**(event space):样品空间的一个子集
**概率P**（probability）：,一个事件发生的概率。
**目标空间**（target space）和**随机变量**(random variable)：为了找到样品空间中我们关注的量，用一个函数， 其中,称为**随机变量**。(对，随机变量实际上是一个函数)

> 

One way to understand the transformation of probability from events in  via the random variable X is to associate it with the probability of the pre-image of S
对于一个随机变量和目标空间的一个子集,则为经过变换的原象（pre-image），也就是中的经过的变换之后得到，所以有：

$$P_X(S) = P(X\in S)=P(X^{-1}(S))=P(\{\ \omega\in\Omega:X(\omega)\in S \})$$

这里称或者为随机变量的**分布**（distribution）或者（law？）
<!-- Image removed: CSDN link no longer accessible -->

个人理解，随机变量实际上就是对样品空间的某些特性的量化描述，例如，对于一个抛两个硬币的实验，在样品空间中，一次实验正面出现的次数可以为0、1、2，可以将这些数字对应到事件上去，这就是随机变量。

## [](#%E7%BB%9F%E8%AE%A1%EF%BC%88Statistics%EF%BC%89)统计（Statistics）

统计和概率往往是一起出现的，但是二者的侧重点不太一样，前者是关注找出能解释观察到的现象的内在过程。后者可以认为是一些过程的模型，其中的不确定性事件被随机变量存储下来，然后用概率的一些规律去弄清楚发生了什么。

# [](#%E7%A6%BB%E6%95%A3%E6%A6%82%E7%8E%87%E5%92%8C%E8%BF%9E%E7%BB%AD%E6%A6%82%E7%8E%87%EF%BC%88Discrete-and-Continuous-Probabilities%EF%BC%89)离散概率和连续概率（Discrete and Continuous Probabilities）

离散型概率和连续型概率的区别就是前者的目标空间是离散的，后者是连续的。也就是前者的随机变量是由一个个数组成，后者则是一个连续的区间。

## [](#%E7%A6%BB%E6%95%A3%E5%9E%8B%E6%A6%82%E7%8E%87%EF%BC%88Discrete-Probabilities%EF%BC%89)离散型概率（Discrete Probabilities）

<!-- Image removed: CSDN link no longer accessible -->
由上图可以得到几个概念：
**联合概率（joint probability）**：两个事件的交集

$$P(X =x_i, Y = y_i)=\frac {n_{ij}}{N}$$

也可以写成

**边际概率（marginal probability）**：
**条件概率（conditional probability）**：当一个事件发生时另一个事件发生的概率

$$P(X=x_{i}|Y=y_{ij})=\frac {n_{ij}}{r_j}## [](#%E8%BF%9E%E7%BB%AD%E6%80%A7%E6%A6%82%E7%8E%87%EF%BC%88Continuous-Probabilities%EF%BC%89)连续性概率（Continuous Probabilities）$$
> 

没弄懂。
<!-- Image removed: CSDN link no longer accessible -->
还有之后提到的，在连续空间中两个反直觉的问题：
1. needs to be restricted to behave well under set complements, set intersections,and set unions
2.测量集合的大小。量度（measure）、集的势（cardinality）：集合中的元素的个数，当两个集合中的元素个数相等的时候，称为**等势**
Sets that behave well under set operations and additionally have a topology are called a **Borel -algebra**

**概率密度函数**
<!-- Image removed: CSDN link no longer accessible -->
用概率密度函数可以求解在给定区间当中的概率：

$$P(a\le X\le)=\int^a_bf(x)dx$$

注意一点，一个点在连续函数中出现的概率为0，即在上式时.

**累积分布函数**
<!-- Image removed: CSDN link no longer accessible -->
即：

$$F_X(x)=\int^{x_1}_{-\infin}\dots\int^{x_D}_{-\infin}f(z_1,\dots,z_D)dz_1\dots dz_D# [](#%E5%8A%A0%E6%B3%95%E6%B3%95%E5%88%99%E3%80%81%E4%B9%98%E6%B3%95%E6%B3%95%E5%88%99%E5%92%8C%E8%B4%9D%E5%8F%B6%E6%96%AF%E5%AE%9A%E7%90%86%EF%BC%88Sum-Rule-Product-Rule-and-Bayes%E2%80%99-Theorem%EF%BC%89)加法法则、乘法法则和贝叶斯定理（Sum Rule, Product Rule, and Bayes’ Theorem）$$

**加法法则**：

$$p(\boldsymbol{x})=\left\{\begin{array}{ll}\sum\limits_{\boldsymbol{y} \in \mathcal{Y}} p(\boldsymbol{x}, \boldsymbol{y}) & \text { if } \boldsymbol{y} \text { is discrete } \\ \\ \int_{\mathcal{Y}} p(\boldsymbol{x}, \boldsymbol{y}) \mathrm{d} \boldsymbol{y} & \text { if } \boldsymbol{y} \text { is continuous }\end{array}\right.$$

推广至多变量：
设:

$$p(x_i)=\int p(x_1,\dots,x_D)d\boldsymbol x_{\backslash i}$$

其中，,表示除了以外的所有的元素。

**乘法法则**

p(x,y) = p(y|x)p(x)\\ p(y,x)=p(x|y)p(y)

由于随机变量的顺序无关紧要，所以上面两个式子是等价的。

**贝叶斯公式**
这个公式可以由乘法法则推出。（也被称为**概率逆**（probabilistic inverse））
<!-- Image removed: CSDN link no longer accessible -->

> 

the posterior distribution is the quantity of interest as it **encapsulates all available information from the prior and the data.**

<!-- Image removed: CSDN link no longer accessible -->
从上图中理解，最终的后验概率就是浅蓝色部分占蓝色部分的比例。
称为**先验概率**，描述的是一些已知事件发生的概率，之后的是在这些已知事件中y发生的概率称为**似然概率**，最后是y事件在整体中发生的概率。

> 

举一个例子，想要知道一群人当中脾气好的女生有多少，首先，女生在人群中比例可以看成先验概率，而女生中脾气好的人数比例可以看成似然概率，所以的意思就是脾气好的人中女生的比例,但是男生中也有脾气好的，所以用女生脾气好的人数，除以所有脾气好的人数就是想要求得概率了。

似然函数(likelihood function):在该数据下，数据拟合的好坏,也就是在当前参数的情况下对真是数据的匹配情况。具体来说就是在给的那个参数的情况下，取得预期值的概率的大小，即

**边际似然（marginal likelihood/evidence）**

$$p(\boldsymbol y):= \int p(\boldsymbol y|\boldsymbol x)p(\boldsymbol x)d \boldsymbol x=\mathbb E_X[p(\boldsymbol y|\boldsymbol x)]$$

由上式可知，边际似然是与x相互独立的，这也被称为期望似然概率。

# [](#%E6%91%98%E8%A6%81%E7%BB%9F%E8%AE%A1%E5%92%8C%E7%8B%AC%E7%AB%8B%E6%80%A7%EF%BC%88Summary-Statistics-and-Independence%EF%BC%89)摘要统计和独立性（Summary Statistics and Independence）
> 

摘要统计:In descriptive statistics, summary statistics are used to summarize a set of observations, in order to communicate the largest amount of information as simply as possible
实际上就是用一种尽可能简洁得方式概括数据的信息。

## [](#%E5%9D%87%E5%80%BC%E5%92%8C%E5%8D%8F%E6%96%B9%E5%B7%AE%EF%BC%88Means-and-Covariances%EF%BC%89)均值和协方差（Means and Covariances）

**数学期望**（Expected Value）

$$g:\mathbb R\rightarrow\mathbb R,\quad X \sim p(x) \\ \\ \mathbb E_X[g(x)]=\left\{\begin{array}{ll}\int_\mathcal Xg(x)p(x)dx,\quad continuous\\ \\ \sum\limits_{x\in\mathcal X}g(x)p(x),\quad discrete\end{array}\right.$$

注意这个式子中是函数值乘以对应的概率值，所以最终得到的是映射值得概率均值。对于由有限个一维随机变量组成得数组：

$$\mathbb{E}_{X}[g(\boldsymbol{x})]=\left[\begin{array}{c}\mathbb{E}_{X_{1}}\left[g\left(x_{1}\right)\right] \\ \vdots \\ \mathbb{E}_{X_{D}}\left[g\left(x_{D}\right)\right]\end{array}\right] \in \mathbb{R}^{D}$$

数学期望满足线性算子的性质：

\begin{aligned}
$$\mathbb{E}_{X}[f(\boldsymbol{x})] &=\int f(\boldsymbol{x}) p(\boldsymbol{x}) \mathrm{d} \boldsymbol{x} \\$$
$$&=\int[a g(\boldsymbol{x})+b h(\boldsymbol{x})] p(\boldsymbol{x}) \mathrm{d} \boldsymbol{x} \\$$
$$&=a \int g(\boldsymbol{x}) p(\boldsymbol{x}) \mathrm{d} x+b \int h(\boldsymbol{x}) p(\boldsymbol{x}) \mathrm{d} \boldsymbol{x} \\$$
$$&=a \mathbb{E}_{X}[g(\boldsymbol{x})]+b \mathbb{E}_{X}[h(\boldsymbol{x})]$$
$$\end{aligned}$$

**均值**（Mean）
均值是描述映射前的数据的情况。
对于一个随机变量,其中
所以：

$$\mathbb E_X[\boldsymbol x]=\begin{bmatrix} \mathbb E_{X_1}[x_1]\\\vdots\\ \mathbb E_{X_D}[x_D]\end{bmatrix}\in R^D$$
$$\mathbb{E}_{X_{d}}\left[x_{d}\right]:=\left\{\begin{array}{ll}$$
$$\int_{\mathcal{X}} x_{d} p\left(x_{d}\right) \mathrm{d} x_{d} & \text { if } X \text { is a continuous random variable } \\$$
$$\sum_{x_{i} \in \mathcal{X}} x_{i} p\left(x_{d}=x_{i}\right) & \text { if } X \text { is a discrete random variable }$$
$$\end{array}\right.$$

**中位数**（median）
一组数据中大于一遍数据而小于另一边数据的数字。中位数能够有效地应对异常值。
**众数**（mode）
一组数据中出现次数最多的数字。在连续随机变量中，众数是概率密度最大的数。

> 

上面两种数字对于高维的数据的处理时比较麻烦? 在高维数据中，各个维度的数值大小判断准则不统一。

**协方差**（Covariance）：
协方差描述两个随机变量之间的相互关系（衡量两个随机变量的联合变化程度）。
单变量：

$$X,Y\in \mathbb R\operatorname {Cov}_{X,Y}[x,y]:=\mathbb E_{X,Y}[(x-\mathbb E_X[x])(y-\mathbb E_Y[y])]$$

利用线性性质，可以将上式化简为：

Cov[x,y]=\mathbb E[xy]-\mathbb E[x]\mathbb E[y]

随机变量与自己本身的协方差称为**方差**(variance)，即,表示为,方差的开根之后的值称为**标准偏差**(standard deviation)，表示为
多变量：
<!-- Image removed: CSDN link no longer accessible -->
多变量方差：
<!-- Image removed: CSDN link no longer accessible -->
设随机变量有, 均值向量:

\begin{aligned}
$$\mathbb{V}_{X}[\boldsymbol{x}] &=\operatorname{Cov}_{X}[\boldsymbol{x}, \boldsymbol{x}] \\$$
$$&=\mathbb{E}_{X}\left[(\boldsymbol{x}-\boldsymbol{\mu})(\boldsymbol{x}-\boldsymbol{\mu})^{\top}\right]=\mathbb{E}_{X}\left[\boldsymbol{x} \boldsymbol{x}^{\top}\right]-\mathbb{E}_{X}[\boldsymbol{x}] \mathbb{E}_{X}[\boldsymbol{x}]^{\top} \\$$
$$&=\left[\begin{array}{cccc}$$
$$\operatorname{Cov}\left[x_{1}, x_{1}\right] & \operatorname{Cov}\left[x_{1}, x_{2}\right] & \ldots & \operatorname{Cov}\left[x_{1}, x_{D}\right] \\$$
$$\operatorname{Cov}\left[x_{2}, x_{1}\right] & \operatorname{Cov}\left[x_{2}, x_{2}\right] & \ldots & \operatorname{Cov}\left[x_{2}, x_{D}\right] \\$$
\vdots & \vdots & \ddots & \vdots \\
$$\operatorname{Cov}\left[x_{D}, x_{1}\right] & \ldots & \ldots & \operatorname{Cov}\left[x_{D}, x_{D}\right]$$
$$\end{array}\right]$$
$$\end{aligned}$$

上式中的矩阵称为**协方差矩阵**（covariance matrix），是一个对称半正定的矩阵。它描述了数据的分散情况。对角线元素为**方差**，非对角线元素为**互协方差**（cross-covariance）

**相关性**（Correlation）
相关性描述两个随机变量之间的关系。

$$\operatorname{corr}[x, y]=\frac{\operatorname{Cov}[x, y]}{\sqrt{\mathbb{V}[x] \mathbb{V}[y]}} \in[-1,1] .$$

相关性矩阵就是标准化的随机变量（standardized random variables），即

> 

If the greater values of one variable mainly correspond with the greater values of the other variable, and the same holds for the lesser values (that is, the variables tend to show similar behavior), the covariance is positive.

**正相关与负相关**
<!-- Image removed: CSDN link no longer accessible -->

## [](#%E6%A0%B7%E6%9C%AC%E5%9D%87%E5%80%BC%E5%92%8C%E6%A0%B7%E6%9C%AC%E6%96%B9%E5%B7%AE%EF%BC%88Empirical-Means-and-Covariances%EF%BC%89)样本均值和样本方差（Empirical Means and Covariances）

就是将原先的数据中拿出一部分的数据作为样本，所得出的均值和方差。之前提到的均值是**全平均值**（population mean），方差也一样。
<!-- Image removed: CSDN link no longer accessible -->

## [](#%E6%96%B9%E5%B7%AE%E7%9A%84%E4%B8%89%E7%A7%8D%E8%A1%A8%E8%BE%BE%E5%BC%8F%EF%BC%88Three-Expressions-for-the-Variance%EF%BC%89)方差的三种表达式（Three Expressions for the Variance）

方差的定义式，但是因为需要求均值，又要将样本数逐一进行运算，所以需要将数据遍历两遍。

$$\mathbb{V}_{X}[x]:=\mathbb{E}_{X}\left[(x-\mu)^{2}\right]$$

对原始式进行整理得到下式，这个式子称为**变量的原始分数形式**（raw-score formula for variance），虽然这样可以避免对数据进行两次的遍历，但是这在数值上是不稳定的（numerically unstable）。（？精度上的损失？）

$$\mathbb{V}_{X}[x]=\mathbb{E}_{X}\left[x^{2}\right]-\left(\mathbb{E}_{X}[x]\right)^{2}$$

方差还可以理解成数据中的所有数字与其他所有的数字之间的差距的均值。

$$\frac{1}{N^{2}} \sum_{i, j=1}^{N}\left(x_{i}-x_{j}\right)^{2}=2\left[\frac{1}{N} \sum_{i=1}^{N} x_{i}^{2}-\left(\frac{1}{N} \sum_{i=1}^{N} x_{i}\right)^{2}\right]>$$

there is an equivalence between the pairwise distances and the distances from the center of the set of points

## [](#%E9%9A%8F%E6%9C%BA%E5%8F%98%E9%87%8F%E7%9A%84%E5%8A%A0%E6%B3%95%E8%BF%90%E7%AE%97%E5%92%8C%E5%8F%98%E6%8D%A2%EF%BC%88Sums-and-Transformations-of-Random-Variables%EF%BC%89)随机变量的加法运算和变换（Sums and Transformations of Random Variables）

<!-- Image removed: CSDN link no longer accessible -->

对于一个仿射变换有：
<!-- Image removed: CSDN link no longer accessible -->
<!-- Image removed: CSDN link no longer accessible -->

## [](#%E7%BB%9F%E8%AE%A1%E7%8B%AC%E7%AB%8B%E6%80%A7-Statistical-Independence)统计独立性(Statistical Independence)

<!-- Image removed: CSDN link no longer accessible -->
当两个随机变量相互独立的时候，有以下性质。注意最后一个，当两个随机变量相互独立的时候，相关性等于0，但是相关性等于0的时候，不能说明两个随机变量相互独立，因为独立性是描述随机变量之间的线性独立，假设随机变量之间的关系不是线性的，那么相关性为0时，不能说这两个随机变量是相互独立的。

两随机变量相互独立时的一些性质：

$$\begin{aligned}&p(\boldsymbol{y} \mid \boldsymbol{x})=p(\boldsymbol{y})\\&p(\boldsymbol{x} \mid \boldsymbol{y})=p(\boldsymbol{x}) \\ &\mathbb{V}_{X, Y}[\boldsymbol{x}+\boldsymbol{y}]=\mathbb{V}_{X}[\boldsymbol{x}]+\mathbb{V}_{Y}[\boldsymbol{y}]\\ &\operatorname{Cov}_{X, Y}[\boldsymbol{x}, \boldsymbol{y}]=\mathbf{0}\end{aligned}$$

**独立均匀分布**（independent and identically distributed (i.i.d.)）
变量之间相互独立，而且来自于同一个分布中。
**条件独立**（conditional independence）
<!-- Image removed: CSDN link no longer accessible -->
表示为

p(x,y)=p(y|x)p(x)\\ p(x,y|z)=p(x|z)p(y|z),\quad z\in \mathcal Z

利用第一个式子将第二个式子的左边展开，得到：

$$p(\boldsymbol x, \boldsymbol y|z)=p(\boldsymbol x|\boldsymbol y,z)p(\boldsymbol y|z)$$

与原始比较可以得到：

p(x|y,z)=p(x|z)

这样可以得到条件独立的另一个定义，也就是我们知道y这个结论，对最终的结果没有影响。原式可以理解为在z的条件下，两个随机变量相互独立。统计独立可以看成条件独立的一个特例：

## [](#%E9%9A%8F%E6%9C%BA%E5%8F%98%E9%87%8F%E7%9A%84%E5%86%85%E7%A7%AF%EF%BC%88Inner-Products-of-Random-Variables%EF%BC%89)随机变量的内积（Inner Products of Random Variables）

两个相互独立的随机变量,有以下性质：()

\mathbb V(x+y)=\mathbb V(x)+\mathbb V(y)

由于方差是立方项，所以上式可以联想到勾股定理（the Pythagorean theorem）。
（每一个随机变量都可以看成一个向量空间中的向量）假设对于随机变量之间的内积的定义如下：

$$:=\operatorname{Cov}[x,y]$$

根据这个定义可以得到随机变量的长度：

$$\| X\| = \sqrt{\operatorname{Cov}[x,x]}=\sqrt{\mathbb V[x]}=\sigma[x]$$

这里可以看到，随机变量“越长”，所对应的数据就越分散。
还可以根据两向量的角度的定义得到：

$$\cos \theta=\frac{\langle X, Y\rangle}{\|X\|\|Y\|}=\frac{\operatorname{Cov}[x, y]}{\sqrt{\mathbb{V}[x] \mathbb{V}[y]}}$$

可以看到两个随机变量的“夹角”的余弦值就是相关性（）
所以，当两个随机变量相会垂直的时候，也就是时，这时候二者的夹角为90°，对应的余弦值为0，也就是说这两个随机变量时不相关的。

> 

之后提到用用欧几里得距离去比较两个随机变量的分布并不是最好的方式，这里提到了一个领域**信息几何**（information geometry）一个新名词**廖**（manifold），这部分没有弄得很清楚，留到后续再进行深入学习

# [](#%E9%AB%98%E6%96%AF%E5%88%86%E5%B8%83%EF%BC%88Gaussian-Distribution%EF%BC%89)高斯分布（Gaussian Distribution）

一维随机变量的高斯分布：

$$p\left(x \mid \mu, \sigma^{2}\right)=\frac{1}{\sqrt{2 \pi \sigma^{2}}} \exp \left(-\frac{(x-\mu)^{2}}{2 \sigma^{2}}\right)$$

其中，代表均值，代表随机变量得方差。
对于多元正态分布：（multivariate Gaussian distribution）（为均值向量，为协方差矩阵）

$$p(\boldsymbol{x} \mid \boldsymbol{\mu}, \boldsymbol{\Sigma})=(2 \pi)^{-\frac{D}{2}}|\boldsymbol{\Sigma}|^{-\frac{1}{2}} \exp \left(-\frac{1}{2}(\boldsymbol{x}-\boldsymbol{\mu})^{\top} \boldsymbol{\Sigma}^{-1}(\boldsymbol{x}-\boldsymbol{\mu})\right)$$

其中，
在图像中表示为：
<!-- Image removed: CSDN link no longer accessible -->
当时，将这种分布称为**标准正态分布**（standard normal distribution.）

## [](#%E9%AB%98%E6%96%AF%E5%88%86%E5%B8%83%E7%9A%84%E8%BE%B9%E9%99%85%E5%88%86%E5%B8%83%E5%92%8C%E6%9D%A1%E4%BB%B6%E5%88%86%E5%B8%83%E4%BB%8D%E6%97%A7%E6%98%AF%E9%AB%98%E6%96%AF%E5%88%86%E5%B8%83%EF%BC%88Marginals-and-Conditionals-of-Gaussians-are-Gaussians%EF%BC%89)高斯分布的边际分布和条件分布仍旧是高斯分布（Marginals and Conditionals of Gaussians are Gaussians）

假设、是多维随机变量，则有：

$$p(\boldsymbol{x}, \boldsymbol{y})=\mathcal{N}\left(\left[\begin{array}{l}\boldsymbol{\mu}_{x} \\ \boldsymbol{\mu}_{y}\end{array}\right],\left[\begin{array}{ll}\boldsymbol{\Sigma}_{x x} & \boldsymbol{\Sigma}_{x y} \\ \boldsymbol{\Sigma}_{y x} & \boldsymbol{\Sigma}_{y y}\end{array}\right]\right)$$

<!-- Image removed: CSDN link no longer accessible -->

、的条件分布也是高斯分布：

\begin{aligned}
$$p(\boldsymbol{x} \mid \boldsymbol{y}) &=\mathcal{N}\left(\boldsymbol{\mu}_{x \mid y}, \boldsymbol{\Sigma}_{x \mid y}\right) \\$$
$$\boldsymbol{\mu}_{x \mid y} &=\boldsymbol{\mu}_{x}+\boldsymbol{\Sigma}_{x y} \boldsymbol{\Sigma}_{y y}^{-1}\left(\boldsymbol{y}-\boldsymbol{\mu}_{y}\right) \\$$
$$\boldsymbol{\Sigma}_{x \mid y} &=\Sigma_{x x}-\boldsymbol{\Sigma}_{x y} \boldsymbol{\Sigma}_{y y}^{-1} \Sigma_{y x}$$
$$\end{aligned}$$

<!-- Image removed: CSDN link no longer accessible -->
这是是的条件分布。

边际分布：

$$p(\boldsymbol{x})=\int p(\boldsymbol{x}, \boldsymbol{y}) \mathrm{d} \boldsymbol{y}=\mathcal{N}\left(\boldsymbol{x} \mid \boldsymbol{\mu}_{x}, \boldsymbol{\Sigma}_{x x}\right)$$

<!-- Image removed: CSDN link no longer accessible -->

## [](#%E9%AB%98%E6%96%AF%E5%AF%86%E5%BA%A6%E5%87%BD%E6%95%B0%E7%9A%84%E4%B9%98%E7%A7%AF%EF%BC%88Product-of-Gaussian-Densities%EF%BC%89)高斯密度函数的乘积（Product of Gaussian Densities）

对于两个高斯函数二者的乘积为：,其中：

\begin{aligned}
$$C &=\left(A^{-1}+B^{-1}\right)^{-1} \\$$
$$c &=C\left(A^{-1} a+B^{-1} b\right) \\$$
$$c &=(2 \pi)^{-\frac{D}{2}}|A+B|^{-\frac{1}{2}} \exp \left(-\frac{1}{2}(a-b)^{\top}(A+B)^{-1}(a-b)\right)$$
$$\end{aligned}$$

比例常数c也可以写成：

$$c=\mathcal N(a|b,A+B)=\mathcal N(b|a,A+B)## [](#%E5%92%8C%E8%BF%90%E7%AE%97%E5%92%8C%E7%BA%BF%E6%80%A7%E5%8F%98%E6%8D%A2%EF%BC%88Sums-and-Linear-Transformations%EF%BC%89)和运算和线性变换（Sums and Linear Transformations）$$

当两个相互独立的且满足高斯分布的随机变量相加所得到的随机变量也满足高斯分布：

$$p(x+y)=\mathcal N(\mu_x+\mu_y,\Sigma_x+\Sigma_y)$$

的均值和协方差可以通过之前提到的和运算的性质得到（）

> 

<!-- Image removed: CSDN link no longer accessible -->

可以利用加权和来定义一个满足高斯分布的随机变量（或者是将一个高斯随机变量分解成两个不同的满足高斯分布的随机变量）;

$$p(x)=\alpha p_1(x)+(1-\alpha)p_2(x), \ 1\gt\alpha\gt0,(\mu_1,\sigma^2_1)\ne (\mu_2,\sigma_2^2)$$

其期望值和方差可以表示为：

$$\mathbb{E}[x]=\alpha \mu_{1}+(1-\alpha) \mu_{2}\mathbb{V}[x]=\left[\alpha \sigma_{1}^{2}+(1-\alpha) \sigma_{2}^{2}\right]+\left(\left[\alpha \mu_{1}^{2}+(1-\alpha) \mu_{2}^{2}\right]-\left[\alpha \mu_{1}+(1-\alpha) \mu_{2}\right]^{2}\right)>$$

原书p202有上面两个公式的推导过程，主要就是利用写出对应的定义式，也就是积分的形式，然后再利用积分的性质进行变换。对于方差公式的推导，可以利用方差与期望值之间的关系式。

**总方差定律**（law of total variance）

\mathbb V_X[x]=\mathbb E_Y[\mathbb V_X[x|y]]+\mathbb V_Y[\mathbb E_X[x|y]]

对一个满足高斯分布的随机变量进行线性变换，即对进行线性变换,可以得到一个均值为0，方差为的高斯变量。而对一个高斯随机变量加上一个常数向量，高斯随机变量的均值会发生变化，但是方差会不发生变化。所以，对一个高斯变量进行线性变换或者是仿射变换都不会改变这个变量的分布。

假设随机变量Y为X经过线性变换之后的随机变量，即,所以有：

$$\mathbb E[y]=\mathbb E[Ax]=A\mathbb E[x]=A\mu\mathbb V[y]=\mathbb V[Ax]=A\mathbb V[x]A^\top=A\Sigma A^\top$$

所以随机变量Y可以写成：

$$p(y) = \mathbb N(y|A\mu, A\Sigma A^\top)$$

假设一个随机变量的均值是另一个随机变量经过线性变换之后得到的。假设变换矩阵高斯随机变量有，其均值为，可以表示为：

$$p(\boldsymbol y)=\mathcal N(y|\boldsymbol A\boldsymbol x,\Sigma)$$

当我们想要求的概率分布时，可以由、的关系得到,但是当A不可逆时，这时候需要用到伪逆，所以有：

$$x = (AA^\top)^{-1}A^\top y$$

所以随机变量的分布为：

$$p(\boldsymbol{x})=\mathcal{N}\left(\boldsymbol{x} \mid\left(\boldsymbol{A}^{\top} \boldsymbol{A}\right)^{-1} \boldsymbol{A}^{\top} \boldsymbol{y},\left(\boldsymbol{A}^{\top} \boldsymbol{A}\right)^{-1} \boldsymbol{A}^{\top} \boldsymbol{\Sigma} \boldsymbol{A}\left(\boldsymbol{A}^{\top} \boldsymbol{A}\right)^{-1}\right)## [](#%E4%BB%8E%E5%A4%9A%E5%85%83%E9%AB%98%E6%96%AF%E5%88%86%E5%B8%83%E4%B8%AD%E5%8F%96%E6%A0%B7%EF%BC%88Sampling-from-Multivariate-Gaussian-Distributions%EF%BC%89)从多元高斯分布中取样（Sampling from Multivariate Gaussian Distributions）$$
> 

取样步骤：
In the case of a multivariate Gaussian, this process consists of three stages:
**first**, we need a source of pseudo-random numbers that provide a uniform sample in the interval [0,1];
**second**, we use a non-linear transformation such as the Box-Muller transform (Devroye, 1986) to obtain a sample from a univariate Gaussian;
and **third**, we collate a vector of these samples to obtain a sample from a multivariate standard normal 

想要从多维高斯分布中取样，可以利用高斯随机变量线性变换的性质：
假设：，所以，
所以。
其中一种选取A矩阵的方法是使用Cholesky decomposition将协方差矩阵进行拆分。（但是需要矩阵是对称且正定的）

## [](#%E5%85%B1%E8%BD%AD%E5%8F%8A%E6%8C%87%E6%95%B0%E6%97%8F%EF%BC%88Conjugacy-and-the-Exponential-Family%EF%BC%89)共轭及指数族（Conjugacy and the Exponential Family）
> 

对概率分布的目标：
<!-- Image removed: CSDN link no longer accessible -->
指数族的优点：
provides the right balance of generality while retaining favorable computation and inference properties

### [](#%E4%BC%AF%E5%8A%AA%E5%88%A9%E5%88%86%E5%B8%83%EF%BC%88Bernoulli-distribution%EF%BC%89)伯努利分布（Bernoulli distribution）

一次伯努利试验的结果的概率：
对于一个二元随机变量有,伯努利分布是由一个连续的参数控制，可以表示为:

$$\begin{aligned} &p(x|\mu)=\mu^x(1-\mu)^{1-x},\quad x\in\{0,1\}\\$$
$$&\mathbb E[x] = \mu,\\ &\mathbb V[x]=\mu(1-\mu)\end{aligned}### [](#%E4%BA%8C%E9%A1%B9%E5%BC%8F%E5%88%86%E5%B8%83%EF%BC%88Binomial-Distribution%EF%BC%89)二项式分布（Binomial Distribution）$$

多个伯努利实验的概率分布称为二项式分布：（简单来说第一个参数就是实验次数，第二个参数就是成功概率）

$$\begin{aligned} p(m \mid N, \mu) &=\left(\begin{array}{l}N \\ m\end{array}\right) \mu^{m}(1-\mu)^{N-m} \\ \mathbb{E}[m] &=N \mu \\ \mathbb{V}[m] &=N \mu(1-\mu) \end{aligned}### [](#%E8%B4%9D%E5%A1%94%E5%88%86%E5%B8%83%EF%BC%88Beta-Distribution%EF%BC%89)贝塔分布（Beta Distribution）$$

:

$$p(\mu|\alpha,\beta) = \frac{\Gamma(\alpha+\beta)}{\Gamma(\alpha)\Gamma(\beta)}\mu^{\alpha-1}(1-\mu)^{\beta-1}\mathbb E[\mu] = \frac{\alpha}{\alpha+\beta},\quad \mathbb V[\mu] = \frac{\alpha \beta}{(\alpha+\beta)^2(\alpha+\beta+1)}$$

其中定义为：

$$\begin{aligned}&\Gamma(t):=\int^\infin_0x^{t-1}\operatorname{exp}(-x)dx,\quad t\gt0 \\ &\Gamma(t+1)=t\Gamma(t)\end{aligned}$$

贝塔函数在不同参数下的图像：
<!-- Image removed: CSDN link no longer accessible -->
贝塔分布在不同参数下的一些特性：
<!-- Image removed: CSDN link no longer accessible -->

## [](#%E5%85%B1%E8%BD%AD%EF%BC%88Conjugacy%EF%BC%89)共轭（Conjugacy）

**先验分布**(Prior distribution)
先验分布就是你在取得实验观测值以前对一个参数概率分布的 主观判断

> 

比如说你在抛硬币之前，你会认为取得正面的结果的 概率为为0.5
当我们假设实验结果的分布满足均匀分布，这时候称为**无信息先验**(noninformative prior) 也就是说（继续上面的例子）你抛的硬币是不均匀的，所以，取得正面的概率为上的均匀分布，也就是说什么可能都有。随着实验的进行，这样的分布会根据实验结果被不断矫正。
<!-- Image removed: CSDN link no longer accessible -->
<!-- Image removed: CSDN link no longer accessible -->
这样的概率分布也不会排除一些极端的结果的出现的概率。

**共轭先验**（Conjugacy Prior）
<!-- Image removed: CSDN link no longer accessible -->
也就是对于一个似然函数的先验分布假设成某种分布，然后利用贝叶斯公式计算出对应的后验分布，有时候得到的结果的形式是一致的。

假设一个二项式分布:

$$p(x|N,\mu)=\begin{pmatrix}N\\ x \end{pmatrix}\mu^x(1-\mu)^{N-x},\quad x=0,1,\dots,N$$

它的参数满足:

$$p(\mu|\alpha,\beta) = \frac{\Gamma(\alpha+\beta)}{\Gamma(\alpha)\Gamma(\beta)}\mu^{\alpha-1}(1-\mu)^{\beta-1}$$

假设在x=h时：

$$\begin{aligned}p(\mu|x=h,N,\alpha,\beta)&\propto p(x|N,\mu)p(\mu|\alpha,\beta)\\ &\propto\mu^h(1-\mu)^{(N-h)}\mu^{\alpha-1}(1-\mu)^{\beta-1}\\ &= \mu^{h+\alpha-1}(1-\mu)^{(N-h)+\beta-1} \\ &\propto \operatorname{Beta}(h+\alpha,N-h+\beta)\end{aligned}$$

所以，可以注意到这里的先验概率分布与后验概率分布的形式是一致的。

> 

**似然函数**（Likelihood Function）:说明我们观测的数据是在参数下得来的。

由于利用贝叶斯公式计算后验概率分布的时候，需要用到边际分布概率，如果随机变量是连续的，那么就会需要使用积分，这会导致很多不必要的计算。有了先验共轭，我们就 不用计算复杂的含有积分的贝叶斯公式 便可得到后验分布。
以下是常见的似然函数的先验共轭：
<!-- Image removed: CSDN link no longer accessible -->

## [](#%E5%85%85%E5%88%86%E7%BB%9F%E8%AE%A1%E9%87%8F%EF%BC%88Sufficient-Statistics%EF%BC%89)充分统计量（Sufficient Statistics）
> 

充分统计量：(一个通俗的比喻解释)
假设你辛辛苦苦收集的500个数据全都写在了一张纸上，这些数据是给你写论文用的，非常重要。突然有一天你的狗把你这张写满数据的纸吃掉了，这个时候假如你的数据满足正态分布，且你已经提前把这些数据的均值和方差记录在另外一张纸上了，那你的狗也没坏了什么大事——因为这两个充分统计量包含了这500个数据的所有有用信息。
**sufficient statistics**: the idea that there are statistics that will **contain all available information that can be inferred from data** corresponding to the distribution under consideration. In other words, **sufficient statistics carry all the information needed to make inference about the population**, that is, they are the statistics that are sufficient to represent the distribution.(像是原先的数据中的一个子集，而这个子集可以代表所有的数据，也就是去除了一些冗余的数据)

如果向量包含的所有的信息，那么将称为**充分统计量**

接下来是充分统计的严格定义：
<!-- Image removed: CSDN link no longer accessible -->
也就是说一个概率密度函数可以被分解为独立于参数的部分和虽然依赖于但仅仅是依附于的（？）

> 

The more interesting case is that p(x | θ) is dependent only on φ(x) and not x itself. In this case, φ(x) is a sufficient statistic for θ.

Explain this
<!-- Image removed: CSDN link no longer accessible -->

所以我们可以使用一部分数据去估计样品分布的参数。

## [](#%E6%8C%87%E6%95%B0%E6%97%8F%EF%BC%88Exponential-Family%EF%BC%89)指数族（Exponential Family）

对分布的三种可能的抽象：
1.已知分布类型和对应的参数
2.已知类型，需要根据数据确定此分布类型的参数值。
3.考虑这种分布的族。
**指数族**：
<!-- Image removed: CSDN link no longer accessible -->
这里的内积可以是任何类型的内积。但在本节当中只考虑点积。其中的被称为**对数分割函数**（log-partition function）是一个归一化常数，能保证分布汇总成或者积分成1.
为了更好地理解指数族，我们可以将原先的定义式写成：

p(\boldsymbol x|\boldsymbol\theta)\propto\operatorname{exp}(\boldsymbol\theta^\top\phi(\boldsymbol x))

这里的参数被称为**特征参数**或**自然参数**（natural parameters）

> 

之后给出了几个例子，但是我还是没有形成深刻的理解（待补充）

指数族能够很方便地找出分布的共轭对（conjugate pairs）
对于一个随机变量属于指数族，所以有：

$$p(\boldsymbol{x} \mid \boldsymbol{\theta})=h(\boldsymbol{x}) \exp (\langle\boldsymbol{\theta}, \boldsymbol{\phi}(\boldsymbol{x})\rangle-A(\boldsymbol{\theta}))$$

对于所有的指数族成员都能找到一个先验共轭

$$p(\boldsymbol{\theta} \mid \gamma)=h_{c}(\boldsymbol{\theta}) \exp \left(\left\langle\left[\begin{array}{l}\gamma_{1} \\ \gamma_{2}\end{array}\right],\left[\begin{array}{c}\boldsymbol{\theta} \\ -A(\boldsymbol{\theta})\end{array}\right]\right\rangle-A_{c}(\boldsymbol{\gamma})\right)$$

其中,,其维度为。充分统计量的共轭先验为
这是指数族成员的共轭先验的一般形式，可以通过这个一般形式得到指数族成员的共轭先验。

# [](#%E5%8F%98%E9%87%8F%E5%8F%98%E6%8D%A2%E5%92%8C%E9%80%86%E5%8F%98%E6%8D%A2%EF%BC%88Change-of-Variables-Inverse-Transform%EF%BC%89)变量变换和逆变换（Change of Variables/Inverse Transform）

在本节当中，我们主要讨论当一个随机变量发生变换之后的分布情况。书中主要介绍了两种方法，一种是直接使用定义，另一种是使用**换元法/变数法**（change-of-variable approach）

> 

、表示随机变量，、表示随机变量在目标空间中的取值。

<!-- Image removed: CSDN link no longer accessible -->
假设两个随机变量、满足关系,根据定义可以得到的概率分布：

$$P(Y=y) = P(U(X)=y)=P(X=U^{-1}(y))## [](#%E5%88%86%E5%B8%83%E5%87%BD%E6%95%B0%E6%B3%95%EF%BC%88Distribution-Function-Technique%EF%BC%89)分布函数法（Distribution Function Technique）$$

这里是使用累积分布函数，因为累积分布函数的对变量的偏导就是概率密度函数，所以在运算的过程中可以直接将两个随机变量之间的关系带入即可。
<!-- Image removed: CSDN link no longer accessible -->
假设两个随机变量的分布情况已知:

$$F_Y(y) = P(Y\le y)=P(U(X)\le y)=P(X\le U^{-1}(y))=F_X(U^{-1}(y))f(y)=\frac{d}{dy}F_Y(y)$$

**概率积分变换**（probability integral transform）
<!-- Image removed: CSDN link no longer accessible -->

> 

需要补充

通过这个变换，我们可以先从均匀分布中抽样，然后对抽样样品做对应的变换之后得到目标分布中的抽样结果。同样也可以用于假设性检验，检查样品是否来源于某一种分布当中。

## [](#%E6%8D%A2%E5%85%83%EF%BC%88Change-of-Variables%EF%BC%89)换元（Change of Variables）
$$\int f(g(x))g'(x)dx=\int f(u)du, \quad u=g(x)$$

假设一个随机变量和可逆函数,可以得到：,由概率密度函数的定义：

F_Y(y)=P(Y\le y)=P(U(X)\le y)

因为一个可逆函数在一个区间内严格单调，且如果原函数单调递增则反函数也会是单调递增的，所以：

$$P(U(X)\le y)=P(U^{-1}(U(X))\le U^{-1}(y))=P(X\le U^{-1}(y))=\int^{U^{-1}(y)}_af(x)dx$$

所以可以得到随机变量Y的累积概率函数：

$$F_Y(y)=\int^{U^{-1}(y)}_af(x)dx$$

因为概率密度函数可以通过累积概率函数求导得到，即：

$$f(y) = \frac{d}{dy}F_y(y)=\frac{d}{dy}\int^{U^{-1}(y)}_af(x)dx$$

又因为：

$$\int f\left(U^{-1}(y)\right) U^{-1^{\prime}}(y) \mathrm{d} y=\int f(x) \mathrm{d} x \quad where \quad x=U^{-1}(y)$$

将上面二式联立：

$$f(y)=\frac{\mathrm{d}}{\mathrm{d} y} \int_{a}^{U^{-1}(y)} f_{x}\left(U^{-1}(y)\right) U^{-1^{\prime}}(y) \mathrm{d} y$$

注意到不是y的函数，所以可以将上式的积分为：

$$f(y)=f_{x}\left(U^{-1}(y)\right) \cdot\left(\frac{\mathrm{d}}{\mathrm{d} y} U^{-1}(y)\right)$$

为了让U为增函数和减函数的时候保持形式一致，可以将上式写成下面的形式：

$$f(y)=f_{x}\left(U^{-1}(y)\right) \cdot\left|\frac{\mathrm{d}}{\mathrm{d} y} U^{-1}(y)\right|$$

上面这种方法称为**换元法**（change-of-variable technique）
其中，描述了经过变换U之后的体积变化。

对于多元随机变量的也是类似的，但是由于绝对值不能用于多元方程，但是我们可以使用雅可比行列式代替原先的绝对值。由于雅可比矩阵是一个偏导矩阵，且其行列式的值不为0，所以雅可比矩阵的逆是存在的。
<!-- Image removed: CSDN link no longer accessible -->