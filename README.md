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

## 碎碎念:
- 定义的常量需要指定类型,否则不生效,比如:```static readonly GREY_DARK: Resource  = $r("app.color.grey_dark") 需要指定Resource类型```
- 官方说Dialog的默认显示位置在底部,即:```DialogAlignment.Default```,又是忽悠人的,显示在底部需设置```DialogAlignment.Bottom```
- 字符串的拼接必须使用 ``,如:`${xxx} what`,使用 ' ' 或者  " "  都不生效
  