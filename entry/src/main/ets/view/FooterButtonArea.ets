import ConstantColor from '../constants/ConstansColors'
import ConstantSize from '../constants/ConstansSize'
import { SelectedModel } from '../model/SelectedModel'

@Component
export default struct FooterButtonArea {
  @Consume isEditMode: boolean
  @ObjectLink selectedMode: SelectedModel
  onAddClick?: () => void
  onDeleteClick?: () => void

  build() {
    Column() {
      if (this.isEditMode) {
        Button($r('app.string.delete_button'))
          .opacity(this.selectedMode.hasSelect ? 1 : 0.4)
          .operateButtonStyle($r('app.color.main_red'))
          .enabled(this.selectedMode.hasSelect)
          .onClick(() => {
            this.onDeleteClick()
          })
      } else {
        Button($r('app.string.add_sub_task'))
          .operateButtonStyle($r('app.color.main_blue'))
          .onClick(() => {
            if (this.onAddClick !== undefined) {
              this.onAddClick()
            }
          })
      }
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

@Component
@Preview
struct 删除不可用 {
  @Provide isEditMode: boolean = true
  @State selectedMode: SelectedModel = new SelectedModel(true)
  @State selectedMode2: SelectedModel = new SelectedModel(true)
  onAddClick?: () => void

  aboutToAppear() {
    this.selectedMode2.hasSelect = true
  }

  build() {
    Column({ space: 10 }) {
      FooterButtonArea({
        selectedMode: this.selectedMode
      })

      FooterButtonArea({
        selectedMode: this.selectedMode2
      })
    }
  }
}


@Component
@Preview
struct 添加子目标 {
  @Provide isEditMode: boolean = false
  @State selectedMode: SelectedModel = new SelectedModel(true)
  onAddClick?: () => void

  build() {
    FooterButtonArea({
      selectedMode: this.selectedMode
    })
  }
}