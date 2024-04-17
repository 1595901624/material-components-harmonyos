import { MDCheckBox } from '@cloris/material-components/Index';

@Entry
@Component
@Preview
export struct CheckBoxDemoPage {
  build() {
    Row() {
      Column({
        space: 20
      }) {
        MDCheckBox({
          indeterminate: false,
          boxSize: 20
        })

        Toggle({
          type:ToggleType.Checkbox
        }).width(120)

      }
      .width('100%')
    }
    .height('100%')
  }
}