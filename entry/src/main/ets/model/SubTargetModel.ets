
@Observed
export class SubTargetModel {
  taskName: string
  updateData: string
  progress: number

  constructor(taskName: string, updateData: string, progress: number) {
    this.taskName = taskName;
    this.updateData = updateData;
    this.progress = progress;
  }
}

