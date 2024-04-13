/*
 * Copyright (c) , zanglikun 2024. cloris
 */
import { RippleLayout } from '../../basic/RippleLayout'

@Component
@Preview
export struct MDButton {
  build() {
    RippleLayout({
      rippleWidth: 200,
      rippleHeight: 40,
      contentLayout: () => {
        this.contentLayout()
      }
    })
  }

  @Builder
  contentLayout() {
    Column() {
      Text("你好")
        .fontColor(Color.White)
    }
  }
}

