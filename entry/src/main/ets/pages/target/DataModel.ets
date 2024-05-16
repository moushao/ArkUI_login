export class DataModel {
  private tasks: Array<string> = [
    "早起晨练",
    "准备早餐",
    "阅读名著",
    "学习ArkTS",
    "看剧放松",
    "早起晨练1",
    "准备早餐1",
    "阅读名著1",
    "学习ArkTS1",
    "看剧放松1",
    "早起晨练2",
    "准备早餐2",
    "阅读名著2",
    "学习ArkTS2",
    "看剧放松3"
  ]

  public getData(): Array<string> {
    return this.tasks;
  }
}

export default new DataModel()
