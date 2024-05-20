import ConstantColor from '../constants/ConstansColors'
import ConstantSize from '../constants/ConstansSize'
import { SubTargetModel } from '../model/SubTargetModel'
import ProgressEditPanel from './ProgressEditPanel'

@Component
@Preview
export default struct TargetItem {
  private target?: SubTargetModel
  @State isExpanded: boolean = false
  @State latestProgress: number = 0
  @State sliderMode: number = -1
  @State index: number = 0;

  build() {
    Column() {
      Row() {
        Text(this.target?.taskName).padding(10)
        Blank()
        Column() {
          Text(`${this.target?.progress}%`)
            .padding({ right: 10, top: 10 })
            .fontSize($r('app.float.list_font'))
            .fontColor($r('app.color.title_black_color'))
          Text(`更新时间:${this.target?.updateData}`)
            .fontSize(13)
            .padding({ right: 10, top: 2, bottom: 10 })
            .fontColor(ConstantColor.GREY_DARK)
        }
        .alignItems(HorizontalAlign.End)
      }.width(ConstantSize.FULL)

      if (this.isExpanded) {
        ProgressEditPanel({
          slidingProgress: this.latestProgress,
          onCancel: () => this.isExpanded = false,
          onClickOK: (progress: number): void => {
            this.isExpanded = false;
          },
          sliderMode: $sliderMode
        })
          .width(ConstantSize.FULL)
          .transition({ scale: { x: 1, y: 0 } })
      }
    }
    .width(ConstantSize.FULL)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .onClick(() => {
      console.log("onClicked")
      this.isExpanded = !this.isExpanded
    })
  }
}