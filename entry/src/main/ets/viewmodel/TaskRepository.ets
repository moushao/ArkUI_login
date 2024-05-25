import { SubTargetModel, SubTargetModelArray } from '../model/SubTargetModel';

@Observed
export class TaskRepository {
  public tasks: SubTargetModelArray = new SubTargetModelArray(
    new SubTargetModel("早起晨练", "2023/02/09 14:15:20", 40),
    new SubTargetModel("准备早餐", "2023/02/10 14:15:23", 70),
  )

  constructor() {
  }

  public getData(): SubTargetModel[] {
    return this.tasks;
  }

  public addTask(task: SubTargetModel) {
    this.tasks.push(task)
  }

  public updateTask(index: number, task: SubTargetModel) {
    if (this.tasks.length < index) {
      return
    }
    this.tasks[index] = task
  }

  public deleteTask(index: number) {
    this.tasks.splice(index, 1)
  }
}
