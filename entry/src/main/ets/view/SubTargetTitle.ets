import ConstantColor from '../constants/ConstansColors'
import ConstantCommon from '../constants/ConstansCommon'
import ConstantSize from '../constants/ConstansSize'
import { SelectedModel } from '../model/SelectedModel'

@Component
export default struct SubTargetTitle {
  @Link clickIndex: number
  @ObjectLink selectedMode: SelectedModel
  @Consume isEditMode: boolean
  @Prop isShowEditModel: boolean
  onAddClick?: () => void

  build() {
    Row() {
      Text($r("app.string.work_target_sub"))
        .fontSize(22)
        .fontWeight(FontWeight.Bolder)

      Blank()
      if (this.isEditMode) {
        Text($r('app.string.cancel'))
          .operateTextStyle(() => {
            this.isEditMode = false
            this.selectedMode.revertAll(false)
          })

        Text($r('app.string.select_all_button'))
          .operateTextStyle(() => {
            if (this.onAddClick !== undefined) {
              this.onAddClick()
            }
          })
          .margin({ left: 20 })
        Checkbox()
          .select(this.selectedMode.isAllSelected)
          .selectedColor($r('app.color.main_blue'))
          .width(20)
          .onClick(() => {
            this.selectedMode.revertAll(!this.selectedMode.isAllSelected)
          })
      } else if (this.isShowEditModel) {
        Text($r('app.string.edit_button'))
          .operateTextStyle(() => {
            this.isEditMode = !this.isEditMode
            this.clickIndex = ConstantCommon.DEFAULT_CLICKED_INDEX
          })
      }
    }
    .alignSelf(ItemAlign.Center)
    .alignItems(VerticalAlign.Center)
    .width(ConstantSize.FULL)
    .backgroundColor(ConstantColor.BACKGROUND_INDEX)
    .margin({ top: 10 })
  }
}

@Extend(Text) function operateTextStyle(event: (event?: ClickEvent) => void) {
  .height($r('app.float.button_height'))
  .fontSize($r('app.float.button_font'))
  .fontWeight(500)
  .fontColor($r('app.color.main_blue'))
  .onClick(() => {
    event()
  })
}

@Preview
@Component
struct SubTargetTitlePreview {
  @Provide isEditMode: boolean = false
  @State isAllSelected: boolean = false
  @State selectedMode: SelectedModel = new SelectedModel()
  @State clickIndex: number = ConstantCommon.DEFAULT_CLICKED_INDEX

  build() {
    SubTargetTitle({
      clickIndex: $clickIndex,
      selectedMode: this.selectedMode,
      isShowEditModel: true
    })
  }
}

@Preview
@Component
struct SubTargetTitleIsEditPreview {
  @Provide isEditMode: boolean = true
  @State isAllSelected: boolean = false
  @State selectedMode: SelectedModel = new SelectedModel(true)
  @State clickIndex: number = ConstantCommon.DEFAULT_CLICKED_INDEX

  build() {
    SubTargetTitle({
      clickIndex: $clickIndex,
      selectedMode: this.selectedMode,
      isShowEditModel: true
    })
  }
}