import router from '@ohos.router'
import ConstantColor from '../constants/ConstansColors'
import ConstantSize from '../constants/ConstansSize'
import InputArea from './InputArea'
import ThirdLogMethod from './ThirdLogMethod'

@Entry
@Component
struct Login {
  @State message: string = 'Hello World'
  @State account: string = ""
  @State passWord: string = ""

  build() {
    Column({ space: 10 }) {
      Image($r("app.media.icon"))
        .size({ width: 100, height: 100 })
        .margin({ top: 40 })
      Text($r("app.string.login_page_label"))
        .fontSize(26)
        .fontWeight(FontWeight.Medium)
      Text($r("app.string.login_more_service"))
        .fontSize(14)
        .fontColor("#5a5a5a")
        .fontWeight(FontWeight.Medium)
      Column() {
        InputArea({
          title: "账户",
          content: $account,
          isSecret: false
        })
        InputArea({
          title: "密码",
          content: $passWord,
          isSecret: true
        })
      }

      Row() {
        Text($r("app.string.login_verify_with_code"))
          .fontSize(14)
          .fontColor("#4455ff")
          .fontWeight(FontWeight.Medium)
          .onClick((event) => {

          })
        Text($r("app.string.forget"))
          .fontSize(14)
          .fontColor(ConstantColor.BLUE)
          .fontWeight(FontWeight.Medium)
          .onClick((event) => {

          })
      }
      .margin({ top: 20 })
      .width(ConstantSize.FULL)
      .justifyContent(FlexAlign.SpaceBetween)

      Button($r("app.string.login")).backgroundColor(ConstantColor.BLUE).width(ConstantSize.FULL).margin({ top: 60 })
        .onClick((event) => {
          if (this.account.length == 0 || this.passWord.length == 0) {
            console.info('account and password cannot be empty')
            console.info(this.account)
            console.info(this.passWord)
            return
          }
          jumpToWorkTarget()
        })
      Text($r("app.string.register_account"))
        .fontSize(14)
        .fontColor(ConstantColor.BLUE)
        .fontWeight(FontWeight.Medium)
        .onClick((event) => {

        })
      Blank()
      ThirdLogMethod()
    }
    .backgroundColor(ConstantColor.GREY)
    .padding(24)
    .alignItems(HorizontalAlign.Center)
    .width(ConstantSize.FULL)
    .height('100%')
  }
}

function jumpToWorkTarget(): void {
  router.pushUrl({
    url: 'pages/target/WorkTarget'
  }, router.RouterMode.Standard, (err) => {
    if (err) {
      console.error(`Invoke pushUrl failed, code is ${err.code}, message is ${err.message}`);
      return;
    }
    console.info('Invoke pushUrl succeeded.');
  });
}