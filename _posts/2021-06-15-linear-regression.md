---
layout: post
title: "机器学习中的数学：线性回归Linear Regression"
date: 2021-06-15 01:12:40 +0000
categories: [blog]
tags: []
---

@[toc]
回归的目的就是找到一个函数,将输入的数据映射成.数据的观测噪音为：,其中是一个独立均匀分布的随机变量，描述数据噪音。

> 

噪音理解成预测值与观测值的偏差，准不准确？

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210527102646532.png?x-oss-process=image,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

# [](#%E9%97%AE%E9%A2%98%E6%8F%8F%E8%BF%B0%EF%BC%88Problem-Formulation%EF%BC%89)问题描述（Problem Formulation）

因为观测噪音的缘故，我们使用概率模型，并且用一个似然函数对噪音进行建模。具体来说，我们考虑以下回归问题的的似然函数：

p(y|\boldsymbol x)=\mathcal N(y|f(\boldsymbol x),\sigma^2)

其中，是输入值,为噪音函数值（目标）
与之间的关系为：

y= f(\boldsymbol x)+\epsilon

其中，是一个独立均匀的高斯分布。

> 

Our objective is to find a function that is close (similar) to the unknown function  that generated the data and that generalizes well.

假设在线性模型的条件下：

p(y|\boldsymbol x,\boldsymbol \theta)=\mathcal N(y|\boldsymbol x^\top\boldsymbol\theta,\sigma^2)\Leftrightarrow y=\boldsymbol x^\top\boldsymbol\theta+\epsilon,\quad \epsilon \sim \mathcal N(0,\sigma^2)

Why?
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210527104841262.png)

这里说明一下线性模型的意思，线性代表的是输入数据的线性组合，所以对于,即使是非线性函数，这个模型也是线性模型。

# [](#%E5%8F%82%E6%95%B0%E4%BC%B0%E8%AE%A1%EF%BC%88Parameter-Estimation%EF%BC%89)参数估计（Parameter Estimation）

给定一个训练集,包含个输入和观测值.
用概率图模型（Probabilistic graphical model）可以表示为：

又因为每一个样本又是相互独立的，所以可以将似然方程进行分解：

p(\mathcal Y|\mathcal X,\boldsymbol\theta)=p(y_1,\cdots,y_N|\boldsymbol x_1,\cdots,\boldsymbol x_N,\boldsymbol\theta)=\prod^N_{n=1}p(y_n|\boldsymbol x_n,\boldsymbol\theta) = \prod^N_{n=1}\mathcal N(y_n|\boldsymbol x_n^\top\boldsymbol\theta,\sigma^2)

接下来详细介绍获取最优化参数的方法。

## [](#%E6%9E%81%E5%A4%A7%E4%BC%BC%E7%84%B6%E4%BC%B0%E8%AE%A1%EF%BC%88Maximum-Likelihood-Estimation%EF%BC%89)极大似然估计（Maximum Likelihood Estimation）

我们可以通过极大似然估计得到参数：

\boldsymbol \theta_{ML}=\arg \max_\theta p(\mathcal Y|\mathcal X,\boldsymbol\theta)

上面的似然概率不是参数的分布，而是函数。极大似然估计的目的就是最大化训练数据的概率分布。
在实际过程中，我们常常采用似然对数转换（Log-Transformation）的方式，将问题转化成最小化负对数似然：

-\log p(\mathcal Y|\mathcal X,\boldsymbol\theta)=-\log \prod_{n=1}^N p(y_n|\boldsymbol x_n,\boldsymbol\theta)=-\sum^N_{n=1}\log p(y_n|\boldsymbol x_n,\boldsymbol\theta)

这样做可以将原先的乘积转换成和，

> 

**What does this suppose means?**
More specifically, numerical underflow will be a problem when we multiply N probabilities, where N is the number of data points, since we cannot represent very small numbers, such as .

由于在线性规划中，似然概率分布满足高斯分布（噪音项满足高斯分布），所以可以得到：

> 

?？需要补充
Note that:

p(y|x,\theta)=\mathcal N(y|x^\top\theta,\sigma^2)=\frac{1}{\sqrt{2\pi \sigma^2}}e^{-\frac{(y-x^\top)^2}{2\sigma^2}}

\log p(y_n|\boldsymbol x_n,\boldsymbol\theta)=-\frac{1}{2\sigma^2}(y_n-\boldsymbol x_n^\top\boldsymbol\theta)^2+\operatorname {const}

于是得到损失函数：

\begin{aligned}
\mathcal{L}(\boldsymbol{\theta}) &:=\frac{1}{2 \sigma^{2}} \sum_{n=1}^{N}\left(y_{n}-\boldsymbol{x}_{n}^{\top} \boldsymbol{\theta}\right)^{2} \\
&=\frac{1}{2 \sigma^{2}}(\boldsymbol{y}-\boldsymbol{X} \boldsymbol{\theta})^{\top}(\boldsymbol{y}-\boldsymbol{X} \boldsymbol{\theta})=\frac{1}{2 \sigma^{2}}\|\boldsymbol{y}-\boldsymbol{X} \boldsymbol{\theta}\|^{2}
\end{aligned}

我们将定义为**设计矩阵**（Design Matrix）
可以通过求导求解损失函数的最小值：

\begin{aligned}
\frac{\mathrm{d} \mathcal{L}}{\mathrm{d} \boldsymbol{\theta}} &=\frac{\mathrm{d}}{\mathrm{d} \boldsymbol{\theta}}\left(\frac{1}{2 \sigma^{2}}(\boldsymbol{y}-\boldsymbol{X} \boldsymbol{\theta})^{\top}(\boldsymbol{y}-\boldsymbol{X} \boldsymbol{\theta})\right) \\
&=\frac{1}{2 \sigma^{2}} \frac{\mathrm{d}}{\mathrm{d} \boldsymbol{\theta}}\left(\boldsymbol{y}^{\top} \boldsymbol{y}-2 \boldsymbol{y}^{\top} \boldsymbol{X} \boldsymbol{\theta}+\boldsymbol{\theta}^{\top} \boldsymbol{X}^{\top} \boldsymbol{X} \boldsymbol{\theta}\right) \\
&=\frac{1}{\sigma^{2}}\left(-\boldsymbol{y}^{\top} \boldsymbol{X}+\boldsymbol{\theta}^{\top} \boldsymbol{X}^{\top} \boldsymbol{X}\right) \in \mathbb{R}^{1 \times D}
\end{aligned}

（）
令上式等于0：

\begin{aligned}
\frac{\mathrm{d} \mathcal{L}}{\mathrm{d} \boldsymbol{\theta}}=\mathbf{0}^{\top} {\longrightarrow} \boldsymbol{\theta}_{\mathrm{ML}}^{\top} \boldsymbol{X}^{\top} \boldsymbol{X}=\boldsymbol{y}^{\top} \boldsymbol{X} \\
 \Longleftrightarrow \boldsymbol{\theta}_{\mathrm{ML}}^{\top}=\boldsymbol{y}^{\top} \boldsymbol{X}\left(\boldsymbol{X}^{\top} \boldsymbol{X}\right)^{-1} \\
 \Longleftrightarrow \boldsymbol{\theta}_{\mathrm{ML}}=\left(\boldsymbol{X}^{\top} \boldsymbol{X}\right)^{-1} \boldsymbol{X}^{\top} \boldsymbol{y} .
\end{aligned}

![在这里插入图片描述](https://img-blog.csdnimg.cn/2021052906543623.png)

> 

Normal equation is derived by MLE.——Ng

### [](#%E5%9F%BA%E4%BA%8E%E7%89%B9%E5%BE%81%E7%9A%84%E6%9E%81%E5%A4%A7%E4%BC%BC%E7%84%B6%E4%BC%B0%E8%AE%A1%EF%BC%88Maximum-Likelihood-Estimation-with-Features%EF%BC%89)基于特征的极大似然估计（Maximum Likelihood Estimation with Features）

当遇到更复杂的数据时，一次函数模型有时候很难很好地拟合数据，但是由于线性回归模型只是对”参数的线性”(“linear in the parameters”),所以可以在线性回归模型中对非线性模型进行拟合。这就是说我们可以先将输入值进行非线性变换之后，再放到线性模型中。
In Ng’s courses he said this is Linear regression with higher order features. We can alse use SVM to derive new features.

p(y|\boldsymbol x,\theta)=\mathcal N(y|\phi^\top(x)\boldsymbol\theta,\sigma^2)\Longleftrightarrow y=\phi^\top(x)\boldsymbol\theta+\epsilon=\sum^{K-1}_{k=0}\theta_k\phi_k(x)+\epsilon

其中，是一个对的（非）线性变换，是特征向量的第k个分量。

一个实例：
一种对输入数据常用的变换如下

\phi(x)=\left[\begin{array}{c}
\phi_{0}(x) \\
\phi_{1}(x) \\
\vdots \\
\phi_{K-1}(x)
\end{array}\right]=\left[\begin{array}{c}
1 \\
x \\
x^{2} \\
x^{3} \\
\vdots \\
x^{K-1}
\end{array}\right] \in \mathbb{R}^{K}

所以：

f(x)=\sum\limits^{K-1}_{k=0}\theta_kx^k=\phi^\top(x)\boldsymbol\theta

现在看看参数在线性回归模型下的极大似然估计：

\Phi:=\left[\begin{array}{c}
\phi^{\top}\left(x_{1}\right) \\
\vdots \\
\phi^{\top}\left(x_{N}\right)
\end{array}\right]=\left[\begin{array}{ccc}
\phi_{0}\left(x_{1}\right) & \cdots & \phi_{K-1}\left(x_{1}\right) \\
\phi_{0}\left(x_{2}\right) & \cdots & \phi_{K-1}\left(x_{2}\right) \\
\vdots & & \vdots \\
\phi_{0}\left(x_{N}\right) & \cdots & \phi_{K-1}\left(x_{N}\right)
\end{array}\right] \in \mathbb{R}^{N \times K}

where  and .
这个矩阵被称为**特征矩阵**（feature matrix）或**设计矩阵**(design matrix)
有了上面这个矩阵，我们可以将线性回归模型：

p(y|\boldsymbol x,\boldsymbol \theta)=\mathcal N(y|\boldsymbol x^\top\boldsymbol\theta,\sigma^2)\Leftrightarrow y=\boldsymbol x^\top\boldsymbol\theta+\epsilon,\quad \epsilon \sim \mathcal N(0,\sigma^2)> 

从这个式子中可以看出，预测值的结果主要分布于均值的周围

写成：

-\log p(\mathcal Y|\mathcal X,\boldsymbol\theta)=\frac{1}{2\sigma^2}(y-\Phi\boldsymbol\theta)^\top(y-\Phi\boldsymbol\theta)+\operatorname{const}

将两式子进行比较，发现二者只是将欢成了,所以直接利用模型的结论，得到的估计值：

\theta_{ML}=(\Phi^\top\Phi)^{-1}\Phi^\top y> 

需要讨论的可逆性
这个是不是支持向量机中的多项式核函数？

(x_1\times x_2 + r)^d

其中，r为多项式的参数，d为多项式的次数，、为观测值

### [](#%E5%99%AA%E5%A3%B0%E6%96%B9%E5%B7%AE%EF%BC%88Estimating-the-Noise-Variance%EF%BC%89)噪声方差（Estimating the Noise Variance）

我们之前的讨论都是假定是已知的，但是实际上可以利用极大似然估计的方式对噪声方差进行估计，所有的步骤与之前一致：
将带入到似然函数中：

\begin{array}{l}
\log p\left(\mathcal{Y} \mid \mathcal{X}, \boldsymbol{\theta}, \sigma^{2}\right)=\sum\limits_{n=1}^{N} \log \mathcal{N}\left(y_{n} \mid \phi^{\top}\left(\boldsymbol{x}_{n}\right) \boldsymbol{\theta}, \sigma^{2}\right) \\
=\sum\limits_{n=1}^{N}\left(-\frac{1}{2} \log (2 \pi)-\frac{1}{2} \log \sigma^{2}-\frac{1}{2 \sigma^{2}}\left(y_{n}-\phi^{\top}\left(\boldsymbol{x}_{n}\right) \boldsymbol{\theta}\right)^{2}\right) \\
=-\frac{N}{2} \log \sigma^{2}-\frac{1}{2 \sigma^{2}} \underbrace{\sum_{n=1}^{N}\left(y_{n}-\boldsymbol{\phi}^{\top}\left(\boldsymbol{x}_{n}\right) \boldsymbol{\theta}\right)^{2}}_{=: s}+\text { const. }
\end{array}

对求偏导：

\begin{aligned}
& \frac{\partial \log p\left(\mathcal{Y} \mid \mathcal{X}, \boldsymbol{\theta}, \sigma^{2}\right)}{\partial \sigma^{2}}=-\frac{N}{2 \sigma^{2}}+\frac{1}{2 \sigma^{4}} s=0 \\
\Longleftrightarrow & \frac{N}{2 \sigma^{2}}=\frac{s}{2 \sigma^{4}}
\end{aligned}

所以得到的极大似然估计的结果为：

\sigma^2=\frac{s}{N}=\frac{1}{N}\sum^N_{n-1}(y_n-\phi^\top(\boldsymbol x_n)\theta)^2> 

the maximum likelihood estimate of the noise variance is **the empirical mean of the squared distances** between the noise-free function values and the corresponding noisy observations  at input locations .

## [](#%E7%BA%BF%E6%80%A7%E5%9B%9E%E5%BD%92%E4%B8%AD%E7%9A%84%E8%BF%87%E6%8B%9F%E5%90%88%EF%BC%88Overfitting-in-Linear-Regression%EF%BC%89)线性回归中的过拟合（Overfitting in Linear Regression）

我们可以使用均方根误差（root mean square error，RMSE）来衡量一个模型的好坏：

\sqrt{\frac{1}{N}\|y-\Phi\boldsymbol\theta\|^2}=\sqrt{\frac{1}{N}\sum^N_{n=1}(y_n-\phi^\top(x_n)\boldsymbol\theta)^2}

噪声参数不是一个自由模型参数，所以没有直接加到上式，所以没有包含到上面，这样做的好处就是能够使得计算前后的量纲保持一致。
当多项式的次数小于训练样本数量的时候，可以得到一个唯一的极大似然估计值，当大于的时候，需要求解一个欠定方程组（有无穷多解的方程组），这样得到无穷多的估计值。
采用不同级别的多项式模型拟合10个数据的结果如下图：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210529085722190.png?x-oss-process=image,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)
各个模型的均方根误差：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210529085737340.png?x-oss-process=image,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)
注意一点，训练集的RMSE不会增加。

## [](#%E6%9E%81%E5%A4%A7%E5%90%8E%E9%AA%8C%E4%BC%B0%E8%AE%A1%EF%BC%88Maximum-A-Posteriori-Estimation%EF%BC%89)极大后验估计（Maximum A Posteriori Estimation）

当出现过拟合的时候，参数的数值会变得很大，为了解决这个问题，我们可以使用先验分布。这个先验分布标明了参数值在什么范围内是合理的。例如一个高斯先验,这个信息中暗示了参数的范围应该在之间（）.当数据集可用的时候，我们需要去找能够最大化后验分布的参数值,这个过程称为**极大后验估计**（Maximum a Posteriori Estimation,MAP）,后验分布可以利用贝叶斯公式求解：

p(\theta|\mathcal X,\mathcal Y)=\frac{p(\mathcal Y|\mathcal X, \theta)p(\theta)}{p(\mathcal Y|\mathcal X)}> 

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210606102552583.png?x-oss-process=image,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

要求出参数向量,我们需要遵循与极大似然估计一致的方法，首先，先自然对数转换（log-transform）：

\log p(\theta|\mathcal X,\mathcal Y)=\log p(\mathcal Y|\mathcal X,\theta)+\log p(\theta)+\operatorname{const}

其中，中包含独立于的项。可以看到，后验似然估计是参数先验（在输入数据之前的对参数的认知）和依赖于数据的似然之间的折中。
要求的参数向量，我们要：

\theta_{MAP}\in\arg \min_\theta\{-\log p(\mathcal Y|\mathcal X,\theta)-\log p(\theta)\}

将负对数后验对进行求导：

-\frac{\mathrm{d} \log p(\boldsymbol{\theta} \mid \mathcal{X}, \mathcal{Y})}{\mathrm{d} \boldsymbol{\theta}}=-\frac{\mathrm{d} \log p(\mathcal{Y} \mid \mathcal{X}, \boldsymbol{\theta})}{\mathrm{d} \theta}-\frac{\mathrm{d} \log p(\boldsymbol{\theta})}{\mathrm{d} \theta}> 

第一项是之前提到的负自然对数似然的梯度：

\begin{aligned}
\frac{\mathrm{d} \mathcal{L}}{\mathrm{d} \theta} &=\frac{\mathrm{d}}{\mathrm{d} \theta}\left(\frac{1}{2 \sigma^{2}}(y-X \theta)^{\top}(y-X \theta)\right) \\
&=\frac{1}{2 \sigma^{2}} \frac{\mathrm{d}}{\mathrm{d} \theta}\left(y^{\top} y-2 y^{\top} X \theta+\theta^{\top} \boldsymbol{X}^{\top} \boldsymbol{X} \theta\right) \\
&=\frac{1}{\sigma^{2}}\left(-\boldsymbol{y}^{\top} \boldsymbol{X}+\boldsymbol{\theta}^{\top} \boldsymbol{X}^{\top} \boldsymbol{X}\right) \in \mathbb{R}^{1 \times D}
\end{aligned}

利用参数的一个（共轭）高斯先验:

-\log p(\theta \mid \mathcal{X}, \mathcal{Y})=\frac{1}{2 \sigma^{2}}(y-\Phi \theta)^{\top}(y-\Phi \theta)+\frac{1}{2 b^{2}} \theta^{\top} \theta+\text { const }> 

这里有点疑问，利用了

p(y|\boldsymbol x,\theta)=\mathcal N(y|\phi^\top(x)\boldsymbol\theta,\sigma^2)\Longleftrightarrow y=\phi^\top(x)\boldsymbol\theta+\epsilon=\sum^{K-1}_{k=0}\theta_k\phi_k(x)+\epsilon

？？

上式右边的第一个式子来源于自然对数似然，第二个式子来源于自然对数先验。所以自然对数先验对的先验为：

-\frac{d\log p(\theta|\mathcal X,\mathcal Y)}{d\theta}=\frac{1}{\sigma^2}(\theta^\top\Phi^\top\Phi-y^\top\Phi)+\frac{1}{b^2}\theta^\top

将梯度设置为0：

\begin{aligned}
& \frac{1}{\sigma^{2}}\left(\theta^{\top} \Phi^{\top} \Phi-y^{\top} \Phi\right)+\frac{1}{b^{2}} \theta^{\top}=0^{\top} \\
\Longleftrightarrow & \theta^{\top}\left(\frac{1}{\sigma^{2}} \Phi^{\top} \Phi+\frac{1}{b^{2}} I\right)-\frac{1}{\sigma^{2}} y^{\top} \Phi=0^{\top} \\
\Longleftrightarrow & \theta^{\top}\left(\Phi^{\top} \Phi+\frac{\sigma^{2}}{b^{2}} I\right)=y^{\top} \Phi \\
\Longleftrightarrow & \theta^{\top}=y^{\top} \Phi\left(\Phi^{\top} \Phi+\frac{\sigma^{2}}{b^{2}} I\right)^{-1}
\end{aligned}

整理得：

\theta_{MAP}=(\Phi^\top\Phi+\frac{\sigma^2}{b^2}I)^{-1}\Phi^\top y

与极大似然估计的结果：相比较，只是在逆当中多了一项，这一项保证了是一个对称严格正定的。也就是说这个矩阵是可逆的，而且是线性方程的唯一解。同时他也反应了**正则项**(regularizer)的影响的大小

> 

虽然先验能够让高次多项式变得更加光滑，但也是仅仅将过拟合的边界向后推移了，想要解决过拟合的问题需要其他的方法。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210529160218756.png?x-oss-process=image,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

### [](#%E6%9E%81%E5%A4%A7%E5%90%8E%E9%AA%8C%E4%BC%B0%E8%AE%A1%E4%BD%9C%E4%B8%BA%E6%AD%A3%E5%88%99%E5%8C%96)极大后验估计作为正则化

带正则项的最小二乘的损失函数为：

\|\boldsymbol y-\boldsymbol\Phi\boldsymbol\theta\|^2+\lambda\|\boldsymbol\theta\|_2^2

这里的范数采用的是-范数,当的值越小，得到的结果中的个数就越多。当时，被称为**最小绝对收缩和选择算子**（least absolute shrinkage and selection operator，LASSO）
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210608202819264.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

上式中的正则项可以理解为极大后验估计中的**高斯自然对数先验**（negative log-Gaussian prior），具体来说，对于一个正态分布的高斯自然对数先验为：

-\log p(\boldsymbol\theta)=\frac{1}{2b^2}\|\boldsymbol \theta\|^2_2+\operatorname{const}

这里的正则项为与极大后验估计的先验一致。这样看来，正则化后的最小二乘损失函数包含的项与负自然对数似然和负自然对数先验有紧密关系，所以最小化最小二乘损失函数的过程与极大后验估计一致.
最小化带正则项的最小二乘损失函数（regularized least-squares loss function）：

\boldsymbol\theta_{RLS}=(\boldsymbol\Phi^\top\boldsymbol\Phi+\lambda \boldsymbol I)^{-1}\boldsymbol\Phi^\top \boldsymbol y

这个与极大后验估计一致，这里的正则项为,其中，是噪声方差，为（各向同性）高斯先验方差
至此，我们讨论的都是点估计得到，以对目标函数进行优化。接下来我们讨论使用贝叶斯推断，通过获得所有合理的参数的均值得到优化结果。

# [](#%E8%B4%9D%E5%8F%B6%E6%96%AF%E7%BA%BF%E6%80%A7%E5%9B%9E%E5%BD%92%EF%BC%88Bayesian-Linear-Regression%EF%BC%89)贝叶斯线性回归（Bayesian Linear Regression）

先前讨论的是采用极大似然估计和极大后验估计来估计模型的参数，极大似然估计容易出现过拟合的现象，尤其是在训练集比较小的时候。极大后验估计使用一个概率先验来解决这个问题。而贝叶斯回归不求出单一的参数，而是选择求所有合理的参数的均值。

## [](#%E6%A8%A1%E5%9E%8B%EF%BC%88Model%EF%BC%89)模型（Model）
\begin{aligned}&prior \quad p(\boldsymbol\theta)=\mathcal N(\boldsymbol m_0,\boldsymbol S_0)\\ & likelihood\quad p(y|\boldsymbol x,\boldsymbol\theta)=\mathcal (y|\phi^\top(x)\boldsymbol\theta,\sigma)\end{aligned}

对应的图模型：

已观测变量与未观测变量的联合概率分布为：

p(y,\boldsymbol\theta|x)=p(y|\theta,x)p(\boldsymbol\theta)> 

推导过程

p(y,\theta|x)=\frac{p(y|\theta,x)p(\theta ,x)}{p(x)}=p(y|\theta,x)\cdot p(\theta|x)

所以x与是相互独立的？应该是与验证数据无关

## [](#%E9%A2%84%E6%B5%8B%E5%85%88%E9%AA%8C%EF%BC%88Prior-Predictions%EF%BC%89)预测先验（Prior Predictions）

预测的最终目的不是获得模型的参数，而是获得预测值，在贝叶斯回归中，预测值是所有合理参数的预测值的均值：

p(y_*|x_*)=\int p(y_*|\boldsymbol x_*,\boldsymbol\theta)p(\boldsymbol\theta)d\boldsymbol\theta=\mathbb E_\theta[p(y_*|\boldsymbol x_*,\boldsymbol\theta)]> 

连续概率分布的均值，样品值乘以样品出现的概率，将他们之和加起来，得到均值

我们选取一个的（共轭）高斯先验作为模型，于是可以知道预测结果也是高斯分布，对于一个先验分布,对应的预测结果的分布为：

p(y_*|\boldsymbol x_*)=\mathcal N(\boldsymbol\phi^\top(\boldsymbol x_*)\boldsymbol m_0,\phi^\top(\boldsymbol x_*)\boldsymbol S_0\phi(\boldsymbol x_*)+\sigma^2)

贝叶斯回归模型为：

p(\theta) =\mathcal N(m_0,S_0)\\ p(y|x,\theta)=\mathcal N(y|\phi^\top\theta,\sigma^2)

x与y的对应关系为：$y^*=\phi^\top(x^*)\theta所以对应的均值为：\phi^\top m_0由\mathbb V_Y[y]=\mathbb V_X[Ax+b]=\mathbb V_X[Ax]=A\mathbb V_X A^\top=A\Sigma A^\top的对应的方差为：\phi^\top(x_*)S_0\phi(x_*)$,加上噪声项即为上式

上式中的是由于测量误差导致的不确定分布。
这里预测值是高斯分布是因为高斯共轭和边际化的性质。由于高斯噪音是相互独立的，所以：

\mathbb V[y_*]=\mathbb V_\boldsymbol\theta[\phi^\top(x_*)\boldsymbol\theta]+\mathbb V_\epsilon[\epsilon]

如果我们考虑无噪音函数：$f(\boldsymbol x_*)=\phi^\top(x_*)\boldsymbol\theta$

p(f(x_*))=\mathcal N(\phi^\top(x_*)m_0,\phi^\top(x_*)S_0\phi(x_*))

这个式子与原先式子不同之处在于少了噪音项
**函数分布**（Distribution over Functions）：
我们可以用一系列的参数表示参数分布,而每一个参数对应一个函数于是可以得到对应函数的分布

> 

p305 没弄清楚
![在这里插入图片描述](https://img-blog.csdnimg.cn/2021053117070927.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

置信区间和置信边界

## [](#%E5%90%8E%E9%AA%8C%E5%88%86%E5%B8%83%EF%BC%88Posterior-Distribution%EF%BC%89)后验分布（Posterior Distribution）

利用贝叶斯公式可以计算参数的后验分布：

p(\theta|\mathcal X,\mathcal Y)=\frac{p(\mathcal Y|\mathcal X, \theta)p(\theta)}{p(\mathcal Y|\mathcal X)}

其中是训练的输入值，是训练目标。
其中的边际似然（marginal likelihood/evidence）与参数无关：

p(\mathcal Y|\mathcal X)=\int p(\mathcal Y|\mathcal X, \theta)p(\theta)d\theta=\mathbb E_\theta[p(\mathcal Y|\mathcal X,\theta)]

边际似然可以被看成是所有合理参数下预测值的均值。
**参数后验**：

\begin{aligned}p(\boldsymbol\theta|\mathcal X, \mathcal Y) & =\mathcal N(\boldsymbol\theta |\boldsymbol m_N,\boldsymbol S_N)\\ \boldsymbol S_N &=(\boldsymbol S_0^{-1}{+\sigma^{-2}}\Phi^\top\Phi)^{-1}\\\boldsymbol m_N&=\boldsymbol S_N(\boldsymbol S_0^{-1}\boldsymbol m_0+\sigma^{-2}\Phi^\top \boldsymbol y)\end{aligned}

其中的N代表的是训练集的大小。
**证明**：

> 

证明思路类似是用两种方式将参数后验表示出来，然后将对应部分的进行对比，得到想要的参数。

由贝叶斯公式可以得知，后验概率分布与似然概率分布和先验概率分布成比例

\begin{array}{ll}
\text { Posterior } & p(\boldsymbol{\theta} \mid \mathcal{X}, \mathcal{Y})=\frac{p(\mathcal{Y} \mid \mathcal{X}, \boldsymbol{\theta}) p(\boldsymbol{\theta})}{p(\mathcal{Y} \mid \mathcal{X})} \\
\text { Likelihood } & p(\mathcal{Y} \mid \mathcal{X}, \boldsymbol{\theta})=\mathcal{N}\left(\boldsymbol{y} \mid \boldsymbol{\Phi} \boldsymbol{\theta}, \sigma^{2} \boldsymbol{I}\right) \\
\text { Prior } & p(\boldsymbol{\theta})=\mathcal{N}\left(\boldsymbol{\theta} \mid \boldsymbol{m}_{0}, \boldsymbol{S}_{0}\right)
\end{array}

现在考虑自然对数先验与自然对数似然之和：

\begin{aligned}&\log \mathcal N(y|\Phi\theta,\sigma^2 I)+\log \mathcal N(\theta|m_0,S_0)\\&=-\frac{1}{2}(\sigma^{-2}(y-\Phi\theta)^\top(y-\Phi\theta)+(\theta-m_0)^\top S_0^{-1}(\theta-m_0))+\operatorname{const}\end{aligned}

其中的const包含一些独立于的项。
将上式进行展开：（将式子中的二次项一次项进行整合）

\begin{aligned}
&-\frac{1}{2}\left(\sigma^{-2} \boldsymbol{y}^{\top} \boldsymbol{y}-2 \sigma^{-2} \boldsymbol{y}^{\top} \Phi \theta+\boldsymbol{\theta}^{\top} \sigma^{-2} \boldsymbol{\Phi}^{\top} \boldsymbol{\Phi} \boldsymbol{\theta}+\boldsymbol{\theta}^{\top} \boldsymbol{S}_{0}^{-1} \boldsymbol{\theta}\right.\\
&\left.-2 m_{0}^{\top} S_{0}^{-1} \theta+\boldsymbol{m}_{0}^{\top} \boldsymbol{S}_{0}^{-1} \boldsymbol{m}_{0}\right) \\
=&-\frac{1}{2}\left(\boldsymbol{\theta}^{\top}\left(\sigma^{-2} \boldsymbol{\Phi}^{\top} \boldsymbol{\Phi}+\boldsymbol{S}_{0}^{-1}\right) \boldsymbol{\theta}-2\left(\sigma^{-2} \Phi^{\top} y+S_{0}^{-1} m_{0}\right)^{\top} \theta\right)+\mathrm{const}
\end{aligned}

我们可以发现上式与呈二次关系。

> 

The fact that the unnormalized log-posterior distribution is a (negative) quadratic form implies that the posterior is Gaussian

p(\theta|\mathcal X,\mathcal Y)=\exp(\log p(\theta|\mathcal X,\mathcal Y))\propto \exp(\log p(\mathcal Y|\mathcal X,\theta)+\log p(\theta))\\ \propto \exp(-\frac{1}{2}(\theta^\top(\sigma^{-2}\Phi^\top\Phi+S_0^{-1})\theta-2(\sigma^{-2}\Phi^\top y+S_0^{-1}m_0)^\top \theta))

最后需要从上式中找到均值和方差矩阵()：

\log \mathcal{N}\left(\boldsymbol{\theta} \mid \boldsymbol{m}_{N}, \boldsymbol{S}_{N}\right)=-\frac{1}{2}\left(\boldsymbol{\theta}-\boldsymbol{m}_{N}\right)^{\top} \boldsymbol{S}_{N}^{-1}\left(\boldsymbol{\theta}-\boldsymbol{m}_{N}\right)+ const\\=-\frac{1}{2}\left(\theta^{\top} S_{N}^{-1} \theta-2 m_{N}^{\top} S_{N}^{-1} \theta+\boldsymbol{m}_{N}^{\top} \boldsymbol{S}_{N}^{-1} \boldsymbol{m}_{N}\right)

通过比较上面二式可以得到：

\begin{array}{c}
S_{N}^{-1}=\Phi^{\top} \sigma^{-2} \boldsymbol{I} \Phi+S_{0}^{-1} \\
\Longleftrightarrow \boldsymbol{S}_{N}=\left(\sigma^{-2} \boldsymbol{\Phi}^{\top} \boldsymbol{\Phi}+\boldsymbol{S}_{0}^{-1}\right)^{-1} \\ \\
\boldsymbol{m}_{N}^{\top} \boldsymbol{S}_{N}^{-1}=\left(\sigma^{-2} \boldsymbol{\Phi}^{\top} \boldsymbol{y}+\boldsymbol{S}_{0}^{-1} \boldsymbol{m}_{0}\right)^{\top} \\
\Longleftrightarrow \boldsymbol{m}_{N}=\boldsymbol{S}_{N}\left(\sigma^{-2} \boldsymbol{\Phi}^{\top} \boldsymbol{y}+\boldsymbol{S}_{0}^{-1} \boldsymbol{m}_{0}\right)
\end{array}> 

**完全平方的一般方法**（General Approach to Completing the Squares）
对于一个等式(是一个堆成正定矩阵)：

x^\top A^\top x-2a^\top x+const_1

可以得到：

(x-\mu)^\top \Sigma(x-\mu)+const_2

其中，
**这部分需要补充**

## [](#%E5%90%8E%E9%AA%8C%E9%A2%84%E6%B5%8B%EF%BC%88Posterior-Predictions%EF%BC%89)后验预测（Posterior Predictions）

\begin{aligned}
p\left(y_{*} \mid \mathcal{X}, \mathcal{Y}, \boldsymbol{x}_{*}\right) &=\int p\left(y_{*} \mid \boldsymbol{x}_{*}, \boldsymbol{\theta}\right) p(\boldsymbol{\theta} \mid \mathcal{X}, \mathcal{Y}) \mathrm{d} \boldsymbol{\theta} \\
&=\int \mathcal{N}\left(y_{*} \mid \phi^{\top}\left(\boldsymbol{x}_{*}\right) \boldsymbol{\theta}, \sigma^{2}\right) \mathcal{N}\left(\boldsymbol{\theta} \mid \boldsymbol{m}_{N}, \boldsymbol{S}_{N}\right) \mathrm{d} \boldsymbol{\theta} \\
&=\mathcal{N}\left(y_{*} \mid \phi^{\top}\left(\boldsymbol{x}_{*}\right) \boldsymbol{m}_{N}, \boldsymbol{\phi}^{\top}\left(\boldsymbol{x}_{*}\right) \boldsymbol{S}_{N} \phi\left(\boldsymbol{x}_{*}\right)+\sigma^{2}\right)
\end{aligned}

右式中的第一个分布式利用训练得到的参数和输入值计算之后得到的结果的分布（$y^*=\phi(x^*)\theta）第二个分布是用训练集训练得到的参数\theta\phi^\top(x_*)S_N\phi(x_*)$表示关于后验的不确定性.
上式可以等价地写成

\mathbb E_{\theta|\mathcal X,\mathcal Y}[p(y_*|x_*,\theta)]> 

**分布方程**（Distribution over Functions）
当我们使用积分将参数消掉时，我们得到了一个分布函数：如果我们从中取样，我们可以得到方程。均值方程为所有预测值的期望,函数的方差为
从中对参数进行抽样,表示为第三张图：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210610124325373.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

**无噪音函数值的均值和方差**（Mean and Variance of Noise-Free Function Values）
在很多情况下，我们并不关心(含噪音的)预测值的分布$p(y_*|\mathcal X, \mathcal Y,x_*)。我们更关注于无噪音的函数值f(x_*)=\phi^\top(x_*)\theta$,可以得到该函数的均值和方差：

\begin{aligned}
\mathbb{E}\left[f\left(\boldsymbol{x}_{*}\right) \mid \mathcal{X}, \mathcal{Y}\right]=& \mathbb{E}_{\boldsymbol{\theta}}\left[\phi^{\top}\left(\boldsymbol{x}_{*}\right) \boldsymbol{\theta} \mid \mathcal{X}, \mathcal{Y}\right]=\phi^{\top}\left(\boldsymbol{x}_{*}\right) \mathbb{E}_{\boldsymbol{\theta}}[\boldsymbol{\theta} \mid \mathcal{X}, \mathcal{Y}] \\
&=\phi^{\top}\left(\boldsymbol{x}_{*}\right) \boldsymbol{m}_{N}=\boldsymbol{m}_{N}^{\top} \phi\left(\boldsymbol{x}_{*}\right), \\
\mathbb{V}_{\boldsymbol{\theta}}\left[f\left(\boldsymbol{x}_{*}\right) \mid \mathcal{X}, \mathcal{Y}\right] &=\mathbb{V}_{\boldsymbol{\theta}}\left[\phi^{\top}\left(\boldsymbol{x}_{*}\right) \boldsymbol{\theta} \mid \mathcal{X}, \mathcal{Y}\right] \\
&=\phi^{\top}\left(\boldsymbol{x}_{*}\right) \mathbb{V}_{\boldsymbol{\theta}}[\boldsymbol{\theta} \mid \mathcal{X}, \mathcal{Y}] \phi\left(\boldsymbol{x}_{*}\right) \\
&=\phi^{\top}\left(\boldsymbol{x}_{*}\right) \boldsymbol{S}_{N} \phi\left(\boldsymbol{x}_{*}\right)
\end{aligned}

我们可以发现均值与含噪音观测的均值一致，因为噪音的均值为0，因为噪音的方差为,所以当预测含噪音的函数值时，需要加上，无噪音的时候则不需要。
**还是没能很好地理解噪音这个概念**

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210610130744637.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)
上图是由参数后验得到的后验分布。由上图可知，当多项式为低阶的时候，参数的分布不会很分散。而对于高阶的贝叶斯回归模型，后验概率的不确定性很大，这个信息对于**决策系统**（decision-making system）很重要。

## [](#%E8%BE%B9%E9%99%85%E4%BC%BC%E7%84%B6%E7%9A%84%E8%AE%A1%E7%AE%97%EF%BC%88Computing-the-Marginal-Likelihood%EF%BC%89)边际似然的计算（Computing the Marginal Likelihood）

在本节中，我们介绍参数为共轭高斯先验的贝叶斯线性回归的边际似然的计算。
考虑以下参数形成的过程：

\begin{aligned}\theta&\sim \mathcal N(m_0,S_0)\\y_n|x_n, \theta&\sim\mathcal N(x_n^\top\theta,\sigma^2),\quad n=1,\dots,N\end{aligned}

则对应的边际似然为：

\begin{aligned} p(\mathcal Y|\mathcal X)&=\int p(\mathcal Y|\mathcal X, \theta)p(\theta)d\theta\\&=\int \mathcal N(y|X\theta,\sigma^2I)\mathcal N(\theta|m_0,S_0)d\theta\end{aligned}

上面这个式子可以理解为参数先验下的似然的期望：
计算边际似然需要两个步骤，首先先确定边际似然是高斯分布，然后计算出这个高斯分布的均值和方差。
由高斯分布的性质，两个高斯分布的乘积仍旧是高斯分布。
下面开始计算这个高斯分布的均值和方差：

\mathbb E[\mathcal Y|\mathcal X]=\mathbb E_{\theta,\epsilon}[X\theta+\epsilon]=X\mathbb E_\theta[\theta]=Xm_0,\quad \epsilon \sim \mathcal N(0,\sigma^2I)

方差为：

\begin{aligned}\operatorname{Cov}[\mathcal Y|\mathcal X]&=\operatorname{Cov}_{\theta,\epsilon}[X\theta+\epsilon]=\operatorname{Cov}[X\theta]+\sigma^2I\\ &=X\operatorname{Cov}_\theta[\theta]X^\top+\sigma^2I=XS_0X^\top+\sigma^2I\end{aligned}

所以，边际似然为：

\begin{aligned}
p(\mathcal{Y} \mid \mathcal{X})=&(2 \pi)^{-\frac{N}{2}} \operatorname{det}\left(\boldsymbol{X} \boldsymbol{S}_{0} \boldsymbol{X}^{\top}+\sigma^{2} \boldsymbol{I}\right)^{-\frac{1}{2}} \\
& \cdot \exp \left(-\frac{1}{2}\left(\boldsymbol{y}-\boldsymbol{X} \boldsymbol{m}_{0}\right)^{\top}\left(\boldsymbol{X} \boldsymbol{S}_{0} \boldsymbol{X}^{\top}+\sigma^{2} \boldsymbol{I}\right)^{-1}\left(\boldsymbol{y}-\boldsymbol{X} \boldsymbol{m}_{0}\right)\right)
\\&=\mathcal N(y|Xm_0,XS_0X^\top+\sigma^2I)
\end{aligned}> 

与之前的内容进行联系，为什么形式是这样的？

## [](#%E7%94%A8%E6%AD%A3%E4%BA%A4%E6%8A%95%E5%BD%B1%E8%A7%A3%E9%87%8A%E6%9E%81%E5%A4%A7%E4%BC%BC%E7%84%B6%E4%BC%B0%E8%AE%A1%EF%BC%88Maximum-Likelihood-as-Orthogonal-Projection%EF%BC%89)用正交投影解释极大似然估计（Maximum Likelihood as Orthogonal Projection）

考虑一个简单的线性规划模型：

y=x\theta+\epsilon,\quad \epsilon \sim \mathcal N(0,\sigma^2)

由原先的提到的极大似然估计，得到斜率参数：

\theta_{ML}=(X^\top X)^{-1}X^\top y=\frac{X^\top y}{X^\top X}\in \mathbb R

其中，和为训练集中的元素(都是向量，所以为标量，这也是将这一项放到分母的原因)。
所以对应的目标为：

X\theta_{ML}=X\frac{X^\top y}{X^\top X}=\frac{XX^\top}{X^\top X}y

所以可以理解为，我们的目标是找到的解。由原先的线性代数和解析几何，可以将上式理解为y在X张成的一维子空间的正交投影，其中为投影矩阵,为y在一维子空间中的正交投影的坐标，为在这个子空间中的正交投影。
所以，极大似然估计的解得到的是在子空间中找到一个与观测值最接近的向量。这里的距离表示和 的最短（平方）距离
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210615071428677.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTMxNTY1Ng==,size_16,color_FFFFFF,t_70)

在广义的线性规划中：

y=\phi^\top(x)\theta+\epsilon,\quad \epsilon \sim \mathcal N(0,\sigma^2)

其中,,利用极大似然估计得到参数结果：

\boldsymbol y\approx \Phi\theta_{ML}\\\theta_{ML}=(\Phi^\top\Phi)^{-1}\Phi^\top \boldsymbol y

上式实际上就是一个往特征矩阵张成的K维子空间的投影。若将特征矩阵构造成规范正交，这时候就形成了一个规范正交基。因为所以，对应的投影为：

\Phi(\Phi^\top\Phi)^{-1}\Phi^\top \boldsymbol y = \Phi\Phi^\top \boldsymbol y=\begin{pmatrix} \sum\limits^K_{k=1}\phi_k\phi_k^\top\end{pmatrix}\boldsymbol y

所以极大似然的投影这时候就是y向基向量的投影的和。

> 

这部分需要深入理解一下，为什么？
the coupling between different features has disappeared due to the orthogonality of the basis.

**Further Reading:**
1.In deffenrent cases we may choose deffenrent model functions which corresponding to the likelihood function
2.**generalized linear models**:there is a a smooth and invertible function (which could be nonlinear), so that ,where  which also . The first one is activate function, and the later one is linear function model. This can form a neural network model.
,where A is **weight matrix**, b is **bias vector** so:

\begin{aligned} x_{k+1}&=f_k(x_k)\\f_k(x_k)&=\sigma_k(A_kx_k+b_k)\end{aligned}

This is a K-layer deep neural network()