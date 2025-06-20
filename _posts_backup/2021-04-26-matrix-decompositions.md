---
layout: post
title: "机器学习中的数学：（三）矩阵分解(Matrix Decompositions)"
date: 2021-04-26 02:32:53 +0000
categories: [blog]
tags: []
---

@[toc]
矩阵分解可以用于压缩矩阵，以尽可能少的空间存储一个矩阵，同时损失尽可能少的信息。同时对数据进行降维还可以减少发生**维度灾难**的发生。

> 

**维数灾难**： 当数据维度提升的时候，因为空间体积提升过快，因而可用数据变得很稀疏。然而在高维空间中，所有的数据都很稀疏，从很多角度看都不相似，因而平常使用的数据组织策略变得极其低效。

在机器学习问题中，需要在高维特征空间（每个特征都能够取一系列可能值）的有限数据样本中学习一种“自然状态”（可能是无穷分布），要求有相当数量的训练数据含有一些样本组合。给定固定数量的训练样本，其预测能力随着维度的增加而减小，这就是所谓的Hughes影响或Hughes现象（以Gordon F. Hughes命名）。
        ———Wiki
个人理解：随着维度的升高数据之间的距离加大，这导致数据组合而成的用于最终判断的特征难以被发现

# [](#%E8%A1%8C%E5%88%97%E5%BC%8F%E4%B8%8E%E8%BF%B9%EF%BC%88Determinant-and-Trace%EF%BC%89)行列式与迹（Determinant and Trace）
## [](#%E8%A1%8C%E5%88%97%E5%BC%8F%EF%BC%88Dterminant%EF%BC%89)行列式（Dterminant）

行列式可以看成将一个方阵映射成一个实数。（只有方阵才有行列式）
可以将行列式用于判断一个方阵是否可逆：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210422212906189.png)

对于上/下三角矩阵的行列式的值为:

\operatorname{det}(\boldsymbol{T})=\prod_{i=1}^{n} T_{i i}

对于n阶行列的计算，可以使用**拉普拉斯展开**(Laplace Expansion)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210422213649972.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210422213733943.png)

行列式的几何含义就是带有符号的多边形的体积，这个多边形是由行列式所对应的列向量通过平移之后组成的.注意到当至少其中的两个向量重合的时候，也就是这两个向量线性相关的时候，他们组成的几何体的体积为0，所以这时候他们组成的方阵的行列式为0.
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210422213432734.png)![在这里插入图片描述](https://img-blog.csdnimg.cn/20210422213436294.png)
行列式的一些性质：
![](https://img-blog.csdnimg.cn/20210422213814612.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210422213949173.png)

## [](#%E8%BF%B9-Trace)迹(Trace)

假设是矩阵A的特征多项式，那么A的迹为：

\operatorname{tr}(\boldsymbol A)=\sum^k_{i=1}d_i\lambda_i

对于一个方阵的迹就是它所有对角线元素的和：

tr(\bold A):=\sum\limits_{i=1}^na_{ii}

迹的一些性质：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210422214211626.png?x-oss-process=image,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210422214251939.png)
假设、是向量空间U的两个基向量，所以一定存在一个向量,使得:

\operatorname{tr}(\boldsymbol{B})=\operatorname{tr}\left(\boldsymbol{S}^{-1} \boldsymbol{A} \boldsymbol{S}\right) \stackrel{(4.19)}{=} \operatorname{tr}\left(\boldsymbol{A} \boldsymbol{S} \boldsymbol{S}^{-1}\right)=\operatorname{tr}(\boldsymbol{A})

**特征多项式**：
![在这里插入图片描述](https://img-blog.csdnimg.cn/2021042221461996.png?x-oss-process=image,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)
其中：

c_0=det(\bold A) \\ c_{n-1}=(-1)^{n-1}tr(\bold A)

特征多项式可以用于求解特征值和特征向量。

# [](#%E7%89%B9%E5%BE%81%E5%80%BC%E4%B8%8E%E7%89%B9%E5%BE%81%E5%90%91%E9%87%8F)特征值与特征向量

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210423102704877.png)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210423102727720.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

特征向量不是唯一的，与特征向量共线的所有向量都是这个矩阵的特征向量。
共线与共向：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210423102845808.png)
特征值是矩阵特征多项式的一个根。
**代数重度**（algebraic multiplicity）：该特征是特征向量的几重根。
**特征空间**：特征值对应的特征向量组成的向量空间就是特征空间
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210423103140423.png)

> 

有疑问
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210423103537224.png)
特征向量所张成的空间就是特征向量通过线性映射之后得到的。而特征向量所对应的特征值的正负对应着特征向量的指向的方向

特征值的几个非常有用的性质：
1.矩阵和他的转置的特征值一样，但是特征向量不一定一样
2.观察特征方程,这说明对应着核空间
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210423103825435.png)

3.相似矩阵（）的特征值保持一致，说明特征值是与基向量无关的（拥有这种性质的还有迹和行列式）
4.正定矩阵拥有正的实特征值。

**几何重度**（Geometric Multiplicity，特征空间的维度）：
对应的线性无关的特征向量的个数。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210423104316545.png)

> 

为什么？
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210423104418946.png)

**二维空间中的几何直观理解**：
对于特征方程（），等式右边是对向量x的一个变换（变换矩阵为A），右边为对x的一个伸展，二者相等，说明在经历过变换之后，x向量只是简单地发生了范数地增长，并没有离开原先地向量空间。而这个变换之后不离开原先向量空间的向量称为**特征向量**。特征向量组成的向量空间，称为**特征空间**，在特征空间中的所有向量经过变换之后也不会离开原先的张成空间。向量延展的倍数为变换矩阵的**特征值**
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210423133916529.png?x-oss-process=image,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)
特征向量与特征值的求解过程：
由特征方程得到：当为零向量的时候，等式成立，但是我们想要一个非零向量，所以原来的式子的含义就变成，将一个向量压缩成一个零向量，这就是说在经过变换之后原先的向量发生了降维，这就是说不是满秩的，就好像是一个三维体经过变换之后变成了二维，这时候变换之后的几何体的体积变成了0，也就是相对应的行列式变成了0，所以、
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210423133912252.png?x-oss-process=image,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

下图是不同类型的线性映射时候特征值和行列式的情况：
其中

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210423134928849.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

> 

为什么最后一个的行列式的值发生了变化？

每一个特征空间在变换中对应着唯一一个特征值（倍数），所以当倍数（特征值）全部都是不同的时候，说明有所有的特征向量都是线性无关的。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210423141732757.png)
**亏损矩阵**
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210423142205462.png)
对于一个非亏损矩阵（）不一定需要n个不同的特征值，但是一定需要n个特征向量组成的基。（注意到不同的向量在变换的时候延伸的倍数是可以一样的，所以会有一个特征值对应几个特征向量的情况）

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210423142559266.png)
**谱定律**：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210423201349436.png)
这说明一个对称矩阵可以进行特征分解,也就是说能够找到特征向量对应的规范正交基，使得其中D为对角矩阵，P由特征向量组成。

**行列式与迹的意义**：分别与面积（体积）和周长相关
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210423201949444.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210423202001438.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

# [](#%E6%9F%AF%E5%88%97%E6%96%AF%E5%9F%BA%E5%88%86%E8%A7%A3%EF%BC%88Cholesky-Decomposition%EF%BC%89)柯列斯基分解（Cholesky Decomposition）

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210423202734362.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

> 

计算方式：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210423202908551.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

这在深度学习中有很多的应用，同时还可以用于计算行列式（上下三角矩阵的行列式非常好计算）

# [](#%E7%89%B9%E5%BE%81%E5%88%86%E8%A7%A3%E5%92%8C%E5%AF%B9%E8%A7%92%E5%8C%96)特征分解和对角化

可对角化的条件：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210423203839482.png)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210423204815898.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)
这需要P矩阵是满秩的
**特征分解**
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210423205113416.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)
这实际上就是A与D相似。P由A的特征向量组成，D由A的特征值组成（对角矩阵）

> 

如何理解相似矩阵？
如何理解谱定理？![在这里插入图片描述](https://img-blog.csdnimg.cn/20210424105653896.png)
![在这里插入图片描述](https://img-blog.csdnimg.cn/2021042410570861.png)

## [](#%E7%9F%A9%E9%98%B5%E5%88%86%E8%A7%A3%E7%9A%84%E5%87%A0%E4%BD%95%E7%9B%B4%E8%A7%82%E7%90%86%E8%A7%A3)矩阵分解的几何直观理解

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210424121857566.png?x-oss-process=image,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

> 

各部分对应的变换还是不是很清楚。
特征值分解可以这样理解，首先先进行一次基变换，将正交基变换至由特征向量组成的向量空间中，然后进行延展（这就是变换矩阵A对应在特征向量中的变换Ax=）,最后将向量空间复原到原先的向量空间中。

对待方程,可以这样想，单位矩阵经过A矩阵变换之后等价于三个矩阵变化之后的结果。
将一个矩阵分解之后，可以很方便地计算矩阵地行列式和n次方。

det(\bold A)=det(\bold P\bold D\bold P^{-1})=det(\bold P)*det(\bold D)*det(\bold P^{-1})=\prod_id_{ii}# [](#%E5%A5%87%E5%BC%82%E5%80%BC%E5%88%86%E8%A7%A3%EF%BC%88Singular-Value-Decomposition%EF%BC%8CSVD%EF%BC%89)奇异值分解（Singular Value Decomposition，SVD）

相对于特征值分解，奇异值分解使用范围更广，它不要求分解的矩阵是方阵。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210424135923640.png?x-oss-process=image,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)
𝕦称为左奇异向量；𝕧称为右奇异向量。

矩阵起到拓展维度的作用，所以：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210424140128695.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

## [](#SVD%E7%9A%84%E5%87%A0%E4%BD%95%E7%9B%B4%E8%A7%82%E8%A7%A3%E9%87%8A)SVD的几何直观解释

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210424140421187.png?x-oss-process=image,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

> 

奇异值分解其实和特征值分解类似，只是在延伸的时候加了一些东西，这是因为矩阵为非方阵的时候，这样的变换会使向量发生维度的变化，所以矩阵在不是方阵的情况下，不仅仅使向量进行相对应的变换，还将维度进行了提升。

起到旋转的作用，起到拓展上域（codomain，到达域）维度的作用，最后U帮助向量升维。

> 

上域
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210424140700348.png?x-oss-process=image,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

一个变换实例：
![在这里插入图片描述](https://img-blog.csdnimg.cn/2021042414101820.png)

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210424140923239.png?x-oss-process=image,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

## [](#%E6%B1%82%E8%A7%A3%E7%9F%A9%E9%98%B5%E7%9A%84SVD)求解矩阵的SVD

对于一个对称正定矩阵（SPD矩阵）有:
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210425131251977.png?x-oss-process=image,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)
所以一个SDP矩阵的SVD就是它的特征值分解。

计算一个矩阵,等价于求解上域（codomain）和定义域（domain）的规范正交基

> 

What’s the graphic intuitions?And why?

**求解右奇异向量**

> 

由谱定理得知，对称矩阵的特征向量组成规范正交基，也就是说对称矩阵能够相似对角化。而我们可以通过的方式得到一个半正定的对称矩阵。

\boldsymbol{A}^{\top} \boldsymbol{A}=\boldsymbol{P} \boldsymbol{D} \boldsymbol{P}^{\top}=\boldsymbol{P}\left[\begin{array}{ccc}\lambda_{1} & \cdots & 0 \\ \vdots & \ddots & \vdots \\ 0 & \cdots & \lambda_{n}\end{array}\right] \boldsymbol{P}^{\top}

将SVD带入：

\boldsymbol{A}^{\top} \boldsymbol{A}=\left(\boldsymbol{U} \boldsymbol{\Sigma} \boldsymbol{V}^{\top}\right)^{\top}\left(\boldsymbol{U} \boldsymbol{\Sigma} \boldsymbol{V}^{\top}\right)=\boldsymbol{V} \boldsymbol{\Sigma}^{\top} \boldsymbol{U}^{\top} \boldsymbol{U} \boldsymbol{\Sigma} \boldsymbol{V}^{\top}

由于是正交矩阵，所以:

\boldsymbol{A}^{\top} \boldsymbol{A}=\boldsymbol{V} \boldsymbol{\Sigma}^{\top} \boldsymbol{\Sigma} \boldsymbol{V}^{\top}=\boldsymbol{V}\left[\begin{array}{ccc}\sigma_{1}^{2} & 0 & 0 \\ 0 & \ddots & 0 \\ 0 & 0 & \sigma_{n}^{2}\end{array}\right] \boldsymbol{V}^{\top}

由此可以得出，A的SVD的奇异值就是的特征值的开根号的结果。其特征矩阵就是右奇异矩阵。

对于**左奇异矩阵**采取相似的方式：

\begin{aligned}
\boldsymbol{A} \boldsymbol{A}^{\top} &=\left(\boldsymbol{U} \boldsymbol{\Sigma} \boldsymbol{V}^{\top}\right)\left(\boldsymbol{U} \boldsymbol{\Sigma} \boldsymbol{V}^{\top}\right)^{\top}=\boldsymbol{U} \boldsymbol{\Sigma} \boldsymbol{V}^{\top} \boldsymbol{V} \boldsymbol{\Sigma}^{\top} \boldsymbol{U}^{\top}\\ 
&=\boldsymbol{U}\left[\begin{array}{ccc}
\sigma_{1}^{2} & 0 & 0 \\
0 & \ddots & 0 \\
0 & 0 & \sigma_{m}^{2}
\end{array}\right] \boldsymbol{U}^{\top} .
\end{aligned}

现在**将左右奇异矩阵**联系起来：
由于中的向量在经过A矩阵变换之后仍旧是正交向量，因为，\left(\boldsymbol{A} \boldsymbol{v}_{i}\right)^{\top}\left(\boldsymbol{A} \boldsymbol{v}_{j}\right)=\boldsymbol{v}_{i}^{\top}\left(\boldsymbol{A}^{\top} \boldsymbol{A}\right) \boldsymbol{v}_{j}=\boldsymbol{v}_{i}^{\top}\left(\lambda_{j} \boldsymbol{v}_{j}\right)=\lambda_{j} \boldsymbol{v}_{i}^{\top} \boldsymbol{v}_{j}=0，\quad i\ne j
单位化右奇异向量的像域：

\boldsymbol{u}_{i}:=\frac{\boldsymbol{A} \boldsymbol{v}_{i}}{\left\|\boldsymbol{A} \boldsymbol{v}_{i}\right\|}=\frac{1}{\sqrt{\lambda_{i}}} \boldsymbol{A} \boldsymbol{v}_{i}=\frac{1}{\sigma_{i}} \boldsymbol{A} \boldsymbol{v}_{i}> 

二者的关系？

由上得到奇异方程：

\boldsymbol A\boldsymbol v_i=\sigma_i\boldsymbol u_i,\quad i=1,\dots,r

于是有：

\boldsymbol A\boldsymbol V=\Sigma\boldsymbol U

移项得：

\boldsymbol A=\boldsymbol U\Sigma\boldsymbol V^\top

这就是矩阵A的SVD。

# [](#%E7%9F%A9%E9%98%B5%E9%80%BC%E8%BF%91%EF%BC%88Matrix-Approximation%EF%BC%89)矩阵逼近（Matrix Approximation）

**外积**：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210426100532232.png)
与内积不同，当两个向量相乘的时候，外积得到的是一个矩阵。有之前的SVD分解式，可以得到下式：

\boldsymbol{A}=\sum_{i=1}^{r} \sigma_{i} \boldsymbol{u}_{i} \boldsymbol{v}_{i}^{\top}=\sum_{i=1}^{r} \sigma_{i} \boldsymbol{A}_{i}

但是加入我们不讲所有的外积都加上的话，得到一个秩为的矩阵，这个称为**k秩逼近**（rank-k approximation）

\widehat{\boldsymbol{A}}(k):=\sum_{i=1}^{k} \sigma_{i} \boldsymbol{u}_{i} \boldsymbol{v}_{i}^{\top}=\sum_{i=1}^{k} \sigma_{i} \boldsymbol{A}_{i}

**谱模**（spectral norm）
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210426101036527.png)
谱模表示，一个向量在经历矩阵A的变换之后最长可以变成多长（下标2代表的是欧几里得空间）。可以证明，矩阵A的谱模就是它的最大的奇异值

**埃卡特-杨定理**
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210426101250788.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)
这个定理量化了矩阵近似会造成的误差。

> 

证明过程？

# [](#%E6%80%BB%E7%BB%93)总结

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210426103210671.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)