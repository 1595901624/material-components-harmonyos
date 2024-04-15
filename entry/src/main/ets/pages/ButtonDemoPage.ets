import { promptAction } from '@kit.ArkUI'
import { MDElevatedButton, MDFilledButton } from '@cloris/material-components/Index';

@Entry
@Component
@Preview
struct ButtonDemoPage {
  build() {
    Row() {
      Column({
        space: 20
      }) {

        MDFilledButton({
          label: "Filled Button",
          buttonBackgroundColor: Color.Red,
          buttonRadius: 40,
          onButtonClick: () => {
            promptAction.showToast({
              message: 'Filled Button',
              duration: 2000
            })
          }
        })

        MDElevatedButton({
          label: "Elevated Button",
          buttonBackgroundColor: Color.Red,
          buttonRadius: 40,
          onButtonClick: () => {
            promptAction.showToast({
              message: 'Elevated Button',
              duration: 2000
            })
          }
        })

      }
      .width('100%')
    }
    .height('100%')
  }
}