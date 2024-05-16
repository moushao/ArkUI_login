import ConstantColor from '../../constants/ConstansColors'
import ConstantSize from '../../constants/ConstansSize'
import TitleModel from '../../model/TitleModel'
import DataModel from './DataModel'
import TargetItem from './TargetItem'

@Component
@Preview
struct WorkTargetTitle {
  @State attr: TitleModel = new TitleModel($r("app.string.work_target_title"), 26)

  build() {
    Text(this.attr.title)
      .fontSize(this.attr.size)
      .fontWeight(FontWeight.Bolder)
  }
}

/**
 * 尝试使用相对布局来写这个控件
 * 1:约束规则的锚定位置,并不会带上锚定目标的margin
 * 2:每一个控件都需要写alignRules,数量一旦多了,反而增加了编码量
 * 3:RelativeContainer使用padding无效?
 * 4:子控件可以随意超出父布局size
 * 5:使用RelativeContainer必须指定宽高
 */
@Component
@Preview
struct WorkTargetContent {
  build() {
    RelativeContainer() {
      Image($r("app.media.target"))
        .alignRules({
          top: { anchor: '__container__', align: VerticalAlign.Top },
          left: { anchor: '__container__', align: HorizontalAlign.Start }
        })
        .margin(10)
        .border({ radius: 8 })
        .size({ width: 120, height: 100 })
        .id("image")
      Text($r("app.string.work_target_first_target"))
        .alignRules({
          top: { anchor: 'image', align: VerticalAlign.Top },
          left: { anchor: 'image', align: HorizontalAlign.End }
        })
        .fontSize(18)
        .fontWeight(FontWeight.Bolder)
        .margin({ top: 20 })
        .id("title")
      Text($r("app.string.work_target_first_content"))
        .alignRules({
          top: { anchor: 'title', align: VerticalAlign.Bottom },
          left: { anchor: 'title', align: HorizontalAlign.Start }
        })
        .fontSize(12)
        .margin({ top: 10 })
        .fontColor($r("app.color.grey_dark"))
        .id("subTitle")
      Text($r("app.string.work_target_progess"))
        .alignRules({
          top: { anchor: 'image', align: VerticalAlign.Bottom },
          left: { anchor: 'image', align: HorizontalAlign.Start }
        })
        .margin({ left: 10 })
        .fontWeight(FontWeight.Bolder)
        .id("progess")
      Text($r("app.string.work_target_update_time"))
        .alignRules({
          top: { anchor: 'progess', align: VerticalAlign.Bottom },
          left: { anchor: 'image', align: HorizontalAlign.Start }
        })
        .fontSize(12)
        .margin({ left: 10, top: 5 })
        .fontColor($r("app.color.grey_dark"))
        .id("updateTime")
      Text("03/26/2024 19:59:59")
        .alignRules({
          top: { anchor: 'updateTime', align: VerticalAlign.Bottom },
          left: { anchor: 'image', align: HorizontalAlign.Start }
        })
        .margin({ left: 10, top: 5 })
        .fontSize(12)
        .id("time")

      Button({ type: ButtonType.Circle, stateEffect: false }) {
        Text("0/0")
          .fontSize(12)
      }
      .alignRules({
        bottom: { anchor: 'time', align: VerticalAlign.Bottom },
        right: { anchor: '__container__', align: HorizontalAlign.End }
      })
      .size({ width: 35, height: 35 })
      .fontColor($r("app.color.grey_dark"))
      .backgroundColor(Color.White)
      .border({ width: 2, color: $r("app.color.line_color"), style: BorderStyle.Solid })
      .id("progessBar")
      .margin({ right: 10 })
    }
    .width("100%")
    .height(190)
    .backgroundColor(Color.White)
    .border({ color: Color.White, style: BorderStyle.Solid, radius: 12 })
  }
}

@Component
@Preview
@Entry
struct WorkTarget {
  @State subTargets: Array<string> = []

  aboutToAppear() {
    this.subTargets = DataModel.getData()
  }

  build() {
    List({ space: 10 }) {
      ListItem() {
        WorkTargetTitle({ attr: new TitleModel($r("app.string.work_target_title"), 26) })
      }

      ListItem() {
        WorkTargetContent()
      }

      ListItem() {
        WorkTargetTitle({ attr: new TitleModel($r("app.string.work_target_sub"), 22) })
      }

      ForEach(this.subTargets, (item: string) => {
        ListItem() {
          TargetItem({ target: item })
        }
      }, item => item)
    }
    .width('100%')
    .height("100%")
    .size({ width: ConstantSize.FULL, height: ConstantSize.FULL })
    .padding({ left: 10, right: 10, top: 20 })
    .backgroundColor(ConstantColor.GREY)
  }
}