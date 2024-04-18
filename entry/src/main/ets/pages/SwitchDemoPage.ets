import { MDCheckBox, MDSwitch } from '@cloris/material-components/Index';

@Entry
@Component
@Preview
export struct SwitchDemoPage {
  build() {
    Row() {
      Column({
        space: 20
      }) {
        MDSwitch()
      }
      .width('100%')
    }
    .height('100%')
  }
}