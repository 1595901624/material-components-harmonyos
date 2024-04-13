import { RippleLayout } from '@cloris/material-components/Index';
import { promptAction } from '@kit.ArkUI';

@Entry
@Component
@Preview
struct Index {
  @State message: string = 'Hello World';

  build() {
    Row() {
      Column() {
        // Text(this.message)
        //   .fontSize(50)
        //   .fontWeight(FontWeight.Bold)

        RippleLayout({
          rippleWidth: 200,
          rippleHeight: 40,
          contentLayout: () => {
            this.contentLayout()
          }
        })

        this.contentLayout()
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
  }
}