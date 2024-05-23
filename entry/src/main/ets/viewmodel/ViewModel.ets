import promptAction from '@ohos.promptAction';
import { SubTargetModel, SubTargetModelArray } from '../model/SubTargetModel';
import getCurrentTime from '../utils/DateUtil';
import { TaskRepository } from './TaskRepository';

export class ViewModel {
  private taskRepository = new TaskRepository()

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
}
