@Observed
export class SelectedModel {
  isAllSelected: boolean
  unSelectedArray: UnSelectedArray = new UnSelectedArray()
  hasSelect: boolean

  constructor(isAllSelected: boolean = false) {
    this.isAllSelected = isAllSelected
  }

  public revertAll(isCheck: boolean) {
    this.isAllSelected = isCheck
    this.unSelectedArray.forEach((item, index) => {
      this.unSelectedArray[index] = isCheck
    })
    this.hasSelect = isCheck
  }

  public itemSelectChanged(index: number) {
    this.unSelectedArray[index] = !this.unSelectedArray[index]
    let b = true
    this.unSelectedArray.forEach((item) => {
      if (!item) {
        b = false
        return
      }
    })
    this.isAllSelected = b
    this.isHasItemChecked()
  }

  public itemIsChecked(index: number): boolean {
    if (this.unSelectedArray[index] == undefined) {
      this.unSelectedArray[index] = false
    }
    return this.unSelectedArray[index]
  }

  private  isHasItemChecked() {
    let hasSelected = false
    this.unSelectedArray.forEach((item) => {
      if (item) {
        hasSelected = true
        return
      }
    })
    this.hasSelect = hasSelected
  }
}

@Observed
export class UnSelectedArray extends Array<boolean> {
}


@Observed
export class ObjBoolean extends Boolean {
}
