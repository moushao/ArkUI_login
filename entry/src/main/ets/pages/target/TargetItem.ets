import ConstantColor from '../../constants/ConstansColors'
@Component
@Preview
export default struct TargetItem {
  @State target:string = ""
  build() {
    Row() {
      Text(this.target).padding(10)
      Blank()
      Column() {
        Text("0%")
          .padding({ right:10 ,top:10})
          .fontWeight(FontWeight.Bold)
        Text("更新时间:2023/02/99")
          .fontSize(13)
          .padding({ right:10 ,top:2,bottom:10})
          .fontColor($r("app.color.grey_dark"))
      }
      .alignItems(HorizontalAlign.End)
    }
    .width("100%")
    .backgroundColor(Color.White)
    .borderRadius(8)
  }
}