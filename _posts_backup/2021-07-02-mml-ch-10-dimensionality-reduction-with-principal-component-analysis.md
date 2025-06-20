---
layout: post
title: "MML ch 10 主成分分析降维（Dimensionality Reduction with Principal Component Analysis）"
date: 2021-07-02 04:38:46 +0000
categories: [blog]
tags: []
---

@[toc]
对于一些高维的数据，分析难度大，而且想要对这些数据进行可视化几乎是不可能的，并且想要存储这些数据的代价也是及其昂贵的，所以我们想要找到一种能够将数据的维度降低的方法。这其中，**主成分分析法**（principal component analysis (PCA)）是最常用的方法之一。

# [](#%E9%97%AE%E9%A2%98%E8%AE%BE%E7%BD%AE%EF%BC%88Problem-Setting%EF%BC%89)问题设置（Problem Setting）

在PCA中，我们希望能够找到一个一个向量的投影向量,与原向量尽可能相近。
对于一个独立均匀分布的数据集,它的均值为0， 对应的数据方差矩阵为：

S=\frac 1N \sum^N_{n=1}x_nx^\top

压缩之后表示为：

z_n = B^\top x_n\in \mathbb R^M

其中，B为投影矩阵，定义为：

B := [b_1,\cdots,b_M]\in \mathbb R^{D\times M}

假设为正交规范基，则.我们希望找到一个M维的子空间,向其中的投影的向量与原先的向量最相似，因为压缩造成的损失最小。我们将投影的数据表示为,对应的坐标为(基向量为)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210615092117707.png?x-oss-process=image,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)
PCA的目标是最小化平方重构误差（the Squared Reconstruction Error）.
从数据压缩的角度来看，我们先是将源数据压缩到一个更低维度的空间中，对应下图的，然后将压缩的信息复原，对应下图中的; 控制着多少信息能够从到.在PCA中，我们考虑原始数据与低维数据之间的线性关系，所以有以下关系：
。将PCA看成是一个数据压缩的过程，所以可以认为第一个箭头是**编码器**(encoder)，第二个箭头是**解码器**(decoder)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210615162848433.png?x-oss-process=image,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

> 

Graphical illustration of PCA. In PCA, we find a compressed version z of original data x. The compressed data can be reconstructed into , which lives in the original data space, but has an intrinsic lower-dimensional representation than .

# [](#%E6%9C%80%E5%A4%A7%E5%8C%96%E6%96%B9%E5%B7%AE%E7%9A%84%E8%A7%92%E5%BA%A6%E7%9C%8BPCA%EF%BC%88Maximum-Variance-Perspective%EF%BC%89)最大化方差的角度看PCA（Maximum Variance Perspective）

在下图中，我们丢弃了数据关于的信息，这样做能够达到降维的效果，而且使得数据的损失最小化，是源数据与降维之后的数据尽可能相似。假设忽略的信息，则得到的数据就很不相似了，也就是说这个降维操作导致了很多的信息损失。通过观察可以发现，数据在两个维度上的分散程度不一样。当数据在一个维度上越分散，说明这个维度上所包含的信息也就越多，而方差可以表示数据分散程度的大小，所以从方差的角度理解`PCA就是找到低维空间中数据方差最大的维度`。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210615092117707.png?x-oss-process=image,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)
为了运算方便，我们对数据进行一个**均值归一化**（Mean Normalization）,因为我们要研究的是方差，而对数据整体的几何运算并不会影响数据的方差

\mathbb V_z[z]=\mathbb V_x[B^\top(x-\mu)]=\mathbb V_x[B^\top x - B^\top \mu]=\mathbb V_x[B^\top x]

这时候对应的低维空间的数据的均值也是0:。

> 

是投影矩阵，将源数据投影到主成分上，从而实现降维。

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210615165552555.png?x-oss-process=image,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

## [](#%E6%9C%80%E5%A4%A7%E6%96%B9%E5%B7%AE%E7%9A%84%E6%96%B9%E5%90%91%EF%BC%88Direction-with-Maximal-Variance%EF%BC%89)最大方差的方向（Direction with Maximal Variance）

为了找到数据在低维空间中的最大的方差，我们先找到一个向量,数据在这个向量上的投影的方差最大,也就是要最大化中第一个坐标的方差：

V_1 := \mathbb V[z_1]=\frac1N\sum^N_{n=1}z^2_{1n}

我们将表示为数据()在低维空间（）的第一个坐标。的第一个成分为：

z_{1n}=b_1^\top x_n

这是在张成的一维子空间中的正交投影，将上面二式联立：

V_1=\frac1N\sum^N_{n=1}(b_1^\top x_n)^2=\frac 1N \sum^N_{n=1}b_1^\top x_n x_n^\top b_1=b_1^\top\begin{pmatrix}\frac 1N\sum\limits^N_{n=1}x_nx_n^\top \end{pmatrix}b_1=b_1^\top Sb_1

其中， S为数据协方差矩阵。由上式可知，正交基（）会对最终的方差的结果产生影响,所以这里要求这些基向量为规范正交基（），这样问题就转换成一个约束问题：

\max_{b_1}b_1^\top Sb_1,\quad s.t.\ \|b_1\|^2 = 1

利用拉格朗日方法：

\mathfrak L(b_1,\lambda)=b_1^\top Sb_1+\lambda_1(1-b_1^\top b_1)

对上式分别求偏导：

\frac{\partial \mathfrak L}{\partial b_1}=2b_1^\top S-2\lambda_1 b_1^\top,\quad \frac{\partial \mathfrak L}{\partial \lambda_1}=1-b_1^\top b_1

令偏微分的结果为0：

\begin{aligned}Sb_1&=\lambda_1 b_1 \\b_1^\top b_1 &= 1\end{aligned}

由上式可以知道，是方差S的一个特征值，是一个特征向量，利用这个式子，我们可以将问题转化成：

V_1=b_1^\top Sb_1 = \lambda_1b_1^\top b_1 = \lambda_1

所以我们需要找到一个特征值最大的特征向量,这样源数据在投影之后的方差最大，这个特征向量称为**主成分**（Principal Component）我们可以得到投影数据点：

\tilde x_n=b_1 z_{1n}=b_1b_1^\top x_n\in \mathbb R^D

注意这里的投影点上的数据是高纬度空间中的数据，但是实际上存储的时候只需要用低纬度的空间信息就可以表示了。

## [](#M%E7%BB%B4%E5%AD%90%E7%A9%BA%E9%97%B4%E4%B8%8B%E7%9A%84%E6%9C%80%E5%A4%A7%E6%96%B9%E5%B7%AE%EF%BC%88M-dimensional-Subspace-with-Maximal-Variance%EF%BC%89)M维子空间下的最大方差（M-dimensional Subspace with Maximal Variance）

个主成分对应的是的个特征向量，这些特征向量对应着最大的个特征值。由于,所以S是一个对称矩阵，所以由谱定理可以得知，这些特征向量能够形成空间下的维子空间的正交规范特征基。想要找到这些正交基，可以使用向量减法：

\tilde X := X=\sum^{m-1}_{i=1}b_ib_i^\top X=X-B_{m-1}X

其中，数据点的列向量(这里使用列向量是为了计算方便),投影矩阵
所以想要找到第m个主成分，我们需要最大化方差;

V_m=\mathbb V[z_m]=\frac1N \sum^N_{n=1}(b^\top_m \hat x_n)^2=b^\top_m \hat Sb_m,\quad s.t. \ \|b_m\|^2=1

其中，表示为数据集在正交变换之后（Missing argument for \mathcal
\hat\mathcal X）的方差.
假设我们已经知道了的特征向量，设为S的特征向量：

\begin{aligned}\hat Sb_i &= \frac 1N \hat X \hat X^\top b_i=\frac1N(X-B_{m-1}X)(X-B_{m-1}X)^\top b_i\\&=(S-SB_{m-1}-B_{m-1}S+B_{m-1}SB_{m-1})b_i,\end{aligned}\quad (*)

由于都是这个子空间下的规范正交基（ONB），所以：

\boldsymbol B_{m-1}\boldsymbol b_i=\left\{
\begin{aligned}
\boldsymbol b_i, \quad i

当时，说明是子空间下的一个正交基，由于是规范正交基，所以与其他基向量的乘积为0，与自身相乘仍为自身。当时，说明不是子空间下的正交基，这时候，这与其他的所有的正交基相互垂直，所以与他们的乘积也就为0.
由上面的关系可以得到：

\hat S b_i=(S-B_{m-1}S)b_i=Sb_i=\lambda_ib_i\\\hat Sb_m = Sb_m=\lambda_mb_m

这可以知道正交投影之后的向量的特征向量的是一致的。
当时，的关系式带入到（*）中：

\hat{\boldsymbol{S}} b_{i}=\left(\boldsymbol{S}-\boldsymbol{S} \boldsymbol{B}_{m-1}-\boldsymbol{B}_{m-1} \boldsymbol{S}+\boldsymbol{B}_{m-1} \boldsymbol{S} \boldsymbol{B}_{m-1}\right) \boldsymbol{b}_{i}=\mathbf{0}=0 \boldsymbol{b}_{i}

所以可以发现张成于的零空间
由和,可以得到数据在m维上的正交投影的方差为：

V_m=b_m^\top S b_m=\lambda_mb^\top_mb_m=\lambda_m

由上式可以看到数据方差于对应的特征值之间的关系。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210616085600867.png?x-oss-process=image,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)
由上表可知，在200 个特征值中，仅有少数的特征值是显著大于0的，所以方差只存在于少数的主成分之中。
为了评估PCA造成的信息损失，我们有以下标准：
M个主成分所能包含的最大方差：

V_m=\sum^M_{m=1}\lambda_m

其中的是前M个最大的特征值
因数据压缩导致的方差损失：

J_m:=\sum^D_{j=M+1}\lambda_i=V_D-V_m

或者使用相对方差捕获率（the relative variance captured），或者是压缩方差损失

# [](#%E6%8A%95%E5%BD%B1%E7%9A%84%E8%A7%92%E5%BA%A6%E7%9C%8B%E5%BE%85PCA-Projection-Perspective)投影的角度看待PCA(Projection Perspective)

我们可以将PCA理解为找到一个子空间，源数据在上面的正交投影与源数据最为相似，也就是正交投影的数据与源数据的欧几里得距离最小。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210616213629430.png?x-oss-process=image,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

## [](#%E9%97%AE%E9%A2%98%E8%AE%BE%E7%BD%AE%E5%92%8C%E9%97%AE%E9%A2%98%E7%9B%AE%E6%A0%87%EF%BC%88Setting-and-Objective%EF%BC%89)问题设置和问题目标（Setting and Objective）

假设一个规范正交基,所以在这个空间中的所有的向量都可以看成是这些正交基的线性组合：

x=\sum_{d=1}^D\zeta_db_d=\sum^M_{m=1}\zeta_mb_m+\sum^D_{j=M+1}\zeta_jb_j,\quad \zeta \in \mathbb R

在一个低维的子空间中():

\tilde x = \sum^M_{m=1}z_mb_m\in U\in\mathbb R^D

我们的目标就是最小化两种向量之间的欧几里得距离,这个最小化的向量所在的空间被称为**主子空间**（Principal Subspace）,标记为：

\tilde x_n:=\sum^M_{m=1}z_{mn}b_m=Bz_n\in \mathbb R^D,\quad z_n := [z_{1n},\cdots,z_{Mn}]^\top\in \mathbb R^M

为投影矩阵的坐标。
描述PCA之后的损失的量度为**重构误差**（Reconstruction Error）:

J_m:=\frac 1N \sum^N_{n=1}\| x_n-\tilde x_n\|^2## [](#%E6%89%BE%E5%88%B0%E6%9C%80%E4%BC%98%E5%8C%96%E5%9D%90%E6%A0%87%EF%BC%88Finding-Optimal-Coordinates%EF%BC%89)找到最优化坐标（Finding Optimal Coordinates）

想要找到最优化的坐标，需要找到原向量在基向量空间中的正交映射.如下图所示，我的目标也可以理解为找到最小的,由图中可以知道最小的时候是向量正交投影到基向量上的时候。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210624160905266.png?x-oss-process=image,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)
接下来我们从数学的角度理解这个结论。
对于一个规范正交基,假设最优的坐标为,对应投影。为了找到各个维度（坐标）下的最佳的坐标，我们需要将目标函数对坐标进行求导

\begin{aligned}&\frac {\partial J_M}{\partial z_{in}}=\frac{\partial J_M}{\partial\tilde x_n}\frac{\partial \tilde x_n}{\partial z_{in}} \\ &\frac{\partial J_M}{\partial \tilde x_n}-\frac{2}{N}(x_n-\tilde x_n)^\top\in \mathbb R^{1\times D}\end {aligned}

因为：

\tilde x_n:=\sum^M_{m=1}z_{mn}b_m=Bz_n\in \mathbb R^D

所以有：

\frac {\partial J_M}{\partial z_{in}}=-\frac 2N(x_n-\tilde x_n)^\top b_i=-\frac 2N (x_n-\sum_{m=1}^Mz_{mn}b_m)^\top b_i\overset{b_ib_j=0}{=}-\frac{2}{N}(x_n^\top b_i-z_{in}b^\top_ib_i)=-\frac2N(x_n^\top b_i-z_{in})

将上面的偏微分设为0，可以得到最优情况下的坐标：

z_{in}=x_n^\top b_i=b_i^\top x_n,\quad i=1\cdots M,n=1,\cdots ,N

这就说明最优坐标就是将原始数据做正交投影到目标向量空间中的坐标。

![在这里插入图片描述](https://img-blog.csdnimg.cn/2021062417503110.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

> 

现在我们稍微复习一下向基向量的正交投影：
一个向量向正交基进行正交投影

\tilde x=b_j(\underbrace{ b_j^\top b_j}_{ONB,=I})^{-1}b_j^\top x=b_j b_j^\top x \in \mathbb R^D

其中，是正交投影之后的坐标

在新的坐标系下，虽然，但是我们只需要用前M个坐标，因为在这个坐标系下剩下的坐标都是0.

## [](#%E6%89%BE%E5%88%B0%E4%B8%BB%E5%AD%90%E7%A9%BA%E9%97%B4%E7%9A%84%E5%9F%BA%E5%90%91%E9%87%8F%EF%BC%88Finding-the-Basis-of-the-Principal-Subspace%EF%BC%89)找到主子空间的基向量（Finding the Basis of the Principal Subspace）

为了找到主子空间的基向量，我们需要对原先的代价函数的形式进行一些改造。：

\tilde x _n = \sum_{m=1}^Mz_{mn}b_m=\sum _{m=1}^M(x_n^\top b_m)b_m

根据点积的对称性：

\tilde x _n=(\sum^M_{m=1}b_mb_m^\top)x_n> 

补充（原因）

原先提到原始数据可以用基向量线性组合表示，所以(这里可以理解为将原向量分解为投影向量和位移向量)

\begin{aligned}
\boldsymbol{x}_{n} &=\sum_{d=1}^{D} z_{d n} \boldsymbol{b}_{d} \stackrel{(10.32)}{=} \sum_{d=1}^{D}\left(\boldsymbol{x}_{n}^{\top} \boldsymbol{b}_{d}\right) \boldsymbol{b}_{d}=\left(\sum_{d=1}^{D} b_{d} \boldsymbol{b}_{d}^{\top}\right) \boldsymbol{x}_{n} \\
&=\left(\sum_{m=1}^{M} \boldsymbol{b}_{m} \boldsymbol{b}_{m}^{\top}\right) \boldsymbol{x}_{n}+\left(\sum_{j=M+1}^{D} \boldsymbol{b}_{j} \boldsymbol{b}_{j}^{\top}\right) \boldsymbol{x}_{n}
\end{aligned}

所以位移向量（displacement vector）为：

\begin{aligned} x_n-\tilde x_n&=(\sum_{j=M+1}^Db_jb_j^\top)x_n\\&=\sum^D_{j=M+1}(x_n^\top b_j)b_j\end{aligned}

其中，为投影矩阵。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210625194024145.png?x-oss-process=image,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

这里可以看出，位移矩阵是在垂直于主子空间的空间中。

> 

**低秩近似**（(Low-Rank Approximation）：
由之前的讨论得知，投影矩阵为:

\sum_{m=1}^Mb_mb^\top_m=BB^\top

由此，原先的平均平方重构误差可以写为：

\frac 1N\sum^N_{n=1}\|x_n-\tilde x\|^2=\frac 1N \sum_{n=1}^N\|x_n-BB^\top x_n\|^2=\frac 1N \sum^N_{n=1}\|(I-BB^\top)x_n\|^2

所以可以将PCA理解为找到与单位矩阵最接近的的秩逼近。

现在我们能够重构损失函数：

J_M=\frac 1N\sum^N_{n=1}\|x_n-\tilde x_n\|^2=\frac 1N \sum^N_{n=1}\Vert\sum_{j=M+1}^D(b_j^\top x_n)b_j\|^2

我们将平方范数展开，并结合是来源于规范正交基，可以得到下式：

J_M=\frac 1N \sum^N_{n=1}\sum^D_{j=M+1}(b_j^\top x_n)^2=\frac {1}{N}\sum^N_{n=1}\sum_{j=M+1}^D b_j^\top x_nb^\top_j x_n=\frac 1N \sum^N_{n=1}\sum^D_{j=M+1}b_j^\top x_n x_n^\top b_j> 

补充推导过程

由于点乘的对称性，我们可以知道,带入上式：

\begin{aligned}
J_{M} &=\sum_{j=M+1}^{D} \boldsymbol{b}_{j}^{\top} \underbrace{\left(\frac{1}{N} \sum_{n=1}^{N} \boldsymbol{x}_{n} \boldsymbol{x}_{n}^{\top}\right)}_{=: \boldsymbol{S}} \boldsymbol{b}_{j}=\sum_{j=M+1}^{D} \boldsymbol{b}_{j}^{\top} \boldsymbol{S} \boldsymbol{b}_{j} \\
&=\sum_{j=M+1}^{D} \operatorname{tr}\left(\boldsymbol{b}_{j}^{\top} \boldsymbol{S} \boldsymbol{b}_{j}\right)=\sum_{j=M+1}^{D} \operatorname{tr}\left(\boldsymbol{S} \boldsymbol{b}_{j} \boldsymbol{b}_{j}^{\top}\right)=\operatorname{tr}(\underbrace{\left(\sum_{j=M+1}^{D} \boldsymbol{b}_{j} \boldsymbol{b}_{j}^{\top}\right)}_{\text {projection matrix }} \boldsymbol{S})
\end{aligned}

由上可知，损失函数可以被理解为源数据在主子空间的正交补上的方差。这也对应这主成分分析是在最小化我们忽略的维度上的误差。等价的来说也就是我们需要保留方差最大的那几个维度。所以当我们投影到M维主子空间的时候，所对应的重构误差为：

J_M=\sum^D_{j=M+1}\lambda_j> 

为什么是这个？

其中的数据协方差的奇异值。所以想要最小化这个重构误差，就需要选择个最小的特征值，这些特征值对应的是主子空间的正交基的特征向量。这也就是说，主子空间所对应的特征向量的特征值是协方差矩阵中的最大的M个特征值。

> 

这一节有很多问题，待补充。。。

# [](#%E7%89%B9%E5%BE%81%E5%90%91%E9%87%8F%E8%AE%A1%E7%AE%97%E4%BB%A5%E5%8F%8A%E4%BD%8E%E7%A7%A9%E9%80%BC%E8%BF%91%EF%BC%88Eigenvector-Computation-and-Low-Rank-Approximations%EF%BC%89)特征向量计算以及低秩逼近（Eigenvector Computation and Low-Rank Approximations）

为了计算方差矩阵的特征值，我们可以采用特征值分解或者是奇异值分解，前者可以直接计算出矩阵的特征值和特征向量。而使用SVD的可行性，是因为方差矩阵是对称并且能够分解为所以，方差矩阵的特征值就是的奇异值的平方。

S=\frac 1N \sum^N_{n=1}x_nx_n^\top  = \frac 1N XX^\top,\quad X=[x_1,\cdots , x_N]\in \mathbb R^{D\times N}

矩阵对应的SVD为：

\underbrace X_{D\times N}=\underbrace U_{D\times D}\underbrace\Sigma_{D\times N}\underbrace {V^\top}_{N\times N}

其中U和V都是正交矩阵，为对角矩阵，主对角线上的元素为奇异值.将这个式子带入到方差矩阵中：

S=\frac 1N XX^\top=\frac 1NU\Sigma\underbrace{V^\top V}_{=I_N}\Sigma^\top U^\top=\frac 1N U\Sigma\Sigma^\top U^\top> 

SVD分解之后的两端的矩阵是酉矩阵（）：
Specifically, the singular value decomposition of an m\times n complex matrix M is a factorization of the form , where U is an  complex unitary matrix,  is an  rectangular diagonal matrix with non-negative real numbers on the diagonal, and V is an  complex unitary matrix(酉矩阵).

所以U的列向量是的特征向量，也是方差矩阵的特征向量。其中特征值与奇异值的关系为：

\lambda_d=\frac{\sigma^2_d}{N}

S的特征值和X的奇异值的关系对应的是原先的最大方差视角和奇异值分解之间的关系。

> 

如何理解？

## [](#%E7%94%A8%E4%BD%8E%E7%A7%A9%E9%80%BC%E8%BF%91%E7%9A%84PCA-PCA-Using-Low-Rank-Matrix-Approximations)用低秩逼近的PCA(PCA Using Low-Rank Matrix Approximations)

PCA需要找出前N个最大特征值所对应的特征向量，实现这个目标可以采用低秩逼近的方式。

> 

Eckart-Young theorem:就是评估低秩逼近之后造成的损失
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210626104053635.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

由Eckart-Young theorem：

\tilde X_M:=\operatorname{argmin}_{\operatorname{rk(A)\le M}}\|X-A\|_2\in \mathbb R^{D\times N}

所以，对应的低秩逼近就是找出前M大的奇异值：

\tilde X_M=\underbrace {U_M}_{D\times M}\underbrace{\Sigma_M}_{M\times M}\underbrace{V_M^\top}_{M\times N}\in \mathbb R^{D\times N}

其中，包含X的前M个最大的奇异值。

## [](#%E5%AE%9E%E9%99%85%E6%96%B9%E9%9D%A2%EF%BC%88Practical-Aspects%EF%BC%89)实际方面（Practical Aspects）

我们可以直接采用特征多项式求解出特征值和特征多项式，但是由Abel-Ruffini theorem，五阶或者五阶以上的多项式方程没有几何解。所以在解决大于的矩阵的时候会遇到这个问题。
由于在主成分分析中，我们会只需要前M大的特征向量和特征多项式，所以计算出所有的特征向量和特征值然后再舍弃一些特征值是很没有必要的。在一些极端的情况下，我们只需要第一个特征向量，这时候使用**幂迭代**（Power iteration）效率会非常高。

> 

**幂迭代**
首先先随机选取一个不在S的零空间的向量,然后按照下式进行迭代：

x_{k+1}=\frac{Sx_k}{\|Sx_k\|},\quad k=0,1,\cdots

这个式子总是有,最终这个式子会收敛于最大的特征值所对应的特征向量。当S为不可逆的时候，应该保证

In mathematics, power iteration (also known as the power method) is an eigenvalue algorithm: given a diagonalizable matrix A, the algorithm will produce a number \lambda , which is the greatest (in absolute value) eigenvalue of A, and a nonzero vector v, which is a corresponding eigenvector of  , that is, . The algorithm is also known as the Von Mises iteration.

Power iteration is a very simple algorithm, but it may converge slowly. The most time-consuming operation of the algorithm is the multiplication of matrix A by a vector, so it is effective for a very large sparse matrix with appropriate implementation.

# [](#%E9%AB%98%E7%BB%B4PCA%EF%BC%88PCA-in-High-Dimensions%EF%BC%89)高维PCA（PCA in High Dimensions）

想要对数据使用PCA，需要求解出数据的协方差矩阵，对于一个D维的数据，如果使用特征多项式（）的时间复杂度为.所以需要找到一种更加高效的方法解决这个问题。
下面我们讨论数据的个数远小于数据维度的情况，即
假设一组中心化（均值为0）的数据集，对应的协方差矩阵为：

S=\frac 1N XX^\top\in\mathbb R^{D\times D},\quad X=[x_1,\cdots,x_N]\in\mathbb R^{D\times N}

由于我们假设所以数据点的数量远小于数据的维度，也就是说数据的秩为N，则有个特征值为0，接下来我们探究将D维协方差矩阵转换成N维，且对应的特征值都是正数。所以有特征向量的等式：

Sb_m=\lambda_m b_m,\quad m=1,\cdots M

其中b是主子空间的基向量，现在将S的定义带入：

Sb_m =\frac 1N XX^\top b_m=\lambda_m b_m

现在等式两边同时乘以

\frac 1N \underbrace {X^\top X}_{N\times N}\underbrace{X^\top b_m}_{=:c_m}=\lambda_m X^\top b_m\Leftrightarrow\frac 1N X^\top Xc_m=\lambda_mc_m

所以可以发现协方差矩阵的特征值为对应的特征向量为

> 

印证原先提到的：的非零特征值等于的非零特征值

现在我们得到了映射之后的特征值和特征向量，现在我们需要找到源数据的特征值和特征向量。现在对上式两边同时左乘：

\underbrace{\frac 1NXX^\top}_SXc_m=\lambda_mXc_m

这样我们得到了源数据(X是酉矩阵？)，这仍旧是S的特征向量。

# [](#PCA%E5%9C%A8%E5%AE%9E%E8%B7%B5%E4%B8%AD%E7%9A%84%E5%85%B3%E9%94%AE%E6%AD%A5%E9%AA%A4-Key-Steps-of-PCA-in-Practice)PCA在实践中的关键步骤(Key Steps of PCA in Practice)

2
3
4
5
6
7
8
9
10

# [](#%E7%94%A8%E6%BD%9C%E5%8F%98%E9%87%8F%E7%9C%8B%E5%BE%85PCA-Latent-Variable-Perspective)用潜变量看待PCA(Latent Variable Perspective)

原先讨论PCA的时候没有使用概率方面的理论，这样能够帮助我们避开一些由概率论引起的数学上的困难，但是用概率论的能够帮助我们更好地理解PCA，而且在处理带有噪音的数据的时候，概率论中的似然函数提供了分析方式。

> 

Observational Noise. The error between the true value in a system and its observed value due to imprecision in measurement. Also called Measurement Noise.
**观测噪音**（Observation Noise）实际上就是我们所说的测量误差，由仪器等因素导致的于真实值的偏差。

通过介绍连续的潜变量, 我们能够将PCA用**概率潜变量模型**(probabilistic latent-variable model)来描述，这被称为**概率主成分分析**（probabilistic PCA ， PPCA）

## [](#%E7%94%9F%E6%88%90%E8%BF%87%E7%A8%8B%E5%8F%8A%E6%A6%82%E7%8E%87%E6%A8%A1%E5%9E%8B%EF%BC%88Generative-Process-and-Probabilistic-Model%EF%BC%89)生成过程及概率模型（Generative Process and Probabilistic Model）

我们考虑一个线性降维，对于一个连续随机变量以及一个标准正态先验, 潜变量以及观测值之间的关系为：

x=Bz+\mu+\epsilon\in \mathbb R^D

其中为高斯观测噪音，而是潜变量到观测变量的线性/仿射映射。所以，潜变量于观测值之间的联系方式为：

p(x|z,B,\mu,\sigma^2)=\mathcal N(x|Bz+\mu, \sigma^2I)

整体来说，PPCA的生成过程为：

\begin{aligned} z&\sim \mathcal N(z|0,I)\\ x_n|z_n&\sim\mathcal N(x|Bz_n+\mu,\sigma^2I)\end{aligned}

想要得到获得这些参数，需要一些典型数据，想要得到这样的数据可以使用**祖先抽样**（Ancestral sampling）

> 

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210701100758830.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)
Ancestral sampling 实际上就是通过采样解决条件概率问题。

在这里，先采样得到潜变量,然后再从潜变量中采样得到预测数据。于是，上面的生辰过程可以写成:

p(x,z|B,\mu,\sigma^2)=p(x|z,B,\mu,\sigma^2)p(x)

对应的图模型：

> 

Graphical model for probabilistic PCA. The observations  explicitly depend on corresponding latent variables  The model parameters  and the likelihood parameter  are shared across the dataset.
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210701101627104.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)
可以将潜变量用于生成新的数据（补充理解）
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210701101827655.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

## [](#%E4%BC%BC%E7%84%B6%E4%BB%A5%E5%8F%8A%E8%81%94%E5%90%88%E5%88%86%E5%B8%83%EF%BC%88Likelihood-and-Joint-Distribution%EF%BC%89)似然以及联合分布（Likelihood and Joint Distribution）

由原先的概率论部分，我们知道可以采用积分将潜变量消掉：

p(x|B,\mu,\sigma^2)=\int p(x|z,B,\mu,\sigma^2)p(z)dz=\int \mathcal N(x|Bz+\mu,\sigma^2I)\mathcal N(z|0,I)dz

还是由原先的知识，我们可以知道这个积分的结果是高斯分布，其均值及方差为：

\begin{aligned}\mathbb E_x[x]&=\mathbb E_z[Bz+\mu]+\mathbb E_\epsilon[\epsilon]=\mu \\ \mathbb V[x]&=\mathbb V_z[Bz+\mu]+\mathbb V_\epsilon[\epsilon]=\mathbb V_z[Bz]+\sigma^2I\\&=B\mathbb V_z[z]B^\top+\sigma^2I=BB^\top+\sigma^2I\end{aligned}

先前我们不适用条件概率分布的原因是极大似然估计以及极大似然后验估计需要的似然函数可以是数据以及模型参数的函数，但是不能是潜变量的函数，这里是用积分消去潜变量之后才用的。

**潜变量以及模型参数的关系**（需要补充）

因为潜变量的线性/仿射变换是联合高斯分布，现在已知一些边际概率分布:.所以对应**交叉协方差**（cross-covariance）为：

\operatorname{Cov}[x,z]=\operatorname{Cov}_z[Bz+\mu]=B\operatorname{Cov}_z[z,z]=B

所以潜变量以及观测到的随机变量之间的联合分布为：

p\left(\boldsymbol{x}, \boldsymbol{z} \mid \boldsymbol{B}, \boldsymbol{\mu}, \sigma^{2}\right)=\mathcal{N}\left(\left[\begin{array}{l}
\boldsymbol{x} \\
\boldsymbol{z}
\end{array}\right] \mid\left[\begin{array}{l}
\boldsymbol{\mu} \\
\mathbf{0}
\end{array}\right],\left[\begin{array}{cc}
\boldsymbol{B} \boldsymbol{B}^{\top}+\sigma^{2} \boldsymbol{I} & \boldsymbol{B} \\
\boldsymbol{B}^{\top} & \boldsymbol{I}
\end{array}\right]\right)

其中均值向量的长度为,协方差矩阵的大小为

## [](#%E5%90%8E%E9%AA%8C%E5%88%86%E5%B8%83%EF%BC%88Posterior-Distibution%EF%BC%89)后验分布（Posterior Distibution）

由前面提到的联合概率分布可以求得后验分布(参数求解方式在概率论那一章有提及)

\begin{aligned}
p(\boldsymbol{z} \mid \boldsymbol{x}) &=\mathcal{N}(\boldsymbol{z} \mid \boldsymbol{m}, \boldsymbol{C}) \\
\boldsymbol{m} &=\boldsymbol{B}^{\top}\left(\boldsymbol{B} \boldsymbol{B}^{\top}+\sigma^{2} \boldsymbol{I}\right)^{-1}(\boldsymbol{x}-\boldsymbol{\mu}) \\
\boldsymbol{C} &=\boldsymbol{I}-\boldsymbol{B}^{\top}\left(\boldsymbol{B} \boldsymbol{B}^{\top}+\sigma^{2} \boldsymbol{I}\right)^{-1} \boldsymbol{B}
\end{aligned}

注意后验协方差与数据无关，协方差矩阵C告诉我们（？）嵌入的可信度（？p343）
我们可以利用这个后验分布得到数据对应的潜变量，然后再利用潜变量得到重构向量$\tilde x_*\sim p(x|z_*,B,\mu,\sigma^2)$.将这个过程重复多次，我们能够得到潜变量的后验分布以及其暗含的观测数据

# [](#%E6%8B%93%E5%B1%95%E9%98%85%E8%AF%BB)拓展阅读

现在我们想想之前做了什么。我们使用两个角度看待PCA，一个是投影的角度（最小化重构误差），一个是最大化方差的角度，除此之外还有其他的角度。我们先将高维数据用矩阵转换成用低维表示的数据,其中B由协方差矩阵的最大的特征值所对应的特征向量组成。得到低阶矩阵之后，我们可以利用投影矩阵将数据复原到源数据的维度:.
当然我们还将PCA看成一个**线性自动编码机**(Linear Auto-encoder)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210702083437356.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)
由此可以得到重构误差：

\frac 1N \sum^N_{n=1}\|x_n-\tilde x_n\|^2=\frac 1N\sum^N_{n=1}\|x_n-BB^\top x_n\|

如果我们将线性映射转换成非线性映射，我们就会得到非线性自动编码机。当编码器是神经网络的时候，这个被称为**认知网络或推理网络**（recognition network or inference network），编码器称为**生成器**(Generator)。
还有一种对PCA的理解涉及到**信息论**（information theory），就是将编码当成原始数据的压缩版本。当我们将压缩的信息还原，这并不能得到与原始一摸一样的数据，我们称这个压缩过程为有损失的。所以我们的目标就是尽可能将原始数据与压缩数据之间的相关性最大化。这种关系称为**交互信息**（the mutual information）。
在讨论PPCA的时候，我们默认模型的参数（,似然参数）都是已知的，这些参数为：（我们将维数据投影到维子空间中）

\begin{aligned}\mu_{Ml} &=\frac 1N \sum^N_{n=1}x_n\\ B_{ML}&=T(\Lambda-\sigma^2I)^{\frac 12}R\\ \sigma^2_{ML}&=\frac{1}{D-M}\sum^D_{j=M+1}\lambda_j\end{aligned}

其中，包含协方差矩阵的M个特征向量，是一个对角矩阵，包含主子空间所对应的特征向量所对应的特征值。是一个随意的正交矩阵。是极大似然的解。是主子空间的正交补上的平均方差，可以认为是正交映射之后造成的损失。
当处理一个无噪音的数据的时候，也就是,这时候PPCA与PCA得到的结构是一致的。由于协方差矩阵是对称的，所以可以被正交化，所以存在一个矩阵T包含S的特征向量：

S=T\Lambda T^{-1}

数据的协方差矩阵就是高斯似然函数（）的协方差矩阵,也就是。当时，两种PCA的数据方差相等，所以有：

\operatorname{Cov}[\mathcal X]=T\Lambda T^{-1}=BB^\top\Leftrightarrow B=T\Lambda^{\frac 12}R

所以实际上，这些PCA都是在对数据的协方差矩阵进行分解。

> 

接触下来的内容难度较大，理解不够透彻，后续补充

2
3
4
5
6
7
8