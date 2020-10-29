# Swift 5 多线程的编程

swift中有三种多线程技术：GCD Thread 和OperationQueue

Thread比较古老原始的方式  最轻量级的，但是需要自己手动管理生命周期

Cocoa Operation是面向对象的方式。主要类：Operation和BlockOperation

学习AFN的源代码学习Operation的操作 再理解封装Operation Block和异步使用completeBlock的

OperationQueue的底层还是使用了GCD的 

GCD也修改了新的接口 GCD本身是有线程池的

- 网络请求耗时
- IO操作也耗时 网络也是IO操作
- 计算非常复杂的
- 数据模型的转换 UPSPower的366个模型的解析JSON

为什么几乎所有的GUI框架都是单线程的？oracle社区论坛回答 代价很大

实际的多线程不是很美好的 静态资源的锁定  资源的竞争 线程间通信。调试难而且还很复杂





GCD主要包括的功能

- 创建和管理队列queue
- 提交任务Job
- Dispatch Group组的概念
- 管理Dispatch Object
- 信号量Semaphore ⚠️怎么用o
- 队列屏障
- Dispatch Source
- Queue Context 上下文数据
- Dispatch I/O的Channel
- Dispatch Data对象

```swift
Thread.detachNewThread {
    // 逃逸闭包 可能不是同步执行的
}

// 这种方式和上面自动的不同 需要手动start这个线程的任务
Thread.detachNewThreadSelector(<#selector: Selector#>, toTarget: Any, with: Any)
```



## GCD队列的概念

主队列- 任务主线程中执行

并行队列-任务会先进先出的顺序入队和出对。但是因为多个任务可以并行执行的，所以完成顺序是不一定的

串行队列-任务会以先进先出的顺序入队和出队的，但是同一个时刻只会执行一个任务的，是串行排队执行的





Swift UI学习

combine框架的学习



## Swift项目实战

Swift中常用的第三方框架

- Alamofire 5.0
- SwiftyJSON  4.0
- R.swift
- MonkeyKing
- Kingfisher
- SnapKit
- Dollar标准库的扩展

管理工具使用Cocoapods Swift需要在podfile中加入use frameworks!

预备的其他知识点

```swift
// showDetail的属性 combine

swift中的错误的处理
遵守Error协议 通常使用enum: Error


// 函数如何抛出错误
func canThrowErrors() throws-> String
怎么实现这样的出错处理呢？
Swift 中我们使用 do-catch 块对错误进行捕获，当我们在调用一个 throws 声明的函数或方 法时，我们必须把调用语句放在 do 语句块中，同时 do 语句块后面紧接着使用 catch 语句块


// ARC 循环引用的解决方案
Swift中使用弱引用和无主引用的方法解决循环retainCycle的问题
对于生命周期中引用会变为 nil 的实例，使用弱引用;对于初始化时赋值之后引用再也不会赋值为 nil 的实例，使用无主引用
weak表示弱引用 不会增加实例对象的retainCount 也不会阻止ARC销毁被引用的实例。这种特性使得引用不会变成强引用环

// 无主引用 默认始终是有只存在的，不能是可选类型的值
为了避免运行时的错误，我们要自己做好判断避免无主引用的错误
City和国家的关系中
City被销毁前国家生命周期是一直存在的，所以可以在City中unowned let country: Country的


// 解决闭包的循环引用 因为闭包也是一种引用类型
Swift中的闭包是类似 Class的

在闭包内可以定义占有列表的，占有列表使用self  someInstance 组成的
当闭包和占有的对象总是互相引用的时候并且总同时销毁时 将闭包的占有列表定义为unowned
行贩的是当占有的引用可能为nil的时候 如delegate就将其用weak关键字组成
生命周期内不会为nil的实例对象就用unowned修饰
```



网络请求

```swift
Alamofire网络请求工具库
// 简单实用
AF.request("https://geekbang.org/").response { res in
	debugPrint(response)
}

request方法的详解 L98课复习中提到的


// SnapKit的常用API

make  // 初始化约束调用
remake // 有冲突时解决  且更新
updateConstraint  //没有冲突时的更新操作

// kingFisher的使用
imageView.kf.setImage(with: url)
它还有一些高级的用法 DownsamplingImageProcessor(size:  view.bounds.size)


// 关键技术的补充
//1 Swift 可选链是什么
可选值有的时候是非常的笨拙的 要给代码加入很多的解包和判断的

1合并空值运算符
2 可选链
可选链让多个查询操作写在一行 如果中间任意一个nil就会让整个链条失败的
可选链是可以代替强制展开的。这和可选值后放叹号强制展开很相似

//KVC
Swift4 之后 类和结构体都是支持KVC的
KVC和OC的是有区别的

KVO只有继承了NSObject的类才支持 还需要@objc dynamic支持
使用NSKeyValueObservation比较方便 这个新对象是自动的反注册的。苹果是推荐使用这个的
```

>
>
>1继承自NS Object的类 标记为@objc的属性可以使用setValue(_:forKey)
>
>2非继承自NS Object的类和结构体 使用参数+索引