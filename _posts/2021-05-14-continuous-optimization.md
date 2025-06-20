---
layout: post
title: "机器学习中的数学：（六）连续优化(Continuous Optimization)"
date: 2021-05-14 02:40:52 +0000
categories: [blog]
tags: []
---


<!-- Image removed: CSDN link no longer accessible -->
在本节中，主要讨论连续优化的两个主要分支：**约束优化**（constrained optimization）、**无约束优化**（unconstrained optimization）。在求解一个线性方程的最优问题的时候，可以对方程进行求导，让后让求导得到的式子赋值为0，接触的结果就是**驻点**（Stationary points），想要知道这个驻点是极大值还是极小值，需要看在该点的二阶导数的的值的情况。由于五次方及以上的高次方程没有代数解（Abel–Ruffini theorem），所以在一些情况下无法求解出求导式子的解析解，这时候我们可以设置一个初始点，为了求解极小值，只需要让点顺着梯度的反方向运动即可，但是这有可能无法得到全局最优解，而是得到一个局部最优解。
<!-- Image removed: CSDN link no longer accessible -->

# [](#%E6%A2%AF%E5%BA%A6%E4%B8%8B%E9%99%8D%E6%B3%95%EF%BC%88Optimization-Using-Gradient-Descent%EF%BC%89)梯度下降法（Optimization Using Gradient Descent）

梯度下降法是一种一阶优化算法，算法会不断更新参数的值，每一步的变化方向都是梯度的反方向（梯度方向的变化率最大。）
梯度下降的目标是：

\min_xf(x)

其中，：被称为**目标函数**（objective function）。在等高线图中，的变化方向与等高线相互垂直。

下面考虑多元方程的优化问题。
下降最快的方向就是梯度的反方向,所以：

$$\boldsymbol{x}_{1}=\boldsymbol{x}_{0}-\gamma\left((\nabla f)\left(\boldsymbol{x}_{0}\right)\right)^{\top}$$

如果步长（step-size）,则
<!-- Image removed: CSDN link no longer accessible -->

## [](#%E6%AD%A5%E9%95%BF-%E5%AD%A6%E4%B9%A0%E7%8E%87%EF%BC%88Step-size%EF%BC%89)步长/学习率（Step-size）

梯度实际上只给出了变化的方向，但是变化的大小是由学习率和当前梯度的绝对值决定的。梯度的绝对值由函数决定，学习率就成为了能够人为控制的变量。假如学习率过小，则取得最优解的耗时会很长，反之可能会在最优解两端左右震荡，也会可能会花费很多的时间求得最优解，在极端情况下还可能会发散。
有一种称为**自适应梯度法**（Adaptive gradient methods）能够在每次迭代的时候更新学习率，以保证代价函数能够“平滑”地移动到最优解点。下面是几个经验性的结论：

2
3

<!-- Image removed: CSDN link no longer accessible -->
我们可以使用梯度下降法求解线性方程：
求解一个线性方程就是求解,近似地等价于求解当平方误差最小时，x的取值：（这里使用欧几里得范数）

$$\min_x \|Ax-b\|^2=(Ax-b)^\top(Ax-b）$$

对上式对x进行求导：

$$\nabla_x=2(Ax-b)^\top A$$

这时可以使用梯度下降法求解出x的值。
在求解线性方程的时候，梯度下降法的收敛速度由**条件数**（condition number）决定，即,条件数在本质上就是最大弯曲方向与最小弯曲方向的比率（在等高线图上）
**预处理子**（preconditioner）
在求解之前，先进行，使得有一个更好的条件数，其中称为**预处理子**。实际上就是对数量级进行匹配，使得等高线图上的图像更加均匀，这样能够加快收敛的速度。

## [](#%E5%B8%A6%E5%8A%A8%E9%87%8F%E9%A1%B9%E7%9A%84%E6%A2%AF%E5%BA%A6%E4%B8%8B%E9%99%8D%EF%BC%88Gradient-Descent-With-Momentum%EF%BC%89)带动量项的梯度下降（Gradient Descent With Momentum）

当函数数量级不是很匹配的时候（表现在等高线图上就是一个狭长的圆），这时候，在执行梯度下降算法的时候，可能会出现在最优解两端不断震荡的现象，为了改善这种情况，可以给梯度下降赋予一些记忆，这个记忆就是动量项，记录先前一次迭代发生的变化。

\begin{aligned}
$$\boldsymbol{x}_{i+1} &=\boldsymbol{x}_{i}-\gamma_{i}\left((\nabla f)\left(\boldsymbol{x}_{i}\right)\right)^{\top}+\alpha \Delta \boldsymbol{x}_{i} \\$$
$$\Delta \boldsymbol{x}_{i} &=\boldsymbol{x}_{i}-\boldsymbol{x}_{i-1}=\alpha \Delta \boldsymbol{x}_{i-1}-\gamma_{i-1}\left((\nabla f)\left(\boldsymbol{x}_{i-1}\right)\right)^{\top}$$
,\alpha\in[0,1]\end{aligned}> 

the momentum term is useful since it averages out different noisy estimates of the gradient

## [](#%E9%9A%8F%E6%9C%BA%E6%A2%AF%E5%BA%A6%E4%B8%8B%E9%99%8D%E6%B3%95%EF%BC%88Stochastic-Gradient-Descent%EF%BC%89)随机梯度下降法（Stochastic Gradient Descent）

由于在计算梯度的时候需要消耗很多的时间，所以可以考虑求解一个近似解即可并非需要求出精确解。
在运行梯度下降的时候，我们需要求解出所有代价函数最小时，所对应的参数的值：

$$L(\boldsymbol\theta)=\sum^N_{n=1}L_n(\boldsymbol \theta)$$

我们还可以使用负对数似然的形式表示代价函数：

$$L(\boldsymbol \theta)=-\sum_{n=1}^N\log p(y_n|\boldsymbol x_n,\boldsymbol \theta)$$

其中为训练数据，为训练目标，为回归模型的参数。
我们原先提到的梯度下降是批优化算法，也就是在更新的时候需要用到所有的训练数据。

$$\boldsymbol \theta_{i+1}=\boldsymbol\theta_i-\gamma_i(\nabla L(\boldsymbol\theta_i))^{\top}=\boldsymbol\theta_i-\gamma_i\sum^N_{n=1}(\nabla L_n(\boldsymbol \theta_i))^\top$$

当需要训练大量数据或是对应的方程无法简单地表示出来的时候，利用上式进行梯度下降将会消耗大量的计算资源。
其实，我们并不一定需要使用所有的数据，我们可以使用其中的一部分数据进行训练，这种梯度下降法被称为**小批量梯度下降法**（mini-batch gradient descent）当样品的数量越多，所得到的梯度结果也就越接近真实值，但是也会消耗更多的计算资源。
<!-- Image removed: CSDN link no longer accessible -->
如果我们能够保持每次的数据小批量，那么数据噪音也许会帮助梯度下降算法跳出局部最优解。

> 

在机器学习中有广泛应用，需要进行补充

## [](#%E7%BA%A6%E6%9D%9F%E4%BC%98%E5%8C%96%E5%92%8C%E6%8B%89%E6%A0%BC%E6%9C%97%E6%A0%BC%E6%97%A5%E4%B9%98%E6%95%B0%EF%BC%88Constrained-Optimization-and-Lagrange-Multipliers%EF%BC%89)约束优化和拉格朗格日乘数（Constrained Optimization and Lagrange Multipliers）

<!-- Image removed: CSDN link no longer accessible -->

约束优化问题可以表示为：

$$\min_x f(x),s.t \ g_i(x)\le0 \ \ i = 1,\cdots,m$$

也可以使用**指示函数**（indicator function）指示函数可以表示一个元素是否在设定的集合内，用表示：

$$J(x)=f(x)+\sum^m_{i=1}\boldsymbol 1(g_i(x))$$

其中是**无限阶跃函数**（infinite step function）：

$$\boldsymbol 1(z)=\left\{\begin{aligned} &0\quad if\ z\le0 \\ &\infin \quad otherwise\end{aligned}\right.$$

也就是当取值在约束范围之外时，会有一个无穷大的惩罚。
**拉格朗日算子**

\begin{aligned}
$$\mathfrak{L}(\boldsymbol{x}, \boldsymbol{\lambda}) &=f(\boldsymbol{x})+\sum_{i=1}^{m} \lambda_{i} g_{i}(\boldsymbol{x})$$
$$&=f(\boldsymbol{x})+\boldsymbol{\lambda}^{\top} \boldsymbol{g}(\boldsymbol{x})$$
$$\end{aligned}$$

其中为**拉格朗日乘子**（Lagrange multiplier）

**拉格朗日对偶**（Lagrangian duality）
在优化问题中，对偶是将一个变量（原始变量，primal variables）装换成另一种变量（对偶变量，dual variables）x<!-- Image removed: CSDN link no longer accessible -->

> 

对偶问题是看待一个优化问题的两个角度。对偶问题的解是原始问题的一个下界。

原始问题（primal problem）：

$$\min_x f(x), s.t. \quad g_i(x)\le 0\quad i = 1\cdots,m$$

对应的对偶问题（Lagrangian Dual Problem）:（将原始的问题转化成拉格朗日算子表示的式子）

\max_{\lambda\in\mathbb R^m}\mathfrak D(\lambda),\quad s.t.\ \lambda\ge 0

这里为对偶变量（dual variable），

> 

这里需要补充几点知识：
 1.**极大极小不等式**（minimax inequality）
对于任意一个有两个参数的函数有：

$$\max _{\boldsymbol{y}} \min _{\boldsymbol{x}} \varphi(\boldsymbol{x}, \boldsymbol{y}) \leqslant \min _{\boldsymbol{x}} \max _{\boldsymbol{y}} \varphi(\boldsymbol{x}, \boldsymbol{y})$$

2.**弱对偶**（weak duality）
原始变量对偶变量（duality gap）

下面的内容需要想想为什么？（为什么是下界，二者的关系是什么？）

当时，是代价函数的下界。所以：

$$J(x)=\max_{\lambda\ge0}\mathfrak L(x,\lambda)$$

同时我们原先先要解决的问题是找到J(x)最小时的参数的值所以：

$$\min_{x\in\mathbb R^d}\max_{\lambda\ge0}\mathfrak L(x,\lambda)$$

再利用之前的极大极小不等式:

$$\min _{x \in \mathbb{R}^{d}} \max _{\boldsymbol{\lambda} \geqslant 0} \mathfrak{L}(\boldsymbol{x}, \boldsymbol{\lambda}) \geqslant \max _{\boldsymbol{\lambda} \geqslant 0} \min _{\boldsymbol{x} \in \mathbb{R}^{d}} \mathfrak{L}(\boldsymbol{x}, \boldsymbol{\lambda}) .$$

这也是弱对偶。这时候将问题转化成了,一个无约束的问题。

> 

**等式约束**（Equality Constraints）：

$$\begin{array}{rl}$$
$$\min _{\boldsymbol{x}} & f(\boldsymbol{x}) \\$$
$$\text { subject to } & g_{i}(\boldsymbol{x}) \leqslant 0 \quad \text { for all } \quad i=1, \ldots, m \\$$
$$& h_{j}(\boldsymbol{x})=0 \quad \text { for all } \quad j=1, \ldots, n .$$
$$\end{array}$$

其中的等式可以用两个不等式表示，然后就可以继续使用拉格朗日乘子了。（有一些需要补充）

# [](#%E5%87%B8%E4%BC%98%E5%8C%96%EF%BC%88Convex-Optimization%EF%BC%89)凸优化（Convex Optimization）
> 

注意一点：国内外对凹凸函数的定义有时相反

当一个优化问题的目标函数为凸函数，约束条件为凸集时，称这种问题为**凸优化问题**
**强对偶**（strong duality）：原始问题和对偶问题的最优化结果是一致的。
**凸集**:
对于一个凸集（convex set）,如果任意的和任意的标量有：

\theta x+(1-\theta)y\in \mathcal C

其实凸集就是凸函数上方形成的一个区域中的集合，如下图。

<!-- Image removed: CSDN link no longer accessible -->
**凸函数**：
对于一个函数的定义域是一个凸集，那么如果这个函数是凸函数，则对于定义域内的所有的点、和标量有：（Jensen’s inequality）

f(\theta x+(1-\theta)y)\le\theta f(x)+(1-\theta)f(y)

判断一个函数是否为凸函数，可以使用函数的梯度：

f(y)\ge f(x)+\nabla_xf(x)^\top(y-x)

如果该函数二阶可导，则只要这个函数的海森矩阵是半正定的

## [](#%E7%BA%BF%E6%80%A7%E8%A7%84%E5%88%92%EF%BC%88Linear-Programming%EF%BC%89)线性规划（Linear Programming）

目标函数和约束函数都是线性方程的优化问题

$$\min_{x\in\mathbb R^d}c^\top x,\ s.t.\ Ax\le b$$

其中：、这里包含d个变量和m个线性约束条件。
对应的拉格朗日式为：

$$\mathfrak{L}(\boldsymbol{x}, \boldsymbol{\lambda})=\boldsymbol{c}^{\top} \boldsymbol{x}+\boldsymbol{\lambda}^{\top}(\boldsymbol{A} \boldsymbol{x})$$

将上式对x进行求导,并设为0，得：

$$c+A^\top \lambda=0$$

所以对偶问题为：

$$\max_{\lambda\in\mathbb R^m}-b^\top\lambda,\ \ s.t.\ c+A^\top\lambda=0, \lambda\ge 0## [](#%E4%BA%8C%E6%AC%A1%E8%A7%84%E5%88%92%E9%97%AE%E9%A2%98%EF%BC%88Quadratic-Programming%EF%BC%89)二次规划问题（Quadratic Programming）$$
$$\min _{x\in \mathbb R^d}\frac{1}{2}x^\top Qx+c^\top\ \ s.t.\ Ax\le b$$

其中：,其中是一个正定矩阵，目标函数是凸函数（convex)。这种问题被称为二次规划问题。

利用拉格朗日乘子：

\begin{aligned}
$$\mathfrak{L}(\boldsymbol{x}, \boldsymbol{\lambda}) &=\frac{1}{2} \boldsymbol{x}^{\top} \boldsymbol{Q} \boldsymbol{x}+\boldsymbol{c}^{\top} \boldsymbol{x}+\boldsymbol{\lambda}^{\top}(\boldsymbol{A} \boldsymbol{x}-\boldsymbol{b}) \\$$
$$&=\frac{1}{2} \boldsymbol{x}^{\top} \boldsymbol{Q} \boldsymbol{x}+\left(\boldsymbol{c}+\boldsymbol{A}^{\top} \boldsymbol{\lambda}\right)^{\top} \boldsymbol{x}-\boldsymbol{\lambda}^{\top} \boldsymbol{b}$$
$$\end{aligned}$$

对上式进行整理之后，对x进行求导得：

$$Qx+(c+A^\top\lambda)=0$$

假设矩阵Q是可逆得：

$$x= -Q^{-1}(c+A^\top\lambda)$$

将上面二式联立可以得到拉格朗日对偶：

$$\mathfrak D(\lambda)=-\frac12(c+A^\top\lambda)^\top Q^{-1}(c+A^\top\lambda)-\lambda^\top b$$

对偶优化问题的解可以由下解得：

\max_{\lambda\in\mathbb R^m}-\frac 12(c+A^\top\lambda)^\top Q^{-1}(c+A^\top\lambda)-\lambda^\top b,\ \ s.t. \lambda\ge 0## [](#Legendre-Fenchel%E5%8F%98%E6%8D%A2%E5%92%8C%E5%87%B8%E5%85%B1%E8%BD%AD-Legendre-Fenchel-Transform-and-Convex-Conjugate)Legendre-Fenchel变换和凸共轭(Legendre-Fenchel Transform and Convex Conjugate)

**支撑超平面**（supporting hyperplane）：
我们可以用一个支撑超平面来表示一个凸函数或者凸集，如下图所示：

<!-- Image removed: CSDN link no longer accessible -->
**凸共轭**
这也被称为Legendre-Fenchel变换
<!-- Image removed: CSDN link no longer accessible -->
其中，: supremum 上确界

A **legendre transformation** is a way of transforming a function of some variable into another function of another variable without losing any information.
<!-- Image removed: CSDN link no longer accessible -->

**上下确界**：（子集中最大和最小的元素）
<!-- Image removed: CSDN link no longer accessible -->
<!-- Image removed: CSDN link no longer accessible -->

> 

这部分需要补充

# [](#%E8%A1%A5%E5%85%85%E5%86%85%E5%AE%B9)补充内容
## [](#Legendre-Transform)Legendre Transform

Sometime it’s much more easier to work with  instead of 

$$f(x)\rightarrow f(s),\quad f(s) = \frac{df(x)}{dx}$$

<!-- Image removed: CSDN link no longer accessible -->
Now we want a function which is changing with s, the function$f^*(s)sf^*-b$
And if we use the transformation again, we will regain the original function:

$$\begin{aligned}f^{**}(x) & =x^\top s-f^*(s)\\$$
&=x^\top s-(s^\top x - f(x))\\
& =f(x) 
$$\end{aligned}$$

Why using it we can solve the optimistics problems pretty fast:

$$f^*(0)=0^\top x_{\min}-f(x_{\min})\\f(x_{\min})=-f^*(0)$$