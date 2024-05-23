import { SubTargetModel, SubTargetModelArray } from '../model/SubTargetModel';

@Observed
export class TaskRepository {
  public tasks: SubTargetModelArray = new SubTargetModelArray(
    new SubTargetModel("早起晨练", "2023/02/09", 40),
    new SubTargetModel("准备早餐", "2023/02/10", 70),
  )

  public getData(): SubTargetModel[] {
    return this.tasks;
  }

  constructor() {
  }

  public addTask(task: SubTargetModel) {
    this.tasks.push(task)
    console.log(`${this.tasks}`)
  }

  public updateTask(index: number, task: SubTargetModel) {
    if (this.tasks.length < index) {
      console.log(`invalid task length`)
      return
    }
    this.tasks[index] = task
  }
}
