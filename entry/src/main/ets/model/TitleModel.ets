export default class TitleData {
  size?: number;
  title?: Resource;

  constructor(title: Resource, size: number = 26) {
    this.title = title
    this.size = size
  }
}