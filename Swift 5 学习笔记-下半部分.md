# Swift 5 学习笔记



## 第一节课 Swift 函数的基础

常规的函数是一种类型 可以当作返回值被返回或者当作参数被传递的吗

可以使用一个变量来接受一个函数 并且和实际参数标签也不会影响函数的类型

Swift中的实际参数标签的作用类似OC的外部函数名 方便函数名更加易读

```swift
//省略实际参数标签的做法
func someFunction(_ firstParameterName:Int, secondParameterName:Int) {
    // BODY CODE
}
someFunction(11, secondParameterName: 22)


// 默认参数的值
func someFunction(parameterDefault:Int = 43) {
    print(parameterDefault)
}

someFunction() // 使用了默认的参数名
someFunction(parameterDefault: 1)


// 输入输出形式的参数  关键字
inout  位运算符号&传递输入输出的实参


// 把函数当参数进行传递的demo
func printMathResult(_ mathFunction:((Int, Int)-> Int),  _ param1 : Int,  _ param2 : Int) {
    print("Res: \(mathFunction(param1, param1))")
}
func addTwoNumber(num1:Int, num2:Int) -> Int {
    return num1 + num2
}
printMathResult(addTwoNumber, 1, 2)
```



Swift中可以在函数的内部定义另外一个函数， 这就是内嵌函数

内嵌函数特点是默认情况下在外部是被隐藏的，但是仍然可以通过包裹他们的函数来调用他们的，包裹的函数可以返回它内部的一个内嵌函数来在另外的范围里使用

多写函数进行联系啊 下面开始学习闭包的基础

- 全局函数是一种有名字但不会捕获任何值的闭包
- 内嵌函数是一种有名字 而且能从（上一层）父层函数捕获值的闭包
- 闭包表达式是一种轻量级语法写成的可以捕获其上下文中常量和变量没有名字的闭包





## Swift闭包的基础

```swift
// 闭包：可以在你的代码中被传递和引用的功能性独立代码块

闭包能够捕获和存储定义在其中上下文里的任何常量和变量，这就是所谓的闭合并包裹那些常量或者变量，因此被称为 闭包
Swift能够为你处理所有关于捕获的内存管理的操作  还需要手动管理内存的吗?


// 闭包表达式的使用
{
(paramList) -> return type
  in
  语句代码块
}
var reverseNames = array.sorted(by: { (s1: String, s2: String) -> Bool in
  return s1> s2 //按字典顺序逆序
})

// Swift可以从语境中进行类型推断的
var reverseNames = array.sorted(by: { s1, s2 in
  return s1> s2 //按字典顺序逆序
})

// 简洁的闭包表达式
{
(paramList)
  in
  语句代码块
  return 返回值
}

// 更简洁的闭包表达式
在Swift里 自动对行内闭包提供了简洁写法的实际参数名
你可以通过$0, $1, $2...等这样的名字应用闭包内实际参数值

// 最简洁的闭包表达式 使用了运算符函数的版本的实现
var reverseNames = array.sorted(by: {
		> //按字典顺序逆序
})

Swift和OC不太一样, OC中一般情况如果发生错误会给传入的指针赋值, 而在Swift中使用的是异常处理机制
1.以后但凡看大 throws的方法, 那么就必须进行 try处理, 而只要看到try, 就需要写上do catch
2.do{}catch{}, 只有do中的代码发生了错误, 才会执行catch{}中的代码
3. try  正常处理异常, 也就是通过do catch来处理
  try! 告诉系统一定不会有异常, 也就是说可以不通过 do catch来处理
       但是需要注意, 开发中不推荐这样写, 一旦发生异常程序就会崩溃
       如果没有异常那么会返回一个确定的值给我们

  try? 告诉系统可能有错也可能没错, 如果没有系统会自动将结果包装成一个可选类型给我们, 如果有错系统会返回nil, 如果使用try? 那么可以不通过do catch来处理
```



Swift中 尾随闭包的使用

在用很长的闭包表达式作为函数的参数传递的时候，使用尾随闭包可以加强函数代码的可读性

尾随闭包是一个被书写为函数形参列表小括号外部 紧随其后的尾部闭包的表达式

var reverseNames = array.sorted {$0> \$1} // 逆序的排序方式





### Swift 闭包 捕获值

如果一个值没有改变或在闭包外面 Swift可能会使用这个值的拷贝而不是捕获值

Swift也处理了变量的内存管理操作 当变量不再需要时会被释放

注意 ⚠️在Swift 函数和闭包都是引用类型的 它们都是引用传递的



### 逃逸闭包的使用

当闭包作为一个实际参数传递给函数的时候，并且它会在函数返回之后调用, 我们就说这个闭包逃逸了。

@escaping 可以明确闭包是允许逃逸的

应用场景 很多函数接收closure作为执行异步任务回调 闭包需要逃逸以便task异步任务执行完毕再调用

应用场景 网络请求常用逃逸闭包，当网络请求发出函数就结束了，但是网络请求成功或失败后还需使用callback闭包进行结果进一步的处理

补充：逃逸闭包必须要用self去使用类的实例中的属性名的 但是非逃逸闭包就不需要加上self关键字的



### 自动闭包

自动闭包是一种自动创建的，用来把作为实参传递给函数的表达式打包为闭包

自动闭包不接受任何实参 并且当它被调用的时候他会返回内部打包的表达式值 常用在内部框架的

自动闭包的好处在于通过 写普通表达式来代替明显的闭包而让你省略了包围在函数形参列表的花括号了

```swift
// 自动闭包常用在框架和需要闭包的 简洁语法中。让闭包传递变为表达式传递然后再打包closure

自动闭包的好处 
1让语法更简单
2自动闭包允许你延时处理操作。因此闭包内部的代码一直到你调用它的时候才会运行
对于有副作用或 占用资源的代码很有用
3因为它可以允许你控制你的代码何时才运行计算来求值

// 逃逸闭包和自动闭包的综合使用场景
var names = ["mark", "zhangsan", "lisi", "wangwu"]

// closure
let customProvider = {names.remove(at: 0)}

// 闭包么没执行
print(names.count)
//customProvider()

// 闭包的延时的处理方式
let providers:[()->String]  = []
func collectCustomerProviders(provider: @autoclosure @escapling()->String ) {
    providers.append(provider)
}

collectCustomerProviders(provider: names.remove(at: 0)) // Swift和将参数内的表达式自动打包成closure


for providerClos in providers {
    异步恰当时候的时候执行逃逸闭包
    providerClos() // 执行逃逸闭包的操作
}
```





## Swift当中常用的高阶函数

- map   flatMap 混合起来使用的
- compatMap主要作用过滤空
- filter 过滤器 foldLeft是怎么使用的
- reduce  类似中文的简化 简化版本的累加器或累计减少

复习函数编程和命令过程编程的课程





## Swift 面向对象

三大特点

- 继承
- 封装
- 多态
- 类
- 协议
- 扩展

```swift
OC中相互发送消息 或 相互协作更加的灵活的

// swift 中枚举 结构体 类 基本都是平等的。功能上都有强化的
Swift中类 枚举 结构体 都是可以定义 属性 方法和下标 构造器和嵌套类型的

注意点⚠️ 在Swift 中除了类是引用类型外 枚举和结构体都是值类型的


在项目中如果需要多个地方改变一个实例就会使用class 否则使用结构体
// 面试题 类和结构体的相似点和区别
1 都可以定义属性来储存值
2 都可以定义方法
3 都可以定义下标脚本用来允许使用下标语法来访问值
4 都可以定义初始化器来初始化
5 都可以被扩展默认没有的功能
6 遵循协议来针对特定类型提供标准功能

类的不同点
1 类允许继承另外一个类的 子类实现继承和多态的特点
2 实例的类型转换允许你在运行时检查 解释的？
3 类中才可以定义反初始化器的 dealloc释放资源
4 引用计算器允许不止一个类实例的引用。而结构体因为是值类型 所以没有引用计算器～
static修饰方法是什么意思⚠️？？？
结构体是值类型的。写时才拷贝
```





## Swift enum和基本属性的使用

```swift
// enum的新特性 switch匹配枚举 关联值和原始值
结构体和枚举是不能继承的 他们的初始化函数就很简单
// 递归枚举的使用
indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let resultExp = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

// 递归运算这个枚举

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left)+evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(resultExp))

注意点
如果你创建了一个结构体的实例并且把这个实例赋给常量，你不能修改这个实例的属性，即使是声明为变量的属性

// Lazy 懒加载的使用  第一次使用的时候才会初始化 但是多线程会出意外⚠️
lazy var importer = DataImporter()


// Swift中的计算属性类似OC 中只有getter和setter方法的属性 不存在对应的成员变量iVar
要使用var关键字修饰计算属性，当计算属性没setter 只有getter就叫只读计算属性
在计算属性当中setter的参数可以简写省略参数列表 直接使用newValue 和oldValue
getter的return可以像函数一样被省略简写 但是需要Xcode 11.0才支持这样的特性
复习单一表达式的函数的简洁语法糖！

属性观察者可以用在局部变量上也可以运用在全局变量上
// 属性的观察者
函数有 
willSet存储之前被调用
didSet存储之后被调用


使用static关键字来定义类型属性
类类型的计算属性 允许使用class关键字允许子类来重写实现

存储属性
计算属性 只读的和可读写的
lazy存储属性
类型的属性 static修饰
class修饰的类类型的属性 复习
```





## Swift中给类 结构体 枚举添加方法

大部分情况下方法中不用self 它完全指向实例的本身。你可以用self属性来在当前实例中调用它自身的方法

你不需要常在代码中写self。如果你没有显式的写出self. Swift也回在你的方法中使用已知属性或方法的时候假定你式调用了当前类实例的属性和方法的

⚠️在结构体和枚举中默认情况值类型的属性是不能被自身的实例方法修改的，因为结构体和枚举都是值类型。

需要在function中做特殊的处理的 在func前面写上mutating关键字来

复习前面数组张杰讲的mutating实现队列和栈的知识点！！！

这个关键字的功能是 让方法变为异变方法



⚠️类型方法在面试当中被问过。static写在 func关键字前，明确这是一个类型方法

static func的特点是什么  静态方法的作用是什么？

class func来允许子类来重写父类对类型方法的实现 叫做类类型的

```swift
// static func的特点是什么
它也可以使用类名来调用一个函数 但是它和class func的区别又是什么

```



## 给类添加下标的访问

类型下标的语法需要Xcode 11才能支持的



初始化与反初始化函数的使用

- 初始化器在创建特定类型的实例时被调用的

- 结构体的初始化器只需要在init(){} 内部初始化成员变量即可
- Swift为所有没提供初始化器的结构体或class提供了体格默认的初始化器来给所有的属性提供默认值
- 默认的初始化函数只是简单的创建了一个所有属性都有默认值的新实例对象

> - 所有类的存储属性(包括从它的父类继承的所有属性)都必须在初始化期间分配初始值。
>
> - Swift 为类类型定义了两种初始化器以确保所有的存储属性接收一个初始值。这些就是所谓的指定初始化器和便捷初始化 器。
>
> - 指定初始化器是类的主要初始化器。指定的初始化器可以初始化所有那个类引用的属性并且调用合适的父类初始化器来继续这个初始化过程给父类链。
>
> - 类偏向于少量指定初始化器，并且一个类通常只有一个指定初始化器。指定初始化器是初始化开始并持续初始化过程到父类链的“传送”点。
>
> - 每个类至少得有一个指定初始化器。如同在初始化器的自动继承里描述的那样，在某些情况下，这些需求通过从父类继承一个或多个指定初始化器来满足。<strong>指定初始化器可以在自动继承得到</strong>
>
> - 便捷初始化器是次要的。你可以在相同的类里定义一个便捷初始化器来调用一个指定的初始化器作为便捷初始化器来给指定 常见的第三方框架会这样写的初始化器设置默认形式参数。你也可以为具体的使用情况或输入的值类型定义一个便捷初始化器从而创建这个类的实例。
>
>   
>
> - 如果你的类不需要便捷初始化器你可以不提供它。在为通用的初始化模式创建快捷方式以节省时间或者类的初始化更加清晰明了的时候使用便捷初始化器。



为什么Extension不能添加存储属性呢？

复习扩展和协议 协议编程 POP和OOP的优缺点



扩展不能添加存储属性，因为类被实例化之后内存空间是确定的。添加存储属性需要内存空间，会改变原有的内存结构。类似的Objective-C中的分类不能添加实例变量iVar和属性的

⚠️协议扩展复习复习

协议的方法默认是required！ Swift中的协议可以多继承的

准备这方面的面试题1 1

```swift
Swift中的扩展是可以加上约束的
extension Array: TextRepresentable where Element: TextRepresentable
给每个元素用extension做的约束

协议也可以用extension来做扩展 同样可以写约束
extension Collection: TextRepresentable where Iterator: TextRepresentable

这样的好处是 协议提供了自身的extension和方法的默认实现，这样遵守这个协议就不用重复写数十遍默认的实现了
```

