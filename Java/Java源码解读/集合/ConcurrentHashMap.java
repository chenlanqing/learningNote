/**
 * http://www.importnew.com/16147.html
 * https://www.ibm.com/developerworks/cn/java/java-lo-concurrenthashmap/
 * https://mp.weixin.qq.com/s/HUvHUBRqp4I4ShyUJr5xDw
 * https://mp.weixin.qq.com/s/V4KzR7A4Kq5ioCbF4oeiIw
 * https://mp.weixin.qq.com/s/8XLqCwWQimAIr__S_BfrHA
 * https://mp.weixin.qq.com/s/8MCq-i0AMqaJRQIecJl2WA
 */
三个方法研究:
ConcurrentHashMap 的锁分段技术;
ConcurrentHashMap 的读是否要加锁,为什么;
ConcurrentHashMap 的迭代器是强一致性的迭代器还是弱一致性的迭代器;
***********************************************源码版本:JDK1.6*****************************************************
一.基于 JDK6 ConcurrentHashMap 的技术原理:
1.ConcurrentHashMap 的锁分段技术:
	首先将数据分成一段一段的存储,然后给每一段数据配一把锁,当一个线程占用锁访问其中一个段数据的时候,其他段的数据也能被其他线程访问.
	采用分段锁的机制,实现并发的更新操作,底层采用"数组+链表+红黑树"的存储结构,其包含两个核心静态内部类 Segment 和 HashEntry.
2.ConcurrentHashMap 是由 Segment 数组结构和 HashEntry 数组结构组成
	Segment 是一种可重入锁 ReentrantLock，在 ConcurrentHashMap 里扮演锁的角色，HashEntry 则用于存储键值对数据.
	一个 ConcurrentHashMap 里包含一个 Segment 数组，Segment 的结构和 HashMap 类似,是一种数组和链表结构,
	一个 Segment 里包含一个 HashEntry 数组，每个 HashEntry 是一个链表结构的元素,每个 Segment 守护着一个 
	HashEntry 数组里的元素,当对 HashEntry 数组的数据进行修改时，必须首先获得它对应的 Segment 锁
	2.1.HashEntry:
		用来封装散列映射表中的键值对.在 HashEntry 类中,key、hash和next 域都被声明为 final 型,value 域被声明为 volatile 型;
	2.2.Segment:继承于 ReentrantLock 类
		(1).table 是一个由 HashEntry 对象组成的数组。table 数组的每一个数组成员就是散列映射表的一个桶
		(2).count 变量是一个计数器，它表示每个 Segment 对象管理的 table 数组(若干个 HashEntry 组成的链表)
			包含的 HashEntry 对象的个数;
3.ConcurrentHashMap 类:在默认并发级别会创建包含 16 个 Segment 对象的数组
	(1).每个 Segment 的成员对象 table 包含若干个散列表的桶。每个桶是由 HashEntry 链接起来的一个链表。
		如果键能均匀散列，每个 Segment 大约守护整个散列表中桶总数的 1/16
4.ConcurrentHashMap 的初始化:
	(1).ConcurrentHashMap 初始化方法是通过 initialCapacity，loadFactor, concurrencyLevel几个参数来初始化segments数组，
		段偏移量segmentShift，段掩码segmentMask和每个segment里的HashEntry数组

5.ConcurrentHashMap 实现高并发:
	(1).ConcurrentHashMap 基于散列表的特性(除了少数插入操作和删除操作外,绝大多数都是读取操作,而且读操作在大多
		数时候都是成功的)针对读操作做了大量的优化;通过 HashEntry 对象的不变性和用 volatile 型变量协调线程间的内存可见性,
		使得大多数时候,读操作不需要加锁就可以正确获得值;
		ConcurrentHashMap 是一个并发散列映射表的实现，它允许完全并发的读取,并且支持给定数量的并发更新
	(2).用分离锁实现多个线程间的更深层次的共享访问,用 HashEntery 对象的不变性来降低执行读操作的线程在遍历链表期间对加锁的需求
		通过对同一个 Volatile 变量的写 / 读访问，协调不同线程间读 / 写操作的内存可见性

***********************************************源码版本:JDK1.8*****************************************************
/**
 * https://mp.weixin.qq.com/s?__biz=MzIwMzY1OTU1NQ==&mid=2247483889&idx=1&sn=b2fcb50a7e8a556467ccb9a0cc9fe927&chksm=96cd41bda1bac8ab61e9e6d6b450ee69307c37713e3c73825dea2a3494a35c5f9ecd3a91eabd&scene=38#wechat_redirect
 * https://mp.weixin.qq.com/s?__biz=MzIwMzY1OTU1NQ==&mid=2247483894&idx=1&sn=72e7fb63296ff382568a7861c75068c1&chksm=96cd41baa1bac8ace9a8c99a76851a59ebc57997bfaa680e5cdf8e42191dd8c0b3b281851edd&scene=38#wechat_redirect
 * https://mp.weixin.qq.com/s?__biz=MzIwMzY1OTU1NQ==&mid=2247483902&idx=1&sn=4e52472a2ddfb6825fd9f1928c33e1ed&chksm=96cd41b2a1bac8a4f927f20905c1263b236a748fa05e06ba857459d1c46eafabd3b740c68fe7&scene=38#wechat_redirect
 */
在1.8的实现中,已经抛弃了 Segment 分段锁机制,而是利用 CAS + synchronized 来保证并发更新安全的.底层依然采用"数组+链表+红黑树"的存储结构
1.基本概念:





































































