---
layout: post
title: "机器学习中的数学 ch12：支持向量机分类（Classification with Support Vector Machines）"
date: 2021-07-25 00:25:24 +0000
categories: [blog]
tags: []
---

@[toc]
在机器学习中，有一种分类问题，这种分类问题只有两个预测结果，是或否，即：

f:\mathbb R^D\rightarrow \{0,1\}

为了计算方便，我们使用0，1来表示两种分类的结果，这种分类问题被称为**二元分类**（Binary Classification）。本章节就是主要介绍用**支持向量机**（Support Vector Machine，SVM）来解决这种分类问题。
支持向量机给我们提供了一个用几何的方式的视角看待监督式机器学习。在原先的章节中，我们使用概率模型来理解机器学习问题：用极大似然估计和贝叶斯推断对模型进行优化。支持向量机利用的是另一个角度，这种角度需要大量的代数知识，如内积、投影等。另外，由于用支持向量机解的优化问题没有一个解析解，所以我们需要利用之前学到的各种的优化方法，这可以作为之前学到的知识的一种实践。
在支持向量机的视角下的机器学习问题与概率视角下的机器学习问题略有不同，前者的模型是由数据分布的概率视角得出的。后者是设计一个函数，然后再训练的过程中不断优化，这是基于几何理解的。
接下来我们将从两个视角看待SVM：几何视角和损失函数视角。同时，为了提高模型的泛化能力，线性分类子应该允许一些错误的分类。之后我们还利用拉格朗日乘子得到对偶版本的SVM，这让我们可以利用另一个角度看待SVM。我们还介绍SVM的核方法，以及解非线性核SVM的优化问题。

# [](#%E5%88%86%E7%A6%BB%E8%B6%85%E5%B9%B3%E9%9D%A2%EF%BC%88Separating-Hyperplanes%EF%BC%89)分离超平面（Separating Hyperplanes）

对于两点的相似程度，我们可以使用内积来表示。而一个分类问题的本质就是将数据集在一个平面上表示，然后将数据所在的空间划分成两个子空间。为了方便起见，我们考虑一个简单的分类问题：

f:\mathbb R^D\rightarrow \mathbb R, \ x\in \mathbb R^D\\ x\mapsto f(x):=\langle w,x\rangle+b

其中的参数为：.我们原先提到，超平面实际上就是仿射子空间，所以我们假设一个超平面在一个二分类问题中将两类数据分离到两个子空间中：

\{x\in\mathbb R^D:f(x)=0\}

在下图中，我们可以知道w是超平面的法向量，b是超平面的截距。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210720074318957.png?x-oss-process=image,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)
证明：
假设有两个点在超平面上:

f(x_a)-f(x_b)=\langle w,x_a\rangle+b-(\langle w,x_b\rangle + b)=\langle w, x_a-x_b\rangle

由于超平面的方程为,而选取的两个点在超平面上，所以,所以：

\langle w, x_a-x_b\rangle=0

所以，w与超平面相互垂直。
对于一个二分类问题，数据点在超平面的上方为一类，下方为另一类，所以：

y_n=\left\{\begin{aligned}
1,\quad\langle w,x_n\rangle+b\ge0 \\
-1\quad \langle w,x_n\rangle+b 

上式也可以直接整理到一个式子中：.这就是分类问题的分类器。

# [](#%E5%8E%9F%E5%A7%8B%E6%94%AF%E6%8C%81%E5%90%91%E9%87%8F%E6%9C%BA%EF%BC%88Primal-Support-Vector-Machine%EF%BC%89)原始支持向量机（Primal Support Vector Machine）

对于一个线性可分的数据集，有时候能够将两类数据分开的超平面不止一个，我们需要找到其中的较好的一个超平面，其中的一个想法就是最大化两类数据到超平面的距离，这样能够提高模型的泛化能力。（这样想，如果一个分类器离数据点很近，那么只要这个数据点有一点波动，就可能导致数据点的类别变化）

    ![](https://img-blog.csdnimg.cn/20210720104357340.png)

    Figure 12.3  Possible separating hyperplanes. There are many linear
classifiers (green lines) that separate orange crosses from blue discs.

## 间隔的概念（Concept of the Margin）
我们假设有一个样本点

是这一类数据中离超平面最近的点, 这个样本点在超平面上的正交投影为,如下图所示。我们可以发现与之间的距离向量与相互平行，所以这个距离向量可以用表示，其中的r为比例参数，然后根据向量加法：

对于r，我们还可以认为是在上的投影的坐标。

    ![](https://img-blog.csdnimg.cn/20210720103533239.png)

    Figure 12.4 Vector addition to express distance to hyperplane

我们需要尽量最大化这个距离向量，所以我们假设这个距离向量的模不应该小于r(即这个数据点到其投影点的距离不应该小于)，所以有：

由于我们并不关心的大小，只需要求他的方向，所以可以假设。将上面的条件组合成一个约束优化问题：

这也就是说我们想最大化间隔r，同时保证数据在超平面的正确的方向。

    ![](https://img-blog.csdnimg.cn/20210720111704696.png)

    Figure 12.5
Derivation of the
margin: r

> 
when the margin is large, the “complexity” of the function class is low, and hence learning is possible

## [](#%E9%97%B4%E9%9A%94%E7%9A%84%E4%BC%A0%E7%BB%9F%E6%8E%A8%E5%AF%BC%EF%BC%88Traditional-Derivation-of-the-Margin%EF%BC%89)间隔的传统推导（Traditional Derivation of the Margin）

我们之前在推导边缘的时候，因为我们不关心的大小，只关心它的方向，所以我们就假设.在本节中，我们将使用不同的假设推导边缘最大化问题。假设数据集中的一类离超平面最近的点为,距离为1,即， 所以我们可以重新调整超平面，使得这个点在移动后的超平面上，如图12.5. 有因为这个数据点的投影在超平面上，所以：

\langle w,x_a'\rangle +b = 0

之后将带入到上式：

\langle w, x_a-r\frac{w}{\|w\|}\rangle+b=0

再根据内积的双线性的性质：

\langle w,x_a\rangle +b-r\frac{\langle w,w\rangle}{\|w\|}=0

由于我们之前假设,有因为,全部带入上式：

r = \frac{1}{\|w\|}

由于在计算的时候w也是未知的，所以我们并不能通过上式将r推导出来，但是我们可以将这个变量作为中间变量，所以接下来的章节我们将会使用代替.当然这个r 也可以看成数量点向超平面的投影误差。 这样我们可以发现，这个假设与之前的假设是一致的。
于是，我们原先的约束问题可以转换成：

\max_{w,b}\frac{1}{\|w\|}\\
s.t. \quad y_n(\langle w,x_n\rangle+b\ge1) \quad for \ all \quad n=1,\cdots,N

为了计算方便，我们将上式中的求最大值转换成求最小值：

\min_{w,b}\frac12{\|w\|}^2\\
s.t. \quad y_n(\langle w,x_n\rangle+b\ge1) \quad for \ all \quad n=1,\cdots,N

上式就是**硬边界支持向量机**（hard margin SVM）。之所以称为“硬”，是因为这个边界不允许任何数据点违反边界条件。

## [](#%E4%B8%BA%E4%BB%80%E4%B9%88%E5%B0%86%E9%97%B4%E9%9A%94%E8%AE%BE%E4%B8%BA1%EF%BC%88Why-We-Can-Set-the-Margin-to-1%EF%BC%89)为什么将间隔设为1（Why We Can Set the Margin to 1）

我们需要证明：

\begin{aligned}
&\max _{\boldsymbol{w}, b, r} \underbrace{r}_{\text {margin }} \\
&\text { subject to } \quad \underbrace{y_{n}\left(\left\langle\boldsymbol{w}, \boldsymbol{x}_{n}\right\rangle+b\right) \geqslant r}_{\text {data fitting }}, \underbrace{\|\boldsymbol{w}\|=1}_{\text {normalization }}, \quad r>0
\end{aligned}

与

\min _{\boldsymbol{w}, b} \underbrace{\frac{1}{2}\|\boldsymbol{w}\|^{2}}_{\text {margin }}\\{\text { subject to }} \underbrace{y_{n}\left(\left\langle\boldsymbol{w}, \boldsymbol{x}_{n}\right\rangle+b\right) \geqslant 1}_{\text {data fitting }} .

是等价的。后者是利用了假设.以下证明不严格，主要用于描述证明思路。
假设一个超平面的方程为：，将右边归一化之后得：,于是可以令:于是:,由于原命题中有一个假设：,所以可以得到：.带入原命题中，可以得到与要证明的命题一致的形式：

\min _{\boldsymbol{w'}, b} \underbrace{\frac{1}{2}\|\boldsymbol{w'}\|^{2}}_{\text {margin }}\\{\text { subject to }} \underbrace{y_{n}\left(\left\langle\boldsymbol{w'}, \boldsymbol{x}_{n}\right\rangle+b\right) \geqslant 1}_{\text {data fitting }} .

或者是说，两个参数同时变化相当于对超平面的平移，但是无论怎么平移，方程都是指向同一个超平面的。（几何间隔与函数间隔）

## [](#%E8%BD%AF%E9%97%B4%E9%9A%94%E6%94%AF%E6%8C%81%E5%90%91%E9%87%8F%E6%9C%BA%EF%BC%9A%E5%87%A0%E4%BD%95%E8%A7%86%E8%A7%92%EF%BC%88Soft-Margin-SVM-Geometric-View%EF%BC%89)软间隔支持向量机：几何视角（Soft Margin SVM: Geometric View）

由于测量误差等的因素，很难保证数据点都准确。所以我们希望能够允许部分的数据点被错误分类，这种允许一些错误分类的支持向量机称为**软间隔支持向量机**。
在几何视角下，我们需要介绍一个关键变量：**松弛变量**（slack variable）

    ![](https://img-blog.csdnimg.cn/img_convert/f500ab634f2592cb2887e5669816d165.png)

    Figure 12.7 松弛变量描述的是被错误分类的点到对应的间隔超平面的距离，x+是被错误分类的数据点

我们为每一组数据引入一个松弛变量这样允许一组数据在间隔以内，甚至是在超平面的错误的一边。我们将松弛变量加入到硬间隔支持向量机中：

\min_{w,b,\xi}\frac 12\|w\|^2+C\sum^N_{n=1}\xi_n\\
s.t.\quad y_n(\langle w,x_n\rangle +b)\ge1-\xi_n,\quad \xi_n\ge0

其中，被称为**正则化系数**， 被称为**正则项**。这个定义与之前的好像略有不同，可以认为是在原先的正则化式子中同时除以了一个正则化系数.上面这个式子就是**软间隔支持向量机**（Soft Margin SVM）.

> 

注意到式中的b没有正则化，因为未正则化的b使理论分析复杂化并且降低了计算效率。
The unregularized term b complicates theoretical analysis (Steinwart and Christmann, 2008, chapter 1) and decreases computational efficiency (Fan et al., 2008).**（？）**
**公式理解**：是错误分类的数据点距超平面的距离。

## [](#%E8%BD%AF%E9%97%B4%E9%9A%94SVM%EF%BC%9A%E6%8D%9F%E5%A4%B1%E5%87%BD%E6%95%B0%E8%A7%86%E8%A7%92%EF%BC%88Soft-Margin-SVM-Loss-Function-View%EF%BC%89)软间隔SVM：损失函数视角（Soft Margin SVM: Loss Function View）

在SVM中，我们假设类就是超平面：

f(x)=\langle w,x\rangle+b

现在我们要找到对应的损失函数，在之前的章节中的线性规划问题中使用的平方损失函数在分类问题中并不适合，所以我们需要找到其他的损失函数。
有一个候选函数就是**0-1损失函数**（zero-one loss）。当样本被错误分类的时候，函数值为1，否则为0，这个函数标识为。但是使用这个损失函数就需要解决一个组合优化问题，难度很大。
还有一种损失函数为**合页损失函数**（hinge loss）：

\ell = \max\{0,1-t\},\quad where \quad t=yf(x)=y(\langle w,x\rangle+b)

也就是当预测结果在正确的方向且时， 函数值为0.其他情况为非零，也可以将上式写成：

\ell =\left\{\begin{aligned}
&0\quad &if\quad y\ge1 \\
&1-t\quad &if\quad t

对于硬间隔SVM：

\ell=\left\{\begin{aligned}
&0\quad &if\quad t\ge 1\\
&\infin\quad &if \quad t

损失函数在图中的表示为：

    ![](https://img-blog.csdnimg.cn/img_convert/b8279f9e6cb07969b873bed32897a8a7.png)

    Figure 12.8 合页损失函数是0-1损失函数的凸上界

将合页损失函数带到原先的优化问题中：

\min_{w,b}\underbrace {\frac 12\|w\|^2}_{regularizer}+\underbrace{C\sum^N_{n=1}\max\{0,1-y_n(\langle w,x_n\rangle + b)\}}_{error\ term}

由上可以知道，最大间隔实际上就是正则化。上述的无约束优化问题的解可以直接用梯度下降法求解，与之前的约束优化问题的结果是一致的。这是因为：

\min_{t}\max\{0,1-t\}

等价于：

\min_{\xi,t}\quad\xi\\
s.t. \quad \xi\ge0,\xi\ge1-t

将上式带入无约束优化问题中，经过整理可以得到与软间隔SVM一致的形式。

# [](#%E5%AF%B9%E5%81%B6%E6%94%AF%E6%8C%81%E5%90%91%E9%87%8F%E6%9C%BA%EF%BC%88Dual-Support-Vector-Machine%EF%BC%89)对偶支持向量机（Dual Support Vector Machine）

原先我们提到的支持向量机的参数数量是由特征的数量决定的。在这部分，我们介绍对偶支持向量机，他的参数数量是由训练集数据的数量决定，这样能够有效处理特征多，数据少的数据集。另外， 对偶支持向量机能够很好地引入核函数。在这里地对偶主要指**凸对偶**（convex duality）

## [](#%E5%88%A9%E7%94%A8%E6%8B%89%E6%A0%BC%E6%9C%97%E6%97%A5%E4%B9%98%E5%AD%90%E8%A7%A3%E5%86%B3%E5%87%B8%E5%AF%B9%E5%81%B6%EF%BC%88Convex-Duality-via-Lagrange-Multipliers%EF%BC%89)利用拉格朗日乘子解决凸对偶（Convex Duality via Lagrange Multipliers）

将之前的约束优化问题利用拉格朗日乘子转化成非约束优化问题，其中是拉格朗日乘子

\begin{aligned}
\mathfrak{L}(\boldsymbol{w}, b, \xi, \alpha, \gamma)=& \frac{1}{2}\|\boldsymbol{w}\|^{2}+C \sum_{n=1}^{N} \xi_{n} \\
& \underbrace{-\sum_{n=1}^{N} \alpha_{n}\left(y_{n}\left(\left\langle\boldsymbol{w}, \boldsymbol{x}_{n}\right\rangle+b\right)-1+\xi_{n}\right)}_{\text {constraint (12.26b) }} \underbrace{-\sum_{n=1}^{N} \gamma_{n} \xi_{n}}_{\text {constraint }(12.26 \mathrm{c})}
\end{aligned}

将拉格朗日函数对各个参数进行求导：

\begin{aligned}
\frac{\partial \mathfrak{L}}{\partial \boldsymbol{w}} &=\boldsymbol{w}^{\top}-\sum_{n=1}^{N} \alpha_{n} y_{n} \boldsymbol{x}_{n}^{\top}, \\
\frac{\partial \mathfrak{L}}{\partial b} &=-\sum_{n=1}^{N} \alpha_{n} y_{n} \\
\frac{\partial \mathfrak{L}}{\partial \xi_{n}} &=C-\alpha_{n}-\gamma_{n}
\end{aligned}

将第一个式子设为0,得到：

w=\sum^N_{n=1}\alpha_ny_nx_n

于是可以知道原始SVM的权重向量就是数据集的线性组合。这印证了我们原先提到的**表示定理**（representer theorem）：最小经验风险的解就在由数据定义的子空间中。

> 

表示会定理也给支持向量机这个名字提供了另一种解释。当对应的为0的时候，说明这个数据点对解没有贡献，而当它大于0的时候，就被称为**支持向量**，它支撑起了超平面。

将的式子带入到上面的拉格朗日函数中：

\begin{aligned}
\mathfrak{D}(\xi, \alpha, \gamma)=& \frac{1}{2} \sum_{i=1}^{N} \sum_{j=1}^{N} y_{i} y_{j} \alpha_{i} \alpha_{j}\left\langle\boldsymbol{x}_{i}, \boldsymbol{x}_{j}\right\rangle-\sum_{i=1}^{N} y_{i} \alpha_{i}\left\langle\sum_{j=1}^{N} y_{j} \alpha_{j} \boldsymbol{x}_{j}, \boldsymbol{x}_{i}\right\rangle \\
&+C \sum_{i=1}^{N} \xi_{i}-b \sum_{i=1}^{N} y_{i} \alpha_{i}+\sum_{i=1}^{N} \alpha_{i}-\sum_{i=1}^{N} \alpha_{i} \xi_{i}-\sum_{i=1}^{N} \gamma_{i} \xi_{i}
\end{aligned}

再令带入，由于内积是对称函数而且具有双线性，所以上式中的前两项是可以合并的。于是得到：

\mathfrak{D}(\xi, \alpha, \gamma)=-\frac{1}{2} \sum_{i=1}^{N} \sum_{j=1}^{N} y_{i} y_{j} \alpha_{i} \alpha_{j}\left\langle x_{i}, x_{j}\right\rangle+\sum_{i=1}^{N} \alpha_{i}+\sum_{i=1}^{N}\left(C-\alpha_{i}-\gamma_{i}\right) \xi_{i}

又再令,又由于拉格朗日乘子,所以,于是原先的双系数拉格朗日就转换成单系数拉格朗日：

\begin{array}{ll}
\min _{\boldsymbol{\alpha}} & \frac{1}{2} \sum\limits_{i=1}^{N} \sum\limits_{j=1}^{N} y_{i} y_{j} \alpha_{i} \alpha_{j}\left\langle\boldsymbol{x}_{i}, \boldsymbol{x}_{j}\right\rangle-\sum\limits_{i=1}^{N} \alpha_{i} \\
\text { subject to } & \sum\limits_{i=1}^{N} y_{i} \alpha_{i}=0 \\
0 \leqslant \alpha_{i} \leqslant C & \text { for all } i=1, \ldots, N
\end{array}

这就是**对偶支持向量机**（Dual SVM）,它对应的约束被称为“**框型约束**”（box constraints）拉格朗日乘子被限制在一个方形的区域内（）.这种与坐标轴平行的约束，在数值计算的过程中非常高效。
当我们得到之后，可以利用表示定理将最优的求出来。假设这个参数为

> 

在 L2 正则化问题上：
表示定理是指任意一个 L2 正则化的问题，其最佳 w* 都可以用 βn 与 Zn 线性组合得到。

假设数据点在边界上， 所以有，所以参数b的解为：

b^*=y_n-\langle w^*,x_n\rangle

当假设不成立的时候，需要计算所有支持向量的上式右边式子的绝对值，然后找到中位数，这里省略。

## [](#%E5%AF%B9%E5%81%B6%E6%94%AF%E6%8C%81%E5%90%91%E9%87%8F%E6%9C%BA%EF%BC%9A%E5%87%B8%E5%8C%85%E8%A7%86%E8%A7%92%EF%BC%88Dual-SVM-Convex-Hull-View%EF%BC%89)对偶支持向量机：凸包视角（Dual SVM: Convex Hull View）

另一种理解支持向量机的方式需要借助一种几何参数。我们将拥有同样标签的数据点限制在我们构造的凸包中，如下图所示。
![在这里插入图片描述](https://img-blog.csdnimg.cn/34dc2628007e4a438705f2b5c2f5fabf.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)
现在我们对凸包进行一个直观的解释。假设空间中有两个不相等的数据点，现在有两个参数,且，所以表示的就是之间的数，现在加上另一个数据点及参数,这时候,这时候，三个点的线性组合的数据点在一个二维的区域内。这个区域就称为**凸包**（convex hull）。
通常，构建一个凸包，可以利用一个非负的权重,对应数据,于是，凸包可以表示为：

\operatorname{conv}(X)=\left\{\sum^N_{n=1}\alpha_nx_n\right\}, \quad with \ \sum^N_{n=1}\alpha_n=1,\alpha_n\ge0

假设数据是可以分离的，那么这些数据对应的凸包就不会重合，我们找到两类数据中距离另一类最近的数据点,如上图所示，定义两个凸包之间的距离为：

w:=c-d

想要这两个数据点尽可能接近，等价于以下的优化问题：

\arg \min_w\|w\|=\arg \min_w\frac 12\|w\|^2

由于c点在正凸包中，所以c点可以表示为：

c=\sum_{n:y_n=+1}\alpha^+_nx_n

同样的，d点可以表示为：

d=\sum_{n:y_n=-1}a_n^-x_n

其中，标签为-1的坐标索引。将两式带入到优化方程中：

\min_\alpha\frac12\left\|
\sum_{n:y_n=+1}\alpha^+_nx_n-\sum_{n:y_n=+1}\alpha^+_nx_n
\right\|

对于参数:

\sum_{n:y_n=+1}\alpha^+_nx_n=1,\quad \sum_{n:y_n=-1}a_n^-x_n=1

由于：

\begin{aligned}
\sum_{n=1}^{N} y_{n} \alpha_{n} &=\sum_{n: y_{n}=+1}(+1) \alpha_{n}^{+}+\sum_{n: y_{n}=-1}(-1) \alpha_{n}^{-} \\
&=\sum_{n: y_{n}=+1} \alpha_{n}^{+}-\sum_{n: y_{n}=-1} \alpha_{n}^{-}=1-1=0
\end{aligned}

所以,优化问题的约束条件为：

\sum_{n=1}^Ny_n\alpha_n=0

这里得到的约束优化问题与之前的对偶硬间隔支持向量机中的约束优化问题一致。

> 

想要得到软间隔的支持向量机的约束优化问题，我们需要利用**缩小包**（reduce hull），这对参数的规模进行了限制

# [](#%E6%A0%B8%E6%96%B9%E6%B3%95%EF%BC%88Kernels%EF%BC%89)核方法（Kernels）

在对偶SVM中，内积只是在样本之间，而在样本与参数之间没有内积的关系，所以可以使用一个特征将式中的内积代替。这样问题就具有了模块性，使得我们能够将特征表示方法和分类方法分开考虑。
由于有些数据并非是线性可分的，所以需要是非线性函数，但是我们不是去定义一个这样的非线性的函数，然后计算它的内积，而是定义一个相似函数,在这里这个相似函数称为**核函数**（Kernel Function）,核函数的定义为：
对于一个非线性特征映射

k:\mathcal X\times\mathcal X\rightarrow\mathbb R

存在一个**希尔伯特空间**（Hilbert space）有：\phi:\mathcal X\rightarrow \mathcal H.特征映射的定义为：

k(x_i,x_j)=\langle \phi(x_i),\phi(x_j)\rangle_\mathcal H

每一个核函数都对应着唯一一个**再生核希尔伯特空间**（reproducing kernel Hilbert space）。在这种关系中，被称为**规范特征图**（Canonical Feature Map）.这种将一个内积转换成核函数的方法称为**核方法**（Kernel Trick）。这种方法避免了显式的非线性特征映射。
由数据内积或者是将数据带入到核函数得到的矩阵被称为**克莱姆矩阵**（Cram Matrix）,有时候也直接被称为**核矩阵**（Kernel Matrix）,核函数需要时对称且半正定的，这样核矩阵才能是对称和半正定的，对此核矩阵的定义为：

\forall z\in \mathbb R^N:z^\top Kz\ge0

一些比较常用的核函数为：多项式核函数，高斯径向基核函数，有理二次核函数。下图是利用不同的核函数进行分类的结果：
![在这里插入图片描述](https://img-blog.csdnimg.cn/51546caf200e49b59e74ea817a13e844.png?x-oss-process=image,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)
注意函数的假设类仍旧是线性的，图中的非线性边界来源于核函数.

> 

这个“核”有很多定义，在这里的核是来源于再生核希尔伯特空间。我们之前提到过的核空间代表的是零空间。还有一种就是在密度估计中的光滑核函数。

由于特征在数学上与核函数等价，所以我们常常选用一些比内积更好计算的核函数。例如，假设我们使用多项式核函数，当数据较多时，这时候即使是多项式的次数比较低，也会导致大量的特征($x_1,x_2,x_3 \rightarrow x_1*x_2, x_1*x_3\cdots$),但是使用核函数只需要对每一个输入进行一次乘法就可以了。
核方法的另一个优势是不需要将输入的数据表示为多元实数。而对于核函数的选择以及核函数的参数需要通过嵌套交叉验证的方式选择。

# [](#%E6%95%B0%E5%80%BC%E8%A7%A3%EF%BC%88Numerical-Solution%EF%BC%89)数值解（Numerical Solution）

在这部分，我们对原先提到的内容进行回顾。
首先我们是从损失函数的角度对支持向量机进行了解释，我们使用的合页损失函数,但是这个损失函数是一个不可微的函数，于是我们采用次梯度（subgradient）的方法，得到损失函数的梯度：

g(t)=\left\{\begin{aligned}
&-1,\quad&t1 
\end{aligned}\right.

这样我们就可以使用之前学过的一些优化算法进行优化了。
要想将原始支持向量机转换成二次规划的标准形式，我们假设内积为点乘，同时将原先所有的优化变量全部移到等式左边：

\min_{w,b,\xi}\frac 12\|w\|^2+C\sum^N_{n=1}\xi_n\\
s.t.\quad \left\{\begin{aligned}
&-y_nx_n^\top w-y_nb-\xi_n\le-1 \\
&-\xi_n\le0
\end{aligned}\right.

将上式矩阵化（将变量放到向量中）：

\begin{aligned}
&\min _{\boldsymbol{w}, b, \boldsymbol{\xi}} \quad \frac{1}{2}\left[\begin{array}{l}
\boldsymbol{w} \\
b \\
\boldsymbol{\xi}
\end{array}\right]^{\top}\left[\begin{array}{cc}
\boldsymbol{I}_{D} & \mathbf{0}_{D, N+1} \\
\mathbf{0}_{N+1, D} & \mathbf{0}_{N+1, N+1}
\end{array}\right]\left[\begin{array}{c}
\boldsymbol{w} \\
b \\
\boldsymbol{\xi}
\end{array}\right]+\left[\begin{array}{ll}
\mathbf{0}_{D+1,1} & C \mathbf{1}_{N, 1}
\end{array}\right]^{\top}\left[\begin{array}{l}
\boldsymbol{w} \\
b \\
\boldsymbol{\xi}
\end{array}\right] \\
&\text { subject to }\left[\begin{array}{ccc}
-\boldsymbol{Y} \boldsymbol{X} & -\boldsymbol{y} & -\boldsymbol{I}_{N} \\
\mathbf{0}_{N, D+1} & -\boldsymbol{I}_{N}
\end{array}\right]\left[\begin{array}{c}
\boldsymbol{w} \\
b \\
\boldsymbol{\xi}
\end{array}\right] \leqslant\left[\begin{array}{c}
-\mathbf{1}_{N, 1} \\
\mathbf{0}_{N, 1}
\end{array}\right]
\end{aligned}

这其中分别代表零矩阵，全一矩阵，单位矩阵，标签组成的对角矩阵，样本矩阵。
而对于对偶支持向量机，想要将其表示为标准形式，我们首先需要表示核函数矩阵,其中的每一个元素为,如果我们有明确的特征表示则我们可以定义,为了方便，我们将有标签组成的对角矩阵表示为,这时，对偶支持向量机可以写为：

\min_\alpha\frac12\alpha^\top YKY\alpha\boldsymbol 1^\top_{N.1}\alpha\\
s.t.\quad \begin{bmatrix}
y^\top\\
-y^\top\\-I_N\\I_n
\end{bmatrix}\alpha
\le\begin{bmatrix}\boldsymbol 0_{N+2,1}\\C\boldsymbol 1_{N,1}
\end{bmatrix}

为了将式子表示为标准形式，所以将等式写成了两个不等式：

Ax=b\Leftrightarrow AX\le b\quad and\quad AX\ge b

正是由于支持向量机能够清晰描述为优化问题，这使得许多的基于数值优化的技术能够被应用。