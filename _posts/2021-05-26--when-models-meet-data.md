---
layout: post
title: "机器学习中的数学: When Models Meet Data"
date: 2021-05-26 02:51:34 +0000
categories: [blog]
tags: []
---

# [](#Data-Models-and-Learning)Data, Models, and Learning

The title contains three major components of a machine learning system.

## [](#Data-as-Vectors)Data as Vectors

First, we need to make information as number, so as to we can use it as training data.

## [](#Models-as-Functions)Models as Functions

There are two main school relative to the machine learning, function and probabilistic model. The former one gives a specific value, the later one would give the distribution of the result.
<!-- Image removed: CSDN link no longer accessible -->
And in order to value a model, we use cost function or loss function to discribe it.

# [](#%E7%BB%8F%E9%AA%8C%E9%A3%8E%E9%99%A9%E6%9C%80%E5%B0%8F%E5%8C%96%EF%BC%88Empirical-Risk-Minimization%EF%BC%89)经验风险最小化（Empirical Risk Minimization）

本节主要探讨几个问题：那些函数可以被用作预测函数？如何衡量一个模型的好坏？如何让一个从已知训练集中训练出来的模型很好地预测未见得数据？在找合适的模型时，应该遵循什么样的步骤？

## [](#%E5%81%87%E8%AE%BE%E5%87%BD%E6%95%B0%E7%9A%84%E7%A7%8D%E7%B1%BB%EF%BC%88Hypothesis-Class-of-Functions%EF%BC%89)假设函数的种类（Hypothesis Class of Functions）

我们训练的目的是找到一个参数列表,使得函数的输出结果能够更接近真实值，即：

$$f(x_n,\theta^*)\approx y_n\quad for \ all\ \ a = 1,\cdots,N$$

在本节中使用代表模型的预测值。

## [](#%E4%BB%A3%E4%BB%B7%E5%87%BD%E6%95%B0-Loss-Function-for-Training)代价函数(Loss Function for Training)

**经验风险**（empirical risk）：真实值与预测值的偏差

对于一个给定的训练集,实例矩阵（example matrix）：,标签矩阵,对应的平均损失为：

$$R_{emp}(f,\boldsymbol X, y)=\frac{1}{N}\sum\limits^N_{n-1} l(y_n,\hat y_n)$$

我们希望模型不仅仅能够很好地拟合训练数据，还希望模型能够很好地预测数据，所以能够找到一个**期望风险**（Expected Risk）

$$\bold R_{true}(f)=\boldsymbol{\mathbb E_{x,y}}[l(y,f(\boldsymbol x))]## [](#%E6%AD%A3%E5%88%99%E5%8C%96%E5%87%8F%E5%B0%8F%E8%BF%87%E6%8B%9F%E5%90%88-Regularization-to-Reduce-Overfitting)正则化减小过拟合(Regularization to Reduce Overfitting)$$

如果有足够的参数，给定地模型一般能够很好地拟合测试数据，但是预测数据却与实际数据有较大的偏差，这时候就是模型发生了**过拟合**。
一般情况下，已知的数据分为测试数据和训练数据，分别用于测试和训练模型。

> 

Regularization is a way to compromise between accurate solution of empirical risk minimization and the size or complexity of the solution.
对于一个最小二乘问题：,加上正则项则是：

$$\min\limits_\theta\frac{1}{N}\|y-X\theta\|^2+\lambda \|\theta\|$$

## [](#%E7%94%A8%E4%BA%A4%E5%8F%89%E9%AA%8C%E8%AF%81%E8%AF%84%E4%BC%B0%E6%B3%9B%E5%8C%96%E6%80%A7%E8%83%BD-Cross-Validation-to-Assess-the-Generalization-Performance)用交叉验证评估泛化性能(Cross-Validation to Assess the Generalization Performance)

我们将已知数据进行拆分，一部分用于模型训练，一部分用于模型性能测试，这个称为**验证集**（validation set）。但是如果训练数据太少，可能导致得不到好的模型，如果训练数据太少可能导致噪声估计。所以应该对已有的数据进行合理的划分，这就有**K-折交叉验证**（K-fold cross-validation）
<!-- Image removed: CSDN link no longer accessible -->

这样得到的**期望泛化误差**（expected generalization error）为：

$$\mathbb E_\mathcal V[R(f,\mathcal V)]\approx\frac{1}{K}\sum^K_{k=1}R(f^{(k)},\mathcal V^{(k)})$$

其中，为预测值与真实值之间的误差。
但是这个方法有几个缺点，首先是不合理的数据划分可能会导致的几个不好的结果，与之前的训练集和测试集之间的大小关系导致不同后果一致。同时需要对模型进行K次训练，可能需要大量的计算资源。

> 

Evaluating the quality of the model, depending on these hyperparameters, may result in a number of training runs that is exponential in the number of model parameters. 

# [](#%E5%8F%82%E6%95%B0%E4%BC%B0%E8%AE%A1%EF%BC%88Parameter-Estimation%EF%BC%89)参数估计（Parameter Estimation）
## [](#%E6%9C%80%E5%A4%A7%E4%BC%BC%E7%84%B6%E4%BC%B0%E8%AE%A1%EF%BC%88Maximum-Likelihood-Estimation%EF%BC%89)最大似然估计（Maximum Likelihood Estimation）

定义一个关于参数的函数，去评估模型对数据的拟合的好坏。一般使用**负对数似然**（negative log-likelihood）：

$$\mathcal L_x(\boldsymbol\theta)=-\log p(\boldsymbol x|\boldsymbol\theta)$$

在上式中，样品值是固定的，变化的是参数,这个函数彰显的是给定参数的情况下，取得样品值的概率。
假设两个相互独立且均匀分布的数据集，,,他们的似然方程可以呗分解为：

$$p(\mathcal Y|\mathcal X,\theta)=\prod^N_{n=1}p(y_n|\boldsymbol x_n,\boldsymbol\theta)$$

但是从优化的角度来看，和比乘积更容易处理：

$$\mathcal L(\theta)=-\log p(\mathcal Y|\mathcal X, \theta)=-\sum^N_{n=1}\log p(y_n|x_n,\theta)>$$

hence should be interpreted as observed and fixed, this interpretation is incorrect.

## [](#%E6%9C%80%E5%A4%A7%E5%90%8E%E9%AA%8C%E4%BC%B0%E8%AE%A1%EF%BC%88Maximum-A-Posteriori-Estimation%EF%BC%89)最大后验估计（Maximum A Posteriori Estimation）

如果我们有关于参数的先验知识，这样可以利用贝叶斯公式更新后验概率，以对参数进行估计。这个与之前提到的正则项类似，在似然概率之后乘以一个对参数的先验概率分布。

> 

这部分需要补充

## [](#%E6%A8%A1%E5%9E%8B%E6%8B%9F%E5%90%88%EF%BC%88Model-Fitting%EF%BC%89)模型拟合（Model Fitting）

拟合的意思就是优化模型的参数，以最小化代价函数。
**参数化**（arametrization）：一种描述模型的方式。

$$y = ax+b\rightarrow \theta:=\{a,b\}$$

<!-- Image removed: CSDN link no longer accessible -->
书中使用表示参数化的模型，$M^*$为真实值，上图中的红线可以认为是代价函数。
*拟合的三种结果*：
<!-- Image removed: CSDN link no longer accessible -->

> 

泛化线性模型(generalized generalized linear)：
In statistics, the generalized linear model (GLM) is a flexible generalization of ordinary linear regression that allows for response variables that have error distribution models other than a normal distribution.
连接函数（Link Function）：
The link function provides the relationship between the linear predictor and the mean of the distribution function.

## [](#%E8%B4%9D%E5%8F%B6%E6%96%AF%E6%8E%A8%E6%96%AD%EF%BC%88Bayesian-Inference%EF%BC%89)贝叶斯推断（Bayesian Inference）

之前提到的极大似然估计和极大后验估计最后都是在解决一个优化问题，通过解决这个优化问题，我们可以得到模型参数，利用这个参数我们可以得到预测值的分布
由于仅仅是关注于部分数据的后验分布会损失部分的信息，而损失的信息可能对决策系统至关重要，所以得到一个完成数据的后验分布十分重要

> 

这部分需要补充，关于信息损失

对于一个数据集、一个参数先验和一个似然方程的后验分布为：

$$p(\theta|\mathcal X)=\frac{p(\mathcal X|\theta)p(\theta)}{p(\mathcal X)},\quad p(\mathcal X)=\int p(\mathcal X|\theta)p(\theta)d\theta$$

利用参数的后验分布，我们可以将对参数的不确定性转移到数据上,也就是我们的预测值不再依赖于参数了：

$$p(\boldsymbol x)=\int p(\boldsymbol x|\boldsymbol\theta)p(\boldsymbol\theta)d\boldsymbol\theta=\mathbb E_\boldsymbol\theta[p(\boldsymbol x|\boldsymbol\theta)]$$

上式说明，预测值是所有参数下的预测值的均值。

## [](#%E6%BD%9C%E5%8F%98%E9%87%8F%E6%A8%A1%E5%9E%8B%EF%BC%88Latent-Variable-Models%EF%BC%89)潜变量模型（Latent-Variable Models）
> 

Mathematical models that aim to explain observed variables in terms of latent variables are called **latent variable models**

**潜变量**（Latent-Variable）
These could in principle be measured, but may not be for practical reasons. In this situation, the term hidden variables is commonly used (reflecting the fact that the variables are meaningful, but not observable).

想要简化模型，最简单的方法就是减少模型的参数的数量。但是利用潜变量模型（expectation maximization (EM) algorithm），可以更加规范地简化模型。
潜变量模型能够帮助我们描述从参数中获取预测值地过程：
将数据表示为,模型的参数表示为,潜变量表示为,我们可以得到条件分布：

p(\boldsymbol x|\boldsymbol z,\boldsymbol\theta)

想要得到给定模型参数下的预测数据，我们需要消去潜变量：

$$p(x|\theta)=\int p(x|z,\theta)p(z)dz$$

注意到似然方程与潜变量无关，有了上面这个式子，我们可以直接使用极大似然估计来进行参数估计。
用上式带入到贝叶斯公式中：

$$p(\theta|\mathcal X)=\frac{p(\mathcal X|\theta)p(\theta)}{p(\mathcal X)}$$

其中，为给定的数据集。这样得到了后验概率分布，可以用于贝叶斯推断。
与上式类似，我们可以得到潜变量的后验分布：

$$p(z|\mathcal X)=\frac{p(\mathcal X|z)p(z)}{p(\mathcal X)},\quad p(\mathcal X|z)=\int p(\mathcal X|z,\theta)p(\theta)d\theta$$

但是还是遇到了积分。而且同时将参数和潜变量消掉也非常困难。
下面这个式子相对好计算：

$$p(z|\mathcal X,\theta)=\frac{p(\mathcal X|z,\theta)p(z)}{p(\mathcal X|\theta)}>$$

补充一下这部分？含义？

# [](#%E6%9C%89%E5%90%91%E5%9B%BE%E6%A8%A1%E5%9E%8B%EF%BC%88Directed-Graphical-Models-Bayesian-networks%EF%BC%89)有向图模型（Directed Graphical Models/Bayesian networks）

将一个随机变量表示为一个有向图的节点，随机变量之间的关系表示为有向图的边，这样可以很好的得出随机变量之间的关系，而且可以将随机变量之间的关系变换转换成有向图的操作.

## [](#%E5%9B%BE%E7%9A%84%E8%AF%AD%E4%B9%89%EF%BC%88Graph-Semantics%EF%BC%89)图的语义（Graph Semantics）

下图表示的是a、b、c三个随机变量，边代表条件概率分布，例如a、b节点，代表
<!-- Image removed: CSDN link no longer accessible -->
所以，一个联合概率分布可以表示为：

$$p(\boldsymbol x)=\prod^K_{k=1}p(x_k|Pa_k)$$

其中，表示节点的父节点。
对于一个重复N次的伯努利实验的联合概率分布为：
<!-- Image removed: CSDN link no longer accessible -->
图(b)是一种更加紧凑的表示方法，图 (c)中的、是潜变量的**超参数**（Hyperparameter）也是的一个超前驱（hyperprior）

## [](#%E6%9D%A1%E4%BB%B6%E6%A6%82%E7%8E%87%E5%88%86%E5%B8%83%E5%92%8Cd-%E5%88%86%E7%A6%BB%EF%BC%88%E6%9C%89%E5%90%91%E5%88%86%E7%A6%BB%EF%BC%89%EF%BC%88Conditional-Independence-and-d-Separation%EF%BC%89)条件概率分布和d-分离（有向分离）（Conditional Independence and d-Separation）

假设一个互不相交的节点集，,在下，与条件独立，表示为：

\mathcal A \perp \!\!\!\perp\mathcal B\ |\ \mathcal C

`有向分离`(d-separation)的基本思想：通过贝叶斯网中看两个事件的关系（两个事件是否条件独立），从而简化概率计算。（利用两时间的相互独立的性质）
当三个节点满足下面地条件之一的时候，则表示是d-分离的。
<!-- Image removed: CSDN link no longer accessible -->
<!-- Image removed: CSDN link no longer accessible -->

> 

下面的参考博客中有对应结论的推导

$$[参考](https://blog.csdn.net/ybdesire/article/details/78998398?ops_request_misc=%257B%2522request%255Fid%2522%253A%2522162190960216780264053425%2522%252C%2522scm%2522%253A%252220140713.130102334..%2522%257D&request_id=162190960216780264053425&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~all~sobaiduend~default-1-78998398.first_rank_v2_pc_rank_v29&utm_term=d%E5%88%86%E7%A6%BB&spm=1018.2226.3001.4187)$$
这里两种情况：

2
3

# [](#%E6%A8%A1%E5%9E%8B%E9%80%89%E6%8B%A9%EF%BC%88Model-Selection%EF%BC%89)模型选择（Model Selection）

越复杂的模型能够表示的数据之间的关系就越多，例如一个二次函数模型，除了能够表示线性关系之外，还可以表示数据之间的二次关系。虽然复杂的模型能够表示更多的数据关系，但是有时候因为数据量比较小，可能会导致`过拟合`的现象。我们还需要知道如何评估模型在泛化数据下的性能。

## [](#%E5%B5%8C%E5%A5%97%E4%BA%A4%E5%8F%89%E9%AA%8C%E8%AF%81%EF%BC%88Nested-Cross-Validation%EF%BC%89)嵌套交叉验证（Nested Cross-Validation）

<!-- Image removed: CSDN link no longer accessible -->
将数据分为三个部分，第一部分用于训练模型，第二部分用于计算误差：

$$\mathbb E_\mathcal V[\boldsymbol R(\mathcal V| M)]\approx = \frac{1}{K}\sum^K_{k=1}\boldsymbol R(\mathcal V^{(k)}|M)$$

其中代表的是**经验风险**(empirical risk)
计算所有模型的经验风险，然后选取经验风险最小的模型作为最终模型，然后利用测试数据计算模型的泛化误差。

## [](#%E8%B4%9D%E5%8F%B6%E6%96%AF%E6%A8%A1%E5%9E%8B%E9%80%89%E6%8B%A9%EF%BC%88Bayesian-Model-Selection%EF%BC%89)贝叶斯模型选择（Bayesian Model Selection）

简单的模型较复杂的模型不容易出现过拟合的现象，所以在能够合理拟合数据的情况下，应该尽可能选取简单的模型，这被称为**奥卡姆剃刀**（Occam’s razor）。在贝叶斯概率的应用过程中，定量地体现了一个“自动奥卡姆剃刀”

> 

<!-- Image removed: CSDN link no longer accessible -->
上图中，横坐标表示所有的可能的数据集，纵坐标表示模型对对应数据的拟合程度。我们会选用拟合程度更好的模拟作为最终的模型。

下图是数据生成过程：
<!-- Image removed: CSDN link no longer accessible -->
第一个表示模型的先验概率，表示模型被选取的概率，第二个表示模型对应的参数的分布，最后一个是模型的生成数据。

用贝叶斯网可以表示为：
<!-- Image removed: CSDN link no longer accessible -->
我们可以利用贝叶斯公式计算后验分布：

p(M_k|\mathcal D)\propto p(M_k)p(\mathcal D|M_k)，\quad(*)

其中的后验分布不依赖于参数,因为：

$$p(\mathcal D|M_k)=\int p(\mathcal D|\boldsymbol \theta_k)p(\boldsymbol \theta_k|M_k)d\boldsymbol \theta_k$$

这个式子被称为**边际似然**（marginal likelihood）
利用(*)式，可以得到极大后验估计：

$$M^*=\operatorname {arg}\max_{M_k}p(M_k|\mathcal D)>$$

似然与边际似然有些不同点，前者更容易出现过拟合的现象，后者因为参数被边际化掉了，出现过拟合的现象更小。而且边际似然中嵌套着模型复杂度和数据拟合之间的一个折中。

## [](#%E6%A8%A1%E5%9E%8B%E6%AF%94%E8%BE%83%E4%B8%AD%E7%9A%84%E8%B4%9D%E5%8F%B6%E6%96%AF%E5%9B%A0%E5%AD%90%EF%BC%88Bayes-Factors-for-Model-Comparison%EF%BC%89)模型比较中的贝叶斯因子（Bayes Factors for Model Comparison）

在给定数据集和两个模型,想要计算后验分布

$$\underbrace{\frac{p\left(M_{1} \mid \mathcal{D}\right)}{p\left(M_{2} \mid \mathcal{D}\right)}}_{\text {posterior odds(后验相对风险) }}=\frac{\frac{p\left(\mathcal{D} \mid M_{1}\right) p\left(M_{1}\right)}{p(\mathcal{D})}}{\frac{p\left(\mathcal{D} \mid M_{2}\right) p\left(M_{2}\right)}{p(\mathcal{D})}}=\underbrace{\frac{p\left(M_{1}\right)}{p\left(M_{2}\right)}}_{\text {prior odds }} \underbrace{\frac{p\left(\mathcal{D} \mid M_{1}\right)}{p\left(\mathcal{D} \mid M_{2}\right)}}_{\text {Bayes factor }}>$$

???
<!-- Image removed: CSDN link no longer accessible -->

如果选择每一个模型的概率相等，即,则可以根据贝叶斯因子与1的关系，选择模型。

> 

**信息准则**（information criteria）：
**Akaike information criterion**：corrects for the bias of the maximum likelihood estimator by addition of a penalty term to compensate for the overfitting of more complex models with lots of parameters.
其中，M表示参数的个数
**Bayesian information criterion (BIC)**

$$\log p(x)=\log\int p(x|\boldsymbol\theta)p(\boldsymbol\theta)d\boldsymbol\theta\approx\log p(x|\boldsymbol\theta)-\frac{1}{2}M\log N$$

这里N表示数据集，M表示参数个数
**这部分遇到的时候在详细学习**