@Component
export default struct ThirdLogMethod {
  build() {
    Column() {
      Text("其他登录方式")
        .fontSize(12)
        .fontColor("#5a5a5a")
        .fontWeight(FontWeight.Medium)
      Row() {
        Button('方式一', { type: ButtonType.Circle, stateEffect: false })
          .backgroundColor(0x317aff)
          .fontSize(10)
          .padding(0)

        Button('方式2', { type: ButtonType.Circle, stateEffect: false })
          .backgroundColor(0x317aff)
          .fontSize(10)
          .padding(0)
        Button('方式3', { type: ButtonType.Circle, stateEffect: false })
          .backgroundColor(0x317aff)
          .fontSize(10)
          .padding(0)
      }.width("100%").justifyContent(FlexAlign.SpaceEvenly).margin({top:10})
    }.width("100%")
    .padding({top:10, bottom:20})
  }
}

@Preview
@Component
struct ThirdLogMethodPreview {
  @State title: string = "账户"
  @State account: string = ""
  @State passWord: string = ""

  build() {
    Row() {
      ThirdLogMethod()
    }.width("100%")
  }
}