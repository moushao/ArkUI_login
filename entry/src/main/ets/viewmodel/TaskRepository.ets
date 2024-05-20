import { SubTargetModel } from '../model/SubTargetModel';

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
