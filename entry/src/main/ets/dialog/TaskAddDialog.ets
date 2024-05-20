import ConstantColor from '../constants/ConstansColors'
import ConstantSize from '../constants/ConstansSize'

@CustomDialog
export default struct TaskAddDialog {
  controller: CustomDialogController
  cancel: () => void
  confirm: (string) => void
  @State taskName: string = ""

  build() {
    Column({ space: 10 }) {
      Text($r("app.string.add_sub_task"))
        .fontSize($r('app.float.secondary_title'))
        .fontWeight(500)
        .width(ConstantSize.FULL)
      TextInput({ placeholder: $r('app.string.input_target_name') })
        .placeholderColor(Color.Grey)
        .placeholderFont({ size: $r('app.float.list_font') })
        .caretColor(Color.Blue)
        .backgroundColor($r('app.color.input_background'))
        .width(ConstantSize.FULL)
        .fontSize($r('app.float.list_font'))
        .fontColor($r('app.color.title_black_color'))
        .height("48fp")
        .onChange((value: string) => {
          this.taskName = value
        })
      Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceEvenly }) {
        Button($r("app.string.cancel"))
          .onClick(() => {
            this.controller.close()
            this.cancel()
          })
          .backgroundColor(0xffffff)
          .fontColor(Color.Red)
        Line({ width: 1, height: 15 })
          .backgroundColor(Color.Gray)
        Button($r("app.string.confirm"))
          .onClick(() => {
            this.controller.close()
            this.confirm(this.taskName)
          })
          .backgroundColor(0xffffff)
          .fontColor(Color.Blue)
      }
    }
    .borderRadius(32)
    .backgroundColor(Color.White)
    .width(ConstantSize.FULL)
    .padding("14fp")
  }
}

@Preview
@Component
struct TaskAddDialogPreview {
  onCancel() {
    console.info('Callback when the first button is clicked')
  }

  onAccept() {
    console.info('Callback when the second button is clicked')
  }

  build() {
    Column() {
      Blank()
      TaskAddDialog({
        cancel: this.onCancel,
        confirm: this.onAccept,
      })
    }
    .width(ConstantSize.FULL)
    .height(ConstantSize.FULL)
    .backgroundColor(ConstantColor.GREY)
  }
}