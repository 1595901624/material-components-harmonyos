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

        MDSwitch({
          switchWidth: 200,
          switchHeight: 100,
          checked: true
        })

      }
      .width('100%')
    }
    .height('100%')
  }
}