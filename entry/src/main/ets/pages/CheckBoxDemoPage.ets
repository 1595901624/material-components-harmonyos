import { promptAction } from '@kit.ArkUI'
import {
  MDCheckBox,
  MDElevatedButton, MDFilledButton, MDOutlinedButton, MDTextButton } from '@cloris/material-components/Index';

@Entry
@Component
@Preview
export struct ButtonDemoPage {
  build() {
    Row() {
      Column({
        space: 20
      }) {

        MDCheckBox()

      }
      .width('100%')
    }
    .height('100%')
  }
}