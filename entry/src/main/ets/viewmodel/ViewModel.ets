import promptAction from '@ohos.promptAction';
import { SelectedModel } from '../model/SelectedModel';
import { SubTargetModel, SubTargetModelArray } from '../model/SubTargetModel';
import getCurrentTime from '../utils/DateUtil';
import { TaskRepository } from './TaskRepository';

@Observed
export class ViewModel {
  private taskRepository = new TaskRepository()
  public selectedMode = new SelectedModel()

  public getData(): SubTargetModelArray {
    return this.taskRepository.getData();
  }

  public getAllTaskCount(): number {
    return this.getData().length
  }

  public getCompleteTaskCount(): number {
    return this.getData().filter((item) => {
      return item.progress === 100
    }).length
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
    let dataLen = this.taskRepository.tasks.length - 1
    for (let i = dataLen; i >= 0; i--) {
      if (this.selectedMode.itemIsChecked(i)) {
        this.taskRepository.deleteTask(i)
      }
    }
  }
}