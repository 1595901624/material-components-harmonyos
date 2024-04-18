import { MDFilledButton, RippleLayout } from '@cloris/material-components/Index';
import { promptAction } from '@kit.ArkUI';
import { ButtonDemoPage } from './ButtonDemoPage';
import { CheckBoxDemoPage } from './CheckBoxDemoPage';
import { SwitchDemoPage } from './SwitchDemoPage';

@Entry
@Component
@Preview
struct Index {
  @State message: string = 'Ripple Layout';

  build() {
    Row() {
      Column({
        space: 20
      }) {
        // Text(this.message)
        //   .fontSize(50)
        //   .fontWeight(FontWeight.Bold)

        RippleLayout({
          backgroundRadius: 16,
          maxRippleRadius: 200,
          rippleBackgroundColor: Color.Orange,
          minRippleRadius: 10,
          contentLayout: () => {
            this.contentLayout()
          }
        })

        // ButtonDemoPage()
        // CheckBoxDemoPage()
        SwitchDemoPage()
        // this.contentLayout()
      }
      .width('100%')
    }
    .height('100%')
  }

  @Builder
  contentLayout() {
    Column() {
      Text(this.message)
        .fontSize(20)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          promptAction.showToast({
            message: 'Hello World',
            duration: 2000
          })
        })
    }.justifyContent(FlexAlign.Center)
    .width(200)
    .height(40)
  }
}