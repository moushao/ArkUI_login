/**
 * 尝试使用相对布局来写这个控件
 * 1:约束规则的锚定位置,并不会带上锚定目标的margin
 * 2:每一个控件都需要写alignRules,数量一旦多了,反而增加了编码量
 * 3:RelativeContainer使用padding无效?
 * 4:子控件可以随意超出父布局size
 * 5:使用RelativeContainer必须指定宽高
 */
import ConstantSize from '../constants/ConstansSize'
@Component
@Preview
export default struct WorkTargetContent {
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
    .width(ConstantSize.FULL)
    .height(190)
    .backgroundColor(Color.White)
    .border({ color: Color.White, style: BorderStyle.Solid, radius: 12 })
  }
}