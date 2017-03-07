WBLayout
===
- 基于PureLayout的布局框架

GitHub：[weibo3721](https://github.com/weibo3721) ｜ [欢迎反馈](mailto:396803862@qq.com)


## Contents
* [Getting Started 【开始使用】](#Getting_Started)
	* [Features 【能做什么】](#Features)
* [Examples 【示例】](#Examples)

---

# <a id="Getting_Started"></a> Getting Started【开始使用】

## <a id="Features"></a> Features【能做什么】
1. WBLayout是基于PureLayout的布局框架
2. 主要用于解决布局时,View相互依赖造成布局的困难,可读性差,可拓展性差等问题
3. 一个在实际使用中很常见的例子,一个界面自上而下有5个Label,之间的间距均不同,某些情况下,某几个Label要求不显示,并且下面的Label顶上去,这时,就体现出布局之间依赖的缺点了.

# <a id="Examples"></a> Examples【示例】
```
let newView = UIView()
view.wbPinEdge(edge: .top,64).wbPinEdge(edge: .left).wbPinEdge(edge: .right).wbPinEdge(edge: .bottom)
view.wbAddLayoutView(newView: newView)
view.wbLayoutSubviews()
```

## 期待
* 欢迎Issues和PR,或者直接联系[我](mailto:396803862@qq.com)
