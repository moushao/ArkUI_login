import promptAction from '@ohos.promptAction';
import { SubTargetModel } from '../model/SubTargetModel';
import getCurrentTime from '../utils/DateUtil';
import { TaskRepository } from './TaskRepository';

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
