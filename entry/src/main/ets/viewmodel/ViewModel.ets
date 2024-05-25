import promptAction from '@ohos.promptAction';
import ConstantCommon from '../constants/ConstansCommon';
import { SelectedModel } from '../model/SelectedModel';
import { SubTargetModel, SubTargetModelArray } from '../model/SubTargetModel';
import getCurrentTime from '../utils/DateUtil';
import { TaskRepository } from './TaskRepository';

@Observed
export class ViewModel {
  private taskRepository = new TaskRepository()
  public selectedMode = new SelectedModel()

  constructor() {
  }

  public getData(): SubTargetModelArray {
    return this.taskRepository.getData();
  }

  public updateTask(index: number, task: SubTargetModel) {
    this.taskRepository.updateTask(index, task)
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

  public deleteTask() {
    console.log("deleteTask")

    const newTasks = new SubTargetModelArray()
    this.taskRepository.tasks.forEach((item, index) => {
      if (!this.selectedMode.itemIsChecked(index)) {
        newTasks.push(item)
      }
    })
    console.log("shit:" + `${newTasks}`)

    let dataLen = this.taskRepository.tasks.length - 1
    for (let i = dataLen; i >= 0; i--) {
      if (this.selectedMode.itemIsChecked[i]) {
        // this.taskRepository.tasks.splice(i, 1);
        this.taskRepository.deleteTask(i)
      }
    }


    // this.taskRepository.tasks = new SubTargetModelArray(
    //   new SubTargetModel("准备sdf早餐", "2023/02/10", 70),
    // )
    // console.log("什么鬼:"+`${this.taskRepository.tasks}`)
  }
}