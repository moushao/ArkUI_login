/**
 * example文件,用于测试过官方示例
 */
import promptAction from '@ohos.promptAction';
import ConstantColor from '../constants/ConstansColors';
import ConstantSize from '../constants/ConstansSize';
import TaskAddDialog from '../dialog/TaskAddDialog';
import { SubTargetModel } from '../model/SubTargetModel';
import getCurrentTime from '../utils/DateUtil';
import FooterButtonArea from '../view/FooterButtonArea';
import TargetItem from '../view/TargetItem';

@Observed
export class TaskRepository {
  private tasks: SubTargetModel[] = [
    new SubTargetModel("早起晨练", "2023/02/09", 40),
    new SubTargetModel("准备早餐", "2023/02/10", 70),
  ]

  public getData(): SubTargetModel[] {
    return this.tasks;
  }

  constructor() {
  }

  public addTask(task: SubTargetModel) {
    const newTasks = this.tasks.concat(task)
    this.tasks = newTasks
    console.log(`${this.tasks}`)
  }
}


@Observed
export class ViewModel {
  private taskRepository = new TaskRepository()

  constructor() {
  }

  public getData(): Array<SubTargetModel> {
    return this.taskRepository.getData();
  }

  public addTask(taskName: string) {
    if (taskName === '') {
      promptAction.showToast({
        message: $r('app.string.cannot_input_empty'),
        duration: 300,
        bottom: 60
      });
      return
    }

    this.taskRepository.addTask(new SubTargetModel(taskName, getCurrentTime(), 0))
  }
}

@Component
@Preview
@Entry
struct WorkTarget {
  @State clickIndex: number = -1
  @State viewModel: ViewModel = new ViewModel()
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

  build() {
    Column() {
      List({ space: 10 }) {

        ForEach(this.viewModel.getData(), (item: SubTargetModel, index: number | undefined) => {
          ListItem() {
            TargetItem({
              target: item,
              index: index,
            })
          }
        }, item => `${item.taskName}`)
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