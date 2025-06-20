---
layout: post
title: "机器学习中的数学：（四）矢量积分(Vector Calculus)"
date: 2021-04-29 04:23:32 +0000
categories: [blog]
tags: []
---

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210426135218277.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

# [](#%E5%8D%95%E5%8F%98%E9%87%8F%E5%BE%AE%E5%88%86%EF%BC%88Differentiation-of-Univariate-Functions%EF%BC%89)单变量微分（Differentiation of Univariate Functions）

**定义：差商形式**
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210426135329872.png?x-oss-process=image,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210426135407699.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)
**正式定义**：
割线在极限情况下变成切线
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210426135447455.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

> 

多项式导数的推导：

\begin{aligned}
\frac{\mathrm{d} f}{\mathrm{~d} x} &=\lim _{h \rightarrow 0} \frac{f(x+h)-f(x)}{h}\\
&=\lim _{h \rightarrow 0} \frac{(x+h)^{n}-x^{n}}{h} \\
&=\lim _{h \rightarrow 0} \frac{\sum_{i=0}^{n}\left(\begin{array}{l}
n \\
i
\end{array}\right) x^{n-i} h^{i}-x^{n}}{h} .
\end{aligned}

由于所以：

\begin{aligned}
\frac{\mathrm{d} f}{\mathrm{~d} x} &=\lim _{h \rightarrow 0} \frac{\sum_{i=1}^{n}\left(\begin{array}{l}
n \\
i
\end{array}\right) x^{n-i} h^{i}}{h} \\
&=\lim _{h \rightarrow 0} \sum_{i=1}^{n}\left(\begin{array}{c}
n \\
i
\end{array}\right) x^{n-i} h^{i-1} \\
&=\lim _{h \rightarrow 0}\left(\begin{array}{l}
n \\
1
\end{array}\right) x^{n-1}+\underbrace{\sum_{i=2}^{n}\left(\begin{array}{l}
n \\
i
\end{array}\right) x^{n-i} h^{i-1}}_{\rightarrow 0 \text { as } h \rightarrow 0} \\
&=\frac{n !}{1 !(n-1) !} x^{n-1}=n x^{n-1} .
\end{aligned}

其中的是组合数

## [](#%E6%B3%B0%E5%8B%92%E7%BA%A7%E6%95%B0)泰勒级数

**泰勒多项式**：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210426142816300.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

对于在的泰勒级数为:(表示无穷多项都是是连续可微的，？)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210427101504784.png)
当时.称为**麦克劳林级数(Maclaurin series)**
泰勒多项式表示对函数的一种近似,多项式的项越多,与原先的函数就越接近.下图中，表示的项展开。
![在这里插入图片描述](https://img-blog.csdnimg.cn/2021042710221633.png?x-oss-process=image,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

> 

三角函数的泰勒展开：

\begin{aligned}
\cos (x) &=\sum_{k=0}^{\infty}(-1)^{k} \frac{1}{(2 k) !} x^{2 k}, \\
\sin (x) &=\sum_{k=0}^{\infty}(-1)^{k} \frac{1}{(2 k+1) !} x^{2 k+1} .
\end{aligned}

泰勒级数实际上是一种特殊的幂级数：

f(x)=\sum^\infty_{k=0}a_k(x-c)^k,\quad 幂级数

一些求导法则：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210427102600815.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

# [](#%E5%81%8F%E5%AF%BC%E6%95%B0%E5%92%8C%E6%A2%AF%E5%BA%A6%EF%BC%88Partial-Differentiation-and-Gradients%EF%BC%89)偏导数和梯度（Partial Differentiation and Gradients）

偏导数定义：

\begin{aligned}
\frac{\partial f}{\partial x_{1}} &=\lim _{h \rightarrow 0} \frac{f\left(x_{1}+h, x_{2}, \ldots, x_{n}\right)-f(x)}{h} \\
& \vdots \\
\frac{\partial f}{\partial x_{n}} &=\lim _{h \rightarrow 0} \frac{f\left(x_{1}, \ldots, x_{n-1}, x_{n}+h\right)-f(\boldsymbol{x})}{h}
\end{aligned}

可以将函数对所有变量的偏导数写成一个行向量：

\nabla_{\boldsymbol{x}} f=\operatorname{grad} f=\frac{\mathrm{d} f}{\mathrm{~d} \boldsymbol{x}}=\left[\begin{array}{llll}
\frac{\partial f(\boldsymbol{x})}{\partial x_{1}} & \frac{\partial f(\boldsymbol{x})}{\partial x_{2}} & \cdots & \frac{\partial f(\boldsymbol{x})}{\partial x_{n}}
\end{array}\right] \in \mathbb{R}^{1 \times n}

这个式子被称为的**梯度**或者**雅可比矩阵**（Jacobian）。
对于一个多变量函数的偏导数（，）可以写成矩阵乘法的形式：

\frac{\mathrm{d} f}{\mathrm{~d}(s, t)}=\frac{\partial f}{\partial \boldsymbol{x}} \frac{\partial \boldsymbol{x}}{\partial(s, t)}=\underbrace{\left[\frac{\partial f}{\partial x_{1}} \quad \frac{\partial f}{\partial x_{2}}\right]}_{=\frac{\partial f}{\partial \boldsymbol{x}}} \underbrace{\left[\begin{array}{cc}
\frac{\partial x_{1}}{\partial s} & \frac{\partial x_{1}}{\partial t} \\
\frac{\partial x_{2}}{\partial s} & \frac{\partial x_{2}}{\partial t}
\end{array}\right]}_{=\frac{\partial \boldsymbol{x}}{\partial(s, t)}} .> 

为了检验梯度计算结果的正确行，可以采用**梯度验证**（Gradient checking）的方式进行检验：
这里用到了**有限差分法**（Finite difference method，FDM）：FDM are one of the most common approaches to the numerical solution of PDE（partial differential equations）, along with finite element methods.
就是将连续函数离散化。

FDM的基本原理就是利用一个很小的数，判断自变量在这个范围中变化时对应的函数值的变化情况是否与梯度相似。

\frac{d}{d\theta}J(\theta)\approx \frac{J(\theta + \epsilon)-J(\theta-\epsilon)}{2\epsilon}, \quad \epsilon\rightarrow 0

# [](#%E5%90%91%E9%87%8F%E5%80%BC%E5%87%BD%E6%95%B0%E7%9A%84%E6%A2%AF%E5%BA%A6%EF%BC%88Gradients-of-Vector-Valued-Functions%EF%BC%89)向量值函数的梯度（Gradients of Vector-Valued Functions）

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210427133447332.png?x-oss-process=image,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)
这样，就将原先的映射成,对于每一个：,也就是将原先的n维自变量映射成了一个实数。
所以：

\frac{\partial\boldsymbol f(x)}{\partial x_i}=\left[\begin{array}{cc}\frac{\partial f_1(x)}{\partial x_i}\\\vdots\\ \frac{\partial f_m(x)}{\partial x_i} \end{array}\right]\in \mathbb R^m

而一个函数对一个列向量的映射，也就是之前提到梯度，可以写成：

\nabla_{\boldsymbol{x}} f=\operatorname{grad} f=\frac{\mathrm{d} f}{\mathrm{~d} \boldsymbol{x}}=\left[\begin{array}{llll}
\frac{\partial f(\boldsymbol{x})}{\partial x_{1}} & \frac{\partial f(\boldsymbol{x})}{\partial x_{2}} & \cdots & \frac{\partial f(\boldsymbol{x})}{\partial x_{n}}
\end{array}\right] \in \mathbb{R}^{1 \times n}

代入上式，得到向量值方程的一阶偏导数：

\begin{aligned}
J &=\nabla_{x} f=\frac{\mathrm{d} f(x)}{\mathrm{d} x}=\left[\begin{array}{ccc}
\frac{\partial f(x)}{\partial x_{1}} & \cdots & \frac{\partial f(x)}{\partial x_{n}}
\end{array}\right] \\
&=\left[\begin{array}{ccc}
\frac{\partial f_{1}(x)}{\partial x_{1}} & \cdots & \frac{\partial f_{1}(x)}{\partial x_{n}} \\
\vdots & & \vdots \\
\frac{\partial f_{m}(x)}{\partial x_{1}} & \cdots & \frac{\partial f_{m}(x)}{\partial x_{n}}
\end{array}\right] \\
x &=\left[\begin{array}{c}
x_{1} \\
\vdots \\
x_{n}
\end{array}\right], \quad J(i, j)=\frac{\partial f_{i}}{\partial x_{j}} .
\end{aligned}

的一阶偏导数称为**雅可比矩阵**。
雅可比矩阵用于求解映射之后图形的**比例因子**（scaling factor）
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210427140052382.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)
想要找到比例因子，可以找出对应的变换矩阵，这个矩阵的行列式的绝对值就是面积变化的比例。但是这个适用于线性变换，当面对非线性变换的时候，需要采取另一种策略。
想要知道当变化的时候的变化情况，我们可以使用偏导数得到变化信息。所以，雅可比矩阵可以表示相对应的变换矩阵。

> 

非线性的情况时，采用逼近的方式获得比例因子
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210427195823520.png?x-oss-process=image,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

向量和对应的映射所处的维度与偏导数的关系：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210427200004258.png)

# [](#%E7%9F%A9%E9%98%B5%E6%A2%AF%E5%BA%A6%EF%BC%88Gradients-of-Matrices%EF%BC%89)矩阵梯度（Gradients of Matrices）

矩阵的梯度的结果可能得到一个高维的矩阵，这种矩阵称为**张量**（Tensor）
两种计算矩阵梯度的方法：
一种是直接计算，最后将结果拼装起来，另一种是将矩阵变成一个向量，

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210427202543293.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

> 

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210427204602190.png)

\frac{d\boldsymbol K}{d\boldsymbol R}\in \mathbb R^{(N\times N)\times(M\times N)}\frac {d K_{pq}}{d\boldsymbol R}\in \mathbb R^{1\times(M\times N)}K_{pq}=r_p^\top r_q=\sum^M_{m=1}\boldsymbol R_{mq}\boldsymbol R_{mp}\frac{\partial \boldsymbol K_{pq}}{\partial \boldsymbol R_{ij}}=\sum_{m=1}^M\frac{\partial}{\partial R_{ij}}R_{mp}R_{mq}=\partial_{pqij},\partial_{}
\partial_{p q i j}=\left\{\begin{array}{ll}
R_{i q} & \text { if } j=p, p \neq q \\
R_{i p} & \text { if } j=q, p \neq q \\
2 R_{i q} & \text { if } j=p, p=q \\
0 & \text { otherwise }
\end{array} .\right.

# [](#%E8%AE%A1%E7%AE%97%E6%A2%AF%E5%BA%A6%E6%97%B6%E6%9C%89%E7%94%A8%E7%9A%84%E6%81%92%E7%AD%89%E5%BC%8F%EF%BC%88Useful-Identities-for-Computing-Gradients%EF%BC%89)计算梯度时有用的恒等式（Useful Identities for Computing Gradients）

\begin{aligned}
&\frac{\partial}{\partial \boldsymbol{X}} \boldsymbol{f} (\boldsymbol{X})^{\top}=\left(\frac{\partial \boldsymbol{f}(\boldsymbol{X})}{\partial \boldsymbol{X}}\right)^{\top}\\
&\frac{\partial}{\partial \boldsymbol{X}} \operatorname{tr}(\boldsymbol{f}(\boldsymbol{X}))=\operatorname{tr}\left(\frac{\partial \boldsymbol{f}(\boldsymbol{X})}{\partial \boldsymbol{X}}\right)\\
&\frac{\partial}{\partial \boldsymbol{X}} \operatorname{det}(\boldsymbol{f}(\boldsymbol{X}))=\operatorname{det}(\boldsymbol{f}(\boldsymbol{X})) \operatorname{tr}\left(\boldsymbol{f}(\boldsymbol{X})^{-1} \frac{\partial \boldsymbol{f}(\boldsymbol{X})}{\partial \boldsymbol{X}}\right)\\
&\frac{\partial}{\partial \boldsymbol{X}} \boldsymbol{f}(\boldsymbol{X})^{-1}=-\boldsymbol{f}(\boldsymbol{X})^{-1} \frac{\partial \boldsymbol{f}(\boldsymbol{X})}{\partial \boldsymbol{X}} \boldsymbol{f}(\boldsymbol{X})^{-1}\\
&\frac{\partial \boldsymbol{a}^{\top} \boldsymbol{X}^{-1} \boldsymbol{b}}{\partial \boldsymbol{X}}=-\left(\boldsymbol{X}^{-1}\right)^{\top} \boldsymbol{a} b^{\top}\left(\boldsymbol{X}^{-1}\right)^{\top}\\
&\frac{\partial \boldsymbol{x}^{\top} \boldsymbol{a}}{\partial \boldsymbol{x}}=\boldsymbol{a}^{\top}\\
&\frac{\partial \boldsymbol{a}^{\top} \boldsymbol{x}}{\partial \boldsymbol{x}}=\boldsymbol{a}^{\top}\\
&\frac{\partial \boldsymbol{a}^{\top} \boldsymbol{X} \boldsymbol{b}}{\partial \boldsymbol{X}}=\boldsymbol{a} \boldsymbol{b}^{\top}\\
&\frac{\partial \boldsymbol{x}^{\top} \boldsymbol{B} \boldsymbol{x}}{\partial \boldsymbol{x}}=\boldsymbol{x}^{\top}\left(\boldsymbol{B}+\boldsymbol{B}^{\top}\right)\\
&\frac{\partial}{\partial s}(x-A s)^{\top} W(x-A s)=-2(x-A s)^{\top} W A \quad \text { for symmetric } W\\
&(5.108)
\end{aligned}> 

计算:

# [](#%E5%8F%8D%E5%90%91%E4%BC%A0%E6%92%AD%E5%92%8C%E8%87%AA%E5%8A%A8%E5%BE%AE%E5%88%86%EF%BC%88Backpropagation-and-Automatic-Differentiation%EF%BC%89)反向传播和自动微分（Backpropagation and Automatic Differentiation）

为了计算损失函数（Loss Function）的最小值，这时候需要对损失函数对其所有的参数求偏导，也就是求出损失函数的梯度。但是用传统的链式法则会使得中间步骤十分繁琐，所以有了**反向传播算法**（Backpropagation Algorithm)可以有效地解决损失函数的梯度的问题，并且运算速度与传统的链式法则的计算方式相同。

## [](#%E6%B7%B1%E5%BA%A6%E7%BD%91%E7%BB%9C%E7%9A%84%E6%A2%AF%E5%BA%A6%EF%BC%88Gradients-in-a-Deep-Network%EF%BC%89)深度网络的梯度（Gradients in a Deep Network）

在深度学习中，一个函数通常是由许多的函数复合而成的。

\boldsymbol{y}=\left(f_{K} \circ f_{K-1} \circ \cdots \circ f_{1}\right)(\boldsymbol{x})=f_{K}\left(f_{K-1}\left(\cdots\left(f_{1}(\boldsymbol{x})\right) \cdots\right)\right)

后一层神经元会使用前一层神经元的输出值作为该层的输入值，所以有： 为激活函数.是第i层的输出值。

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210428141227595.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)
为了训练这个神经网络，我们需要求解出损失函数梯度。
假设：

f_{0}:=x \\ f_{i}:=\sigma_{i}\left(A_{i-1} f_{i-1}+b_{i-1}\right), \quad i=1, \ldots, K

损失函数为：

L(\theta)=\|y-f_K(\theta,x)\|^2,\quad \theta=\{\boldsymbol A_0,\boldsymbol b_0,\dots, \boldsymbol A_{K-1},\boldsymbol b_{K-1}\}

要求解这个函数的最小值，我们需要对损失函数求偏导。

\begin{aligned}
\frac{\partial L}{\partial \boldsymbol{\theta}_{K-1}} &=\frac{\partial L}{\partial \boldsymbol{f}_{K}} \frac{\partial \boldsymbol{f}_{K}}{\partial \boldsymbol{\theta}_{K-1}} \\
\frac{\partial L}{\partial \boldsymbol{\theta}_{K-2}} &=\frac{\partial L}{\partial \boldsymbol{f}_{K}}\frac{\partial f_{K}}{\partial f_{K-1}} \frac{\partial \boldsymbol{f}_{K-1}}{\partial \boldsymbol{\theta}_{K-2}}\\
\frac{\partial L}{\partial \boldsymbol{\theta}_{K-3}} &=\frac{\partial L}{\partial \boldsymbol{f}_{K}} \frac{\partial f_{K}}{\partial f_{K-1}} \frac{\partial \boldsymbol{f}_{K-1}}{\partial f_{K-2}} \frac{\partial \boldsymbol{f}_{K-2}}{\partial \boldsymbol{\theta}_{K-3}} \\
\frac{\partial L}{\partial \boldsymbol{\theta}_{i}} &=\frac{\partial L}{\partial \boldsymbol{f}_{K}} \frac{\partial f_{K}}{\partial f_{K-1}} \cdots \frac{\partial f_{i+2}}{\partial f_{i+1}} \frac{\partial \boldsymbol{f}_{i+1}}{\partial \boldsymbol{\theta}_{i}}
\end{aligned}

这样看来，当我们需要计算时，我们可以利用之前的简化计算。

\frac{\partial L}{\partial \boldsymbol\theta_i}=\frac{\partial L}{\partial \boldsymbol\theta_{i+1}}\frac{\partial \boldsymbol f_{i+1}}{\partial \boldsymbol\theta_i}

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210428143935866.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

## [](#%E8%87%AA%E5%8A%A8%E5%BE%AE%E5%88%86%EF%BC%88Automatic-Differentiation%EF%BC%89)自动微分（Automatic Differentiation）

反向传播算法实际上时自动微分中的一个特例。自动微分类似计算的时候用的还原法，将这些中间步骤用一个变量表示出来：

y=f(g(h(x)))=f(g(h(w_0)))=f(g(w_1))=f(w_2)=w_3

原始的链式法则：

\frac {dy}{dx}=\frac{dy}{dw_2}\frac{dw_2}{dw_1}\frac{dw_1}{dx}=\frac{df(w_2)}{dw_2}\frac{dg(w_1)}{dw_1}\frac{dh(w_0)}{dx}

自动微分有两种模式：**向前模式**（forward mode）和**向后模式**（reverse mode）
向前模式就是从内层函数到外层函数逐步进行求导，向后模式则是相反。

使用计算图（computational graphs），每个节点代表一个计算过程中的中间变量。
例如：用计算图可以表示为：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210428212906625.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

可以描述为：

For\ \ i=d+1,\dots, D :\quad x_i=g_i(x_{pa(x_i)})

其中，表示节点的父节点。表示节点对应的计算函数。

> 

这部分没什么弄懂，后续继续补充。
计算图的那个部分。
利用上面的关系可以得出：

\frac{df}{dx_i}=\sum_{j:i\in Pa(j)}\frac{df}{dx_i}\frac{dx_j}{dx_i}=\sum_{j:i\in Pa(j)}\frac{df}{dx_j}\frac{dg_i}{dx_i}

这实际上就是利用链式法则求解出对中间变量的微分。对最后一个中间变量的微分为1

符号微分（Symbolic differentiation）之所以复杂是因为在运算过程中并没有中间变量，所以想要直接编码解决难度较大

# [](#%E9%AB%98%E9%98%B6%E5%81%8F%E5%AF%BC%E6%95%B0%EF%BC%88Higher-Order-Derivatives%EF%BC%89)高阶偏导数（Higher-Order Derivatives）

当我们想要用牛顿法进行优化的时候，二阶偏导数就不得不被使用了。
有一个符号需要注意：
这个意思时先对y求导，然后再对x求导。
**海森矩阵**（Hessian Matrix）
海森矩阵存储函数的二阶偏导数。

\nabla^2_{x,y}f(x,y)=\boldsymbol{H}=\left[\begin{array}{cc}\frac{\partial^{2} f}{\partial x^{2}} & \frac{\partial^{2} f}{\partial x \partial y} \\ \frac{\partial^{2} f}{\partial x \partial y} & \frac{\partial^{2} f}{\partial y^{2}}\end{array}\right]

表示函数在处的曲率

# [](#%E7%BA%BF%E6%80%A7%E5%8C%96%E5%92%8C%E5%A4%9A%E5%85%83%E6%B3%B0%E5%8B%92%E7%BA%A7%E6%95%B0%EF%BC%88Linearization-and-Multivariate-Taylor-Series%EF%BC%89)线性化和多元泰勒级数（Linearization and Multivariate Taylor Series）

假设一个函数：

\begin{aligned} f: \mathbb{R}^{D} & \rightarrow \mathbb{R} \\ \quad \boldsymbol{x} & \mapsto f(\boldsymbol{x}), \quad \boldsymbol{x} \in \mathbb{R}^{D} \end{aligned}

在处光滑，设,所以：

f(x)=\sum^\infty_{k=0}\frac{D^k_\boldsymbol xf(x_0)}{k!}\delta^k

为在处的多元泰勒公式。其中,，表示对x的k阶偏导。和都是k阶张量，其中：

\boldsymbol{\delta}^{k} \in \mathbb{R} \overbrace{D \times D \times \ldots \times D}^{k \text { times }}\boldsymbol{\delta}^{3}:=\boldsymbol{\delta} \otimes \boldsymbol{\delta} \otimes \boldsymbol{\delta}, \quad \boldsymbol{\delta}^{3}[i, j, k]=\delta[i] \delta[j] \delta[k]

所以，（第一个中括号是前面偏导向量的索引）

D_{\boldsymbol{x}}^{k} f\left(\boldsymbol{x}_{0}\right) \boldsymbol{\delta}^{k}=\sum_{i_{1}=1}^{D} \cdots \sum_{i_{k}=1}^{D} D_{\boldsymbol{x}}^{k} f\left(\boldsymbol{x}_{0}\right)\left[i_{1}, \ldots, i_{k}\right] \delta\left[i_{1}\right] \cdots \delta\left[i_{k}\right]

下面是上式的前三项：

\begin{array}{l}
k=0, \ldots, 3 \text { and } \delta:=x-x_{0}: \\
k=0: D_{\boldsymbol{x}}^{0} f\left(\boldsymbol{x}_{0}\right) \boldsymbol{\delta}^{0}=f\left(\boldsymbol{x}_{0}\right) \in \mathbb{R} \\
k=1: D_{\boldsymbol{x}}^{1} f\left(\boldsymbol{x}_{0}\right) \boldsymbol{\delta}^{1}=\underbrace{\nabla_{\boldsymbol{x}} f\left(\boldsymbol{x}_{0}\right)}_{1 \times D} \underbrace{\delta}_{D \times 1}=\sum_{i=1}^{D} \nabla_{\boldsymbol{x}} f\left(\boldsymbol{x}_{0}\right)[i] \delta[i] \in \mathbb{R} \\
k=2: D_{\boldsymbol{x}}^{2} f\left(\boldsymbol{x}_{0}\right) \boldsymbol{\delta}^{2}=\operatorname{tr}(\underbrace{\boldsymbol{H}\left(\boldsymbol{x}_{0}\right)}_{D \times D} \underbrace{\delta}_{D \times 1} \underbrace{\delta^{\top}}_{1 \times D})=\delta^{\top} \boldsymbol{H}\left(\boldsymbol{x}_{0}\right) \boldsymbol{\delta} \\
=\sum_{i=1}^{D} \sum_{j=1}^{D} H[i, j] \delta[i] \delta[j] \in \mathbb{R} \\
k=3: D_{\boldsymbol{x}}^{3} f\left(\boldsymbol{x}_{0}\right) \boldsymbol{\delta}^{3}=\sum_{i=1}^{D} \sum_{j=1}^{D} \sum_{k=1}^{D} D_{x}^{3} f\left(\boldsymbol{x}_{0}\right)[i, j, k] \delta[i] \delta[j] \delta[k] \in \mathbb{R}
\end{array}

其中表示在处的海森矩阵。

> 

证明？

k=2: D_{\boldsymbol{x}}^{2} f\left(\boldsymbol{x}_{0}\right) \boldsymbol{\delta}^{2}=\operatorname{tr}(\underbrace{\boldsymbol{H}\left(\boldsymbol{x}_{0}\right)}_{D \times D} \underbrace{\delta}_{D \times 1} \underbrace{\delta^{\top}}_{1 \times D})=\delta^{\top} \boldsymbol{H}\left(\boldsymbol{x}_{0}\right) \boldsymbol{\delta} \\
=\sum_{i=1}^{D} \sum_{j=1}^{D} H[i, j] \delta[i] \delta[j] \in \mathbb{R}

# [](#%E8%A1%A5%E5%85%85)补充
## [](#%E5%8F%8D%E5%90%91%E4%BC%A0%E6%92%AD%EF%BC%88%E6%8E%A8%E5%AF%BC%EF%BC%89)反向传播（推导）

我们想要求的是对损失函数对参数的求导的结果：

\frac{dL}{dv_i},i\ge N-M+1

利用链式法则：

\frac{dL}{dv_i}=\sum_{j:i\in Pa(j)}\frac{dL}{dv_i}\frac{dv_i}{dv_j}

回想我们计算激活值的方法：

v_i=\sigma_i(w_i\cdot v_{Pa(i)})

所以我们可以计算：

\frac{dv_i}{dv_j}=\sigma_i'(\boldsymbol w_i\cdot \boldsymbol v_{Pa(i)})w_{iq},Pa(i)_q=j

举个例子，假设,则激活值为：

v_i=\sigma_i(\boldsymbol w_i\cdot \boldsymbol v_{(2,7,9)})

展开即为下面这些式子：

\begin{aligned}
\frac{d v_{i}}{d v_{2}} &=\sigma_{i}^{\prime}\left(\mathbf{w}_{i} \cdot \mathbf{v}_{(2,7,9)}\right) w_{i 1} \\
\frac{d v_{i}}{d v_{7}} &=\sigma_{i}^{\prime}\left(\mathbf{w}_{i} \cdot \mathbf{v}_{(2,7,9)}\right) w_{i 2} \\
\frac{d v_{i}}{d v_{9}} &=\sigma_{i}^{\prime}\left(\mathbf{w}_{i} \cdot \mathbf{v}_{(2,7,9)}\right) w_{i 3} .
\end{aligned}

我们用带入到原先的式子中：

\frac{dv_i}{dv_j}=v_i'w_{iq},Pa(i)_q=j

对应的向量形式为：

\frac{dv_i}{d\mathbf v_{Pa(i)}}= v'_i\mathbf w_i

于是我们可以很容易得到：(带入已知式)

\begin{aligned}
\frac{d L}{d \mathbf{w}_{i}} &=\frac{d L}{d v_{i}} \frac{d v_{i}}{d \mathbf{w}_{i}} \\
&=\frac{d L}{d v_{i}} \sigma_{i}^{\prime}\left(\mathbf{w} \cdot \mathbf{v}_{\mathrm{Pa}(i)}\right) \mathbf{v}_{\mathrm{Pa}(i)} \\
&=\frac{d L}{d v_{i}} v_{i}^{\prime} \mathbf{v}_{\mathrm{Pa}(i)}
\end{aligned}