import ConstantSize from '../constants/ConstansSize'
@Component
export default struct InputArea {
  @Prop title: string
  @Link content: string
  @Prop isSecret: boolean

  build() {
    Column() {

      Row() {
        Text(this.title)
          .fontSize(14)
          .fontColor("#5a5a5a")
          .fontWeight(FontWeight.Medium)

        TextInput({
          text: this.content,
        })
          .backgroundColor("#00000000")
          .onChange((value: string) => {
            this.content = value
          })
          .layoutWeight(1)
          .type(this.isSecret ? InputType.Password : InputType.Normal)
      }
      .width(ConstantSize.FULL)
      .padding({ top: 5, bottom: 5 })

      Line()
        .width(ConstantSize.FULL)
        .height(1)
        .backgroundColor($r('app.color.line_color'))
    }.width(ConstantSize.FULL)
  }
}

@Preview
@Component
struct InputAreaPreview {
  @State title: string = "账户"
  @State account: string = ""
  @State passWord: string = ""

  build() {
    Row() {
      InputArea({
        title: this.title,
        content: this.account,
        isSecret: true
      })
    }.width(ConstantSize.FULL)
  }
}