import ConstantColor from '../../constants/ConstansColors'
import ConstantSize from '../../constants/ConstansSize'
import TargetItem from '../../view/TargetItem'
import FooterButtonArea from '../../view/FooterButtonArea'
import TaskAddDialog from '../../dialog/TaskAddDialog'
import WorkTargetContent from '../../view/WorkTargeContent'
import { SubTargetModel, SubTargetModelArray } from '../../model/SubTargetModel'
import { ViewModel } from '../../viewmodel/ViewModel'
import ConstantCommon from '../../constants/ConstansCommon'

@Component
@Preview
@Entry
struct WorkTarget {
  @State clickIndex: number = ConstantCommon.DEFAULT_CLICKED_INDEX
  @State viewModel: ViewModel = new ViewModel()
  @State tasks: SubTargetModelArray = null
  dialogController: CustomDialogController = new CustomDialogController({
    builder: TaskAddDialog({
      cancel: (): void => {
        console.info('Callback when the first button is clicked')
      },
      confirm: (taskName: string): void => {
        console.info(`add sub task ${taskName}`)
        this.viewModel.addTask(taskName)
      }
    }),
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: -20 }
  })

  aboutToAppear() {
    this.tasks = this.viewModel.getData()
  }

  build() {
    Column() {
      List({ space: 10 }) {
        ListItem() {
          Text($r("app.string.work_target_title")).TargetTitleStyle(26)
        }

        ListItem() {
          WorkTargetContent()
        }

        ListItem() {
          Text($r("app.string.work_target_sub")).TargetTitleStyle(22).margin({ top: 10 })
        }

        ForEach(this.tasks, (item: SubTargetModel, index: number | undefined) => {
          ListItem() {
            TargetItem({
              target: item,
              index: index,
              clickIndex: $clickIndex,
            })
          }
        })
      }
      .height(0)
      .width(ConstantSize.FULL)
      .layoutWeight(1)

      FooterButtonArea({
        onAddClick: (): void => {
          this.dialogController.open()
        }
      })
    }
    .width(ConstantSize.FULL)
    .height(ConstantSize.FULL)
    .size({ width: ConstantSize.FULL, height: ConstantSize.FULL })
    .padding({ left: 10, right: 10, top: 20 })
    .backgroundColor(ConstantColor.BACKGROUND_INDEX)
  }
}

@Extend(Text) function TargetTitleStyle(size: number) {
  .fontSize(size)
  .fontWeight(FontWeight.Bolder)
}