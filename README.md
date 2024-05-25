# ArkUI_login

## 1.关于约束布局的几点说明
```
1. 约束规则的锚定位置,并不会带上锚定目标的margin 
2. 每一个控件都需要写alignRules,数量一旦多了,反而增加了编码量 
3. RelativeContainer使用padding无效? 
4. 子控件可以随意超出父布局size 
5. 使用RelativeContainer必须指定宽高
```

## 2. 控件在Preview中点击事件的响应
```
如果先在preview中实现控件的onClick事件,只能相应@Entry级别的@preview,如TargetItem中点击展开和关闭的事件相应,
只能在WorkTarget控件中响应,因为当前界面只有WorkTarget才是@Entry 

@Component
@Preview
@Entry
struct WorkTarget
```
## 多层嵌套属性
- 多层嵌套属性,且最终ui落地到Object的属性上时,子组件需要用状态管理器接受此属性,否则不会自动更新
- 数组等容器是否需要对象包裹,比如用 **SubTargetModelArray** 替代 **Array<SubTargetModelArray>**,否则以下反例代码(是否)的最终不会刷新界面
  是因为指向的对象本身是Array,而Array本身并没有被Observe?
  ```
  反例:
  SubTargetModelArray task = []
  或者: Array<SubTargetModel> task = []
  正例:
  SubTargetModelArray task = new SubTargetModelArray()
  ``` 
- 为什么传入子组件的值不能多层嵌套,比如:
  ```
  @State isHasSelected: boolean = false
  
  aboutToAppear() {
    this.tasks = this.viewModel.getData()
    this.isHasSelected = this.viewModel.selectedMode.hasSelect
  }
  
  FooterButtonArea({
        isHasSelected: this.isHasSelected,
        ...
      })
  
  此处传给FooterButtonArea的isHasSelected值, 当this.viewModel.selectedMode.hasSelect值改变时,并不会引起子组件的刷新.
  但如果传入的是selectedMode就可以:
  FooterButtonArea({
        selectedMode: this.viewModel.selectedMode,
        ...
      })
  
  如此已经造成selectedMode滥用, ui与业务耦合了
  ```
  

## 关于装饰器的几个疑问 
- @Preview
  - 所有不能子控件里不能直接初始化的的装饰器,子控件皆不能直接带上 **@Preview** 注解进行预览,如 **@Link、@Consume**
- 状态装饰器,是否只能用于组件中,非组件中使用装饰器就会有问题

## 碎碎念:
- 定义的常量需要指定类型,否则不生效,比如:```static readonly GREY_DARK: Resource  = $r("app.color.grey_dark") 需要指定Resource类型```
- 官方说Dialog的默认显示位置在底部,即:```DialogAlignment.Default```,又是忽悠人的,显示在底部需设置```DialogAlignment.Bottom```
- 字符串的拼接必须使用 ``,如:`${xxx} what`,使用 ' ' 或者  " "  都不生效
  