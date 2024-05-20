import ConstantColor from '../constants/ConstansColors'
import ConstantSize from '../constants/ConstansSize'

@Component
@Preview
export default struct FooterButtonArea {
  onAddClick?: () => void

  build() {
    Column() {
      Button($r('app.string.add_sub_task'))
        .operateButtonStyle($r('app.color.main_blue'))
        .onClick(() => {
          if (this.onAddClick !== undefined) {
            this.onAddClick()
          }
        })
    }
    .width(ConstantSize.FULL)
    .backgroundColor(ConstantColor.BACKGROUND_INDEX)
    .padding(15)
  }
}

@Extend(Button) function operateButtonStyle(color: Resource) {
  .width($r('app.float.button_width'))
  .height($r('app.float.button_height'))
  .fontSize($r('app.float.button_font'))
  .fontWeight(500)
  .fontColor(color)
  .backgroundColor($r('app.color.button_background'))
}