import ConstantColor from '../../constants/ConstansColors'
import ConstantSize from '../../constants/ConstansSize'
import TargetItem from '../../view/TargetItem'
import FooterButtonArea from '../../view/FooterButtonArea'
import TaskAddDialog from '../../dialog/TaskAddDialog'
import WorkTargetContent from '../../view/WorkTargeContent'
import { SubTargetModel } from '../../model/SubTargetModel'
import { ViewModel } from '../../viewmodel/ViewModel'

@Component
@Preview
@Entry
struct WorkTarget {
  @State clickIndex: number = -1
  @State viewModel?: ViewModel = new ViewModel()
  // 此处observe有问题,无法更新ui,先这么搞
  @State tasks: SubTargetModel[] = this.viewModel.getData()
  dialogController: CustomDialogController = new CustomDialogController({
    builder: TaskAddDialog({
      cancel: (): void => {
        console.info('Callback when the first button is clicked')
      },
      confirm: (taskName: string): void => {
        console.info(`add sub task ${taskName}`)
        this.viewModel.addTask(taskName)
        this.tasks = this.viewModel.getData()
      }
    }),
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: -20 }
  })

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
            })
          }
        }, item => JSON.stringify(SubTargetModel))
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