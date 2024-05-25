import ConstantColor from '../../constants/ConstansColors'
import ConstantSize from '../../constants/ConstansSize'
import TargetItem from '../../view/TargetItem'
import FooterButtonArea from '../../view/FooterButtonArea'
import TaskAddDialog from '../../dialog/TaskAddDialog'
import WorkTargetContent from '../../view/WorkTargeContent'
import { SubTargetModel, SubTargetModelArray } from '../../model/SubTargetModel'
import { ViewModel } from '../../viewmodel/ViewModel'
import ConstantCommon from '../../constants/ConstansCommon'
import SubTargetTitle from '../../view/SubTargetTitle'
import getCurrentTime from '../../utils/DateUtil'

@Component
@Preview
@Entry
struct WorkTarget {
  @State clickIndex: number = ConstantCommon.DEFAULT_CLICKED_INDEX
  @State viewModel: ViewModel = new ViewModel()
  @State tasks: SubTargetModelArray = null
  @Provide isEditMode: boolean = false
  @State isHasSelected: boolean = false
  @State totalTasksNumber: number = 0;
  @State completedTasksNumber: number = 0;
  @Provide latestUpdateDate: string = ""
  @Provide @Watch("onProgressChanged") taskProgressChanged: boolean = false
  dialogController: CustomDialogController = new CustomDialogController({
    builder: TaskAddDialog({
      cancel: (): void => {
        console.info('Callback when the first button is clicked')
      },
      confirm: (taskName: string): void => {
        this.clickIndex = ConstantCommon.DEFAULT_CLICKED_INDEX
        this.viewModel.addTask(taskName)
        this.onProgressChanged()
      }
    }),
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: -20 }
  })

  onProgressChanged() {
    this.latestUpdateDate = getCurrentTime()
    this.totalTasksNumber = this.viewModel.getAllTaskCount()
    this.completedTasksNumber = this.viewModel.getCompleteTaskCount()
  }

  aboutToAppear() {
    this.tasks = this.viewModel.getData()
    this.isHasSelected = this.viewModel.selectedMode.hasSelect
    this.latestUpdateDate= this.tasks[this.tasks.length-1].updateData
  }

  build() {
    Column() {
      List({ space: 10 }) {
        ListItem() {
          Text($r("app.string.work_target_title")).TargetTitleStyle(26)
        }

        ListItem() {
          WorkTargetContent({
            totalTasksNumber: this.totalTasksNumber,
            completedTasksNumber: this.completedTasksNumber,
          }
          )
        }

        ListItem() {
          SubTargetTitle({
            clickIndex: $clickIndex,
            selectedMode: this.viewModel.selectedMode,
            isShowEditModel: this.tasks.length !== 0
          })
        }

        ForEach(this.tasks, (item: SubTargetModel, index: number | undefined) => {
          ListItem() {
            TargetItem({
              target: item,
              index: index,
              clickIndex: $clickIndex,
              selectedMode: this.viewModel.selectedMode
            })
          }
        })
      }
      .height(0)
      .width(ConstantSize.FULL)
      .layoutWeight(1)

      FooterButtonArea({
        selectedMode: this.viewModel.selectedMode,
        onAddClick: (): void => {
          this.dialogController.open()
        },
        onDeleteClick: (): void => {
          this.isEditMode = false
          this.viewModel.deleteTask()
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