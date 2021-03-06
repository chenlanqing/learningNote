
# 一、性能调优理论基础

所谓性能，就是使用有限的资源在有限的时间内完成工作

## 1、基本

- 借助监控预防问题、发现问题；
- 借助工具定位问题；
- 定期复盘，防止同类问题再现；
- 定好规范，一定程度上规避问题；

主要点：
- 并行、异步化
- 存储优化


## 2、性能优化衡量指标

- `QPS`：Queries Per Second，每秒查询数，即是每秒能够响应的查询次数，注意这里的查询是指用户发出请求到服务器做出响应成功的次数，简单理解可以认为查询=请求request；qps=每秒钟request数量

- `TPS`：Transactions Per Second 的缩写，每秒处理的事务数；一个事务是指一个客户机向服务器发送请求然后服务器做出反应的过程。客户机在发送请求时开始计时，收到服务器响应后结束计时，以此来计算使用的时间和完成的事务个数。针对单接口而言，TPS可以认为是等价于QPS的，比如访问一个页面/index.html，是一个TPS，而访问/index.html页面可能请求了3次服务器比如css、js、index接口，产生了3个QPS；

- `RT`：Response Time缩写，简单理解为系统从输入到输出的时间间隔，宽泛的来说，他代表从客户端发起请求到服务端接受到请求并响应所有数据的时间差。一般取平均响应时间；

- 并发数：系统能同时处理的请求/事务数量

`QPS = 并发数 / RT` 或者 `并发数 = QPS * RT`

### 2.1、吞吐量和响应速度

在交通非常繁忙的情况下，十字路口是典型的瓶颈点，当红绿灯放行时间非常长时，后面往往会排起长队。从我们开车开始排队，到车经过红绿灯，这个过程所花费的时间，就是`响应时间`。当然，我们可以适当地调低红绿灯的间隔时间，这样对于某些车辆来说，通过时间可能会短一些。但是，如果信号灯频繁切换，反而会导致单位时间内通过的车辆减少，换一个角度，我们也可以认为这个十字路口的车辆吞吐量减少了；

- 响应速度是串行执行的优化，通过优化执行步骤解决问题；
- 吞吐量是并行执行的优化，通过合理利用计算资源达到目标；

### 2.2、响应时间衡量

**平均响应时间**

它的本质是把所有的请求耗时加起来，然后除以请求的次数。举个最简单的例子，有 10 个请求，其中有 2 个 1ms、3 个 5ms、5 个 10ms，那么它的平均耗时就是`(2*1+3*5+5*10)/10=6.7ms`

**百分位数**

圈定一个时间范围，把每次请求的耗时加入一个列表中，然后按照从小到大的顺序将这些时间进行排序。这样，取出特定百分位的耗时，这个数字就是 TP 值。可以看到，TP 值(Top Percentile)和中位数、平均数等是类似的，都是一个统计学里的术语；

一般分为 TP50、TP90、TP95、TP99、TP99.9 等多个段，对高百分位的值要求越高，对系统响应能力的稳定性要求越高；

### 2.3、并发量

并发量是指系统同时能处理的请求数量，这个指标反映了系统的负载能力

### 2.4、秒开率

在移动互联网时代，尤其对于 App 中的页面，秒开是一种极佳的用户体验。如果能在 1 秒内加载完成页面，那用户可以获得流畅的体验，并且不会产生更多的焦虑感

### 2.5、正确性

## 3、理论方法

### 3.1、木桶理论

一只木桶若想要装最多的水，则需要每块木板都一样长而且没有破损才行。如果有一块木板不满足条件，那么这只桶就无法装最多的水。

能够装多少水，取决于最短的那块木板，而不是最长的那一块。

木桶效应在解释系统性能上，也非常适合。组成系统的组件，在速度上是良莠不齐的。系统的整体性能，就取决于系统中最慢的组件。

比如，在数据库应用中，制约性能最严重的是落盘的 I/O 问题，也就是说，硬盘是这个场景下的短板，我们首要的任务就是补齐这个短板

### 3.2、基准测试、预热

基准测试(Benchmark)并不是简单的性能测试，是用来测试某个程序的最佳性能。

应用接口往往在刚启动后都有短暂的超时。在测试之前，我们需要对应用进行预热，消除 JIT 编译器等因素的影响。而在 Java 里就有一个组件，即 JMH，就可以消除这些差异

## 4、优化注意点

- 依据数字而不是猜想：进行性能优化时，我们一般会把分析后的结果排一个优先级（根据难度和影响程度），从大处着手，首先击破影响最大的点，然后将其他影响因素逐一击破

- 个体数据不足信：

    这是因为个体请求的小批量数据，可参考价值并不是非常大。响应时间可能因用户的数据而异，也可能取决于设备和网络条件。

    合理的做法，是从统计数据中找到一些规律，比如上面所提到的平均响应时间、TP 值等，甚至是响应时间分布的直方图，这些都能够帮我们评估性能质量

- 不要过早优化和过度优化：正确的做法是，项目开发和性能优化，应该作为两个独立的步骤进行，要做性能优化，要等到整个项目的架构和功能大体进入稳定状态时再进行

- 保持良好的编码习惯：保持好的编码规范，就可以非常方便地进行代码重构；使用合适的设计模式，合理的划分模块，就可以针对性能问题和结构问题进行聚焦、优化

## 5、优化手段

### 5.1、复用优化

- 重复代码抽取为公共的方法；
- 缓冲（Buffer），常见于对数据的暂存，然后批量传输或者写入。多使用顺序方式，用来缓解不同设备之间频繁地、缓慢地随机写，缓冲主要针对的是写操作。
- 缓存（Cache），常见于对已读取数据的复用，通过将它们缓存在相对高速的区域，缓存主要针对的是读操作；比如计算结果、数据缓存等；
- 池化操作，比如数据库连接池、线程池；

### 5.2、计算优化

**并行执行：**

并行执行有以下三种模式。
- 第一种模式是多机，采用负载均衡的方式，将流量或者大的计算拆分成多个部分，同时进行处理。比如，Hadoop 通过 MapReduce 的方式，把任务打散，多机同时进行计算。
- 第二种模式是采用多进程。比如 Nginx，采用 NIO 编程模型，Master 统一管理 Worker 进程，然后由 Worker 进程进行真正的请求代理，这也能很好地利用硬件的多个 CPU。
- 第三种模式是使用多线程，这也是 Java 程序员接触最多的。比如 Netty，采用 Reactor 编程模型，同样使用 NIO，但它是基于线程的。Boss 线程用来接收请求，然后调度给相应的 Worker 线程进行真正的业务计算；

**变同步为异步：**

**惰性加载：**

### 5.3、结果集优化

- 压缩
- 批量
- 索引
- 复用

### 5.4、资源冲突优化

- 锁粒度
- 事务范围
- 锁级别：悲观锁、乐观锁
- 锁类型：公平锁、非公平锁

### 5.5、算法优化

算法属于代码调优，代码调优涉及很多编码技巧，需要使用者对所使用语言的 API 也非常熟悉。有时候，对算法、数据结构的灵活使用，也是代码优化的一个重要内容。比如，常用的降低时间复杂度的方式，就有递归、二分、排序、动态规划等

### 5.6、高效实现

使用一些设计理念良好、性能优越的组件

### 5.7、JVM 优化

## 6、资源瓶颈

哪些资源比较容易成为瓶颈呢？

### 6.1、CPU

- 通过 top 命令，来观测 CPU 的性能；
- 通过负载，评估 CPU 任务执行的排队情况；
- 通过 vmstat，看 CPU 的繁忙程度。

### 6.2、内存

### 6.3、IO

iostat

零拷贝

# 二、优化工具

## 1、Arthas

## 2、应用性能调优-监控工具

### 2.1、Skywalking

[参考](分布式架构/分布式.md#2skyWalking)

### 2.2、SpringBoot Actuator

### 2.3、Javamelody

### 2.4、Tomcat Manager

https://gitee.com/chenlanqing/platform

PSI Probe

## 3、JVM调优

## 4、数据库调优

## 5、架构调优

## 6、操作系统调优

## 7、性能调优技巧

- 池化技术
- 异步化
- 锁优化

# switch 与 if 性能比较

https://mp.weixin.qq.com/s/JkqKg4ZdHBLP_u2COZ4oPw


[性能优化](https://xie.infoq.cn/article/a0d418bf29915ecad5d5eeab0)

