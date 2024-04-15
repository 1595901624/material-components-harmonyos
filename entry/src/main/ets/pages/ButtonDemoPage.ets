import { promptAction } from '@kit.ArkUI'
import { MDElevatedButton, MDFilledButton, MDOutlinedButton } from '@cloris/material-components/Index';

@Entry
@Component
@Preview
export struct ButtonDemoPage {
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

        MDOutlinedButton({
          label: "Outlined Button",
          buttonRadius: 40,
          onButtonClick: () => {
            promptAction.showToast({
              message: 'Outlined Button',
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