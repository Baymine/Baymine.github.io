---
layout: post
title: "Clickhouse源码阅读日记"
date: 2024-05-29 13:26:01 +0000
categories: [blog]
tags: []
---

# [](#%E6%BA%90%E7%A0%81)源码
## [](#%E5%88%97%EF%BC%88Columns%EF%BC%89)列（Columns）
## [](#%E5%AD%97%E6%AE%B5%EF%BC%88Field%EF%BC%89)字段（Field）
> 

src\Core\Field.h

$$字段实现是一个联合类， `std::aligned_union_t`，而一行数据在此文件当中定义为`using Row = std::vector<Field>;`$$

> 

Field 中并没有足够的关于一个表（table）的特定数据类型的信息。比如，UInt8、UInt16、UInt32 和 UInt64 在 Field 中均表示为 UInt64。

在代码当中，`createConcrete` 是一个模板函数，用于在给定的存储空间中创建一个具体的对象。小类型可能会被存储为更宽的类型，例如 char 可能会被存储为 UInt64。

## [](#%E5%9D%97%EF%BC%88Block%EF%BC%89)块（Block）
> 

If we have a `Block`, we have data (in the `IColumn` object), we have information about its type (in `IDataType`) that tells us how to deal with that column, and we have the column name. 

这个类的成员变量当中有一个由`IColumn`指针组成的向量，还有一个由map组成的索引，用于存储列名到列索引的映射。同时还包含一个块信息的结构体。

## [](#MaterializedView)MaterializedView

`MaterializedView`是一种特殊的表，它根据预定义的SELECT查询语句存储数据。当插入新数据到源表时，这些数据也会被插入到`MaterializedView`中。

`MaterializedView`的主要用途是预计算复杂的查询。例如，你可能有一个包含大量数据的表，你需要对这个表进行一些复杂的聚合查询。如果每次需要结果时都运行这些查询，可能会非常慢。相反，你可以创建一个`MaterializedView`，它根据你的查询预先计算结果。然后，你可以直接查询`MaterializedView`，这通常会比直接查询原始表快得多。

# [](#%E7%BC%96%E7%A8%8B%E8%8C%83%E5%BC%8F)编程范式
## [](#NOLINT)// NOLINT

在代码中添加 NOLINT 注释是一种指示，通常用于告诉静态代码分析工具或代码审查工具不要对特定行或块发出警告或错误报告。

`例如在使用reinterpret_cast的时候`

## [](#%E7%B1%BB%E5%90%8D%E7%A7%B0%EF%BC%9A-Helper)类名称：***Helper

通常是一个模板类的特化，可以是一个中间表示，其中实现了***（类名）的一些功能，作为统一的处理方式

`例如：template <typename T> class ColumnVectorHelper;`

## [](#%E7%B1%BB%E5%90%8D%E7%A7%B0%EF%BC%9A-Dummy)类名称：***Dummy

在C++编程中，如果一个类被命名为含有”Dummy”的名称，比如IColumnDummy，这通常意味着该类是一个占位符类（Placeholder Class）或者是一个模拟类（Mock Class）。

`例如：class IColumnDummy : public IColumn;`

## [](#%E5%9C%A8%E6%95%B0%E7%BB%84%E7%AC%AC%E4%B8%80%E4%B8%AA%E5%85%83%E7%B4%A0%E5%89%8D%E9%A2%84%E7%95%99%E4%B8%80%E4%B8%AA%E7%A9%BA%E9%97%B4%EF%BC%88-1th%EF%BC%89)在数组第一个元素前预留一个空间（-1th）

这个设计在将偏移量数组转换为大小数组时提供了性能优势。在处理这种转换时，通常需要计算当前元素的大小，即下一个元素的偏移量减去当前元素的偏移量。有了额外的 0 值的 -1th 元素，计算第一个元素的大小时，可以直接用 0 减去第一个元素的偏移量，而不需要特殊处理。这样简化了代码，减少了条件分支，并可能提高计算速度。

`在链表插入的过程中使用dummy_header也是类似的设计`

> 

1.在高性能计算或大数据处理中，避免条件分支可以显著提高循环的效率，因为现代处理器对分支预测有困难，尤其是在分支密集的情况下。
2.在处理向量数据或使用单指令多数据（SIMD）指令时，if 语句可能导致向量操作的分裂
3.分支惩罚

[对于 String 列和 Array 列，则由两个向量组成：其中一个向量连续存储所有的 String 或数组元素，另一个存储每一个 String 或 Array 的起始元素在第一个向量中的偏移。](https://clickhouse.com/docs/zh/development/architecture#lie-columns)

在这种场景下，偏移数组可能需要转换成大小数组，这个时候可以利用到这种优化

# [](#%E6%A6%82%E5%BF%B5)概念
## [](#loop-vectorization-%E5%BE%AA%E7%8E%AF%E5%90%91%E9%87%8F%E5%8C%96)loop vectorization(循环向量化)

循环向量化是一种编译器优化技术，用于将循环转换为向量化指令，以便在单个指令中处理多个数据元素。这种技术可以提高程序的性能，因为它可以利用现代处理器的SIMD指令集，同时减少循环的迭代次数。

$$`例如：for (int i = 0; i < n; ++i) { c[i] = a[i] + b[i]; }`$$

# [](#%E8%AF%AD%E8%A8%80-%E8%AF%AD%E6%B3%95)语言/语法
## [](#C-11-using-%E5%BC%95%E5%85%A5%E6%9E%84%E9%80%A0%E5%87%BD%E6%95%B0)C++11 using 引入构造函数

1
12

#define DEFINE_FIELD_VECTOR(X) \
struct X : public FieldVector \
{ \
    using FieldVector::FieldVector; \
}
'''
using FieldVector::FieldVector;：这是 C++11 引入的 using 声明，它引入了基类（FieldVector）的构造函数到派生类（X）的作用域中。
(第一个FieldVector是类名，第二个是构造函数的函数名称，这引入了所有的构造函数)

这意味着 X 类可以使用 FieldVector 的所有构造函数，而无需重复定义。
这有助于避免构造函数的代码重复，并保持代码简洁。
'''