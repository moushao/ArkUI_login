import ConstantSize from '../constants/ConstansSize';

@Component
export default struct ProgressEditPanel {
  @Link sliderMode: number
  @Prop slidingProgress: number
  onCancel?: () => void;
  onClickOK?: (progress: number) => void;

  build() {
    Column() {
      Row() {
        Slider({
          value: this.slidingProgress,
          style: SliderStyle.InSet,
        })
          .width("90%")
          .onChange((value: number, mode: SliderChangeMode) => {
            this.slidingProgress = Math.floor(value);
            this.sliderMode = mode;
          })
        Text(`${this.slidingProgress}%`)
          .fontSize($r('app.float.progress_font'))
          .fontWeight(500)
          .fontColor($r('app.color.dialog_progress'))
          .textAlign(TextAlign.Center)
          .margin({ left: $r('app.float.slider_margin_left') })
      }
      .width("90%")

      Row() {
        CustomButton({
          buttonText: $r('app.string.cancel')
        })
          .onClick(() => {
            if (this.onCancel !== undefined) {
              this.onCancel();
            }
          })
        CustomButton({
          buttonText: $r('app.string.confirm')
        })
          .onClick(() => {
            if (this.onClickOK !== undefined) {
              this.onClickOK(this.slidingProgress);
            }
          })
      }
      .width("70%")
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width(ConstantSize.FULL)
    .justifyContent(FlexAlign.End)
    .transition({ scale: { x: 1, y: 0 } })
    .offset({ y: -10 })
  }
}

@Component
struct CustomButton {
  @State buttonColor: Resource = $r('app.color.start_window_background');
  buttonText?: Resource;

  build() {
    Text(this.buttonText)
      .dialogButtonStyle()
      .backgroundColor(this.buttonColor)
      .borderRadius(24)
      .textAlign(TextAlign.Center)
      .onTouch((event?: TouchEvent) => {
        if (event !== undefined && event.type === TouchType.Down) {
          this.buttonColor = $r('app.color.custom_button_color');
        }
        if (event !== undefined && event.type === TouchType.Up) {
          this.buttonColor = $r('app.color.start_window_background');
        }
      })
  }
}

/**
 * Custom button style.
 */
@Extend(Text) function dialogButtonStyle() {
  .fontSize($r('app.float.button_font'))
  .padding($r('app.float.text_margin'))
  .width($r('app.float.dialog_btn_width'))
  .fontColor($r('app.color.main_blue'))
}

@Preview
@Component
struct CustomButtonPreview {
  build() {
    Column() {
      CustomButton({
        buttonText: $r('app.string.cancel')
      })
    }
  }
}

@Preview
@Component
struct ProgressEditPanelPreview {
  @State sliderMode: number = 0

  build() {
    Column() {
      ProgressEditPanel({
        slidingProgress: 70,
        onCancel: () => {
        },
        onClickOK: (progress: number): void => {
        },
        sliderMode: $sliderMode
      })
    }
  }
}