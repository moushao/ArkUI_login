import ConstantColor from '../constants/ConstansColors'
import ConstantCommon from '../constants/ConstansCommon'
import ConstantSize from '../constants/ConstansSize'
import { SelectedModel } from '../model/SelectedModel'
import { SubTargetModel } from '../model/SubTargetModel'
import getCurrentTime from '../utils/DateUtil'
import ProgressEditPanel from './ProgressEditPanel'

@Component
export default struct TargetItem {
  @Consume isEditMode: boolean
  @State target: SubTargetModel = null
  @State latestProgress: number = 0
  @State sliderMode: number = -1
  @State index: number = 0;
  @Link @Watch("clickIndexChanged") clickIndex: number
  @State isExpanded: boolean = false
  @ObjectLink selectedMode: SelectedModel
  @Consume taskProgressChanged:boolean
  aboutToAppear() {
    this.latestProgress = this.target.progress
  }

  clickIndexChanged() {
    this.isExpanded = this.index === this.clickIndex
  }

  build() {
    Row() {
      Column() {
        Row() {
          Text(this.target.taskName).padding(10)
          Blank()
          Column() {
            Text(`${this.target.progress}%`)
              .padding({ right: 10, top: 10 })
              .fontSize($r('app.float.list_font'))
              .fontColor($r('app.color.title_black_color'))
            Text(`更新时间:${this.target.updateData}`)
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
            sliderMode: $sliderMode,
            onClickOK: (progress: number): void => {
              this.isExpanded = false;
              this.latestProgress = progress
              this.target.progress = progress
              this.target.updateData = getCurrentTime()
              this.taskProgressChanged = !this.taskProgressChanged
            }
          })
        }
      }
      .layoutWeight(1)

      if (this.isEditMode) {
        Checkbox()
          .select(this.selectedMode.itemIsChecked(this.index))
          .selectedColor($r('app.color.main_blue'))
          .width(20)
          .margin({ right: 10 })
          .onChange((isChecked:boolean)=>{
            this.selectedMode.itemSelectChanged(this.index,isChecked)
          })
      }
    }
    .backgroundColor(Color.White)
    .borderRadius(12)
    .onClick(() => {
      if (this.isEditMode) {
        return
      }
      this.isExpanded = !this.isExpanded
      this.clickIndex = this.index
    })
  }
}

@Preview
@Component
struct TargetItemNotExpand {
  @State clickIndex: number = ConstantCommon.DEFAULT_CLICKED_INDEX
  @Provide isEditMode: boolean = true
  @State selectedMode: SelectedModel = new SelectedModel(true)

  build() {
    TargetItem({
      target: new SubTargetModel("早起晨练", "2023/02/09", 40),
      index: 0,
      clickIndex: $clickIndex,
      selectedMode: this.selectedMode
    })
  }
}


@Preview
@Component
struct TargetItemExpanded {
  @State clickIndex: number = 0
  @Provide isEditMode: boolean = true
  @State selectedMode: SelectedModel = new SelectedModel(true)

  build() {
    TargetItem({
      target: new SubTargetModel("早起晨练", "2023/02/09", 70),
      index: 0,
      clickIndex: $clickIndex,
      selectedMode: this.selectedMode
    })
  }
}