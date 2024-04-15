/*
 * Copyright (c) , cloris 2024.
 */
import { RippleEvent } from '../../basic/RippleEvent'

import { RippleLayout } from '../../basic/RippleLayout'

/**
 * Elevated buttons are essentially filled buttons
 * with a lighter background color and a shadow.
 * To prevent shadow creep, only use them when absolutely necessary,
 * such as when the button requires visual separation from a patterned background.
 */
@Component
@Preview
export struct MDElevatedButton {
  /**
   * The label of the button.
   */
  @Prop label: string = ''
  layoutWidth: Length = 'auto'
  layoutHeight: Length = 'auto'
  fontSize: number = 16
  fontColor: ResourceColor = Color.White
  fontWeight: FontWeight = FontWeight.Normal
  fontStyle: FontStyle = FontStyle.Normal
  textOverflow: TextOverflow = TextOverflow.Ellipsis
  maxLines: number = 1
  minFontSize: number = 12
  maxFontSize: number = 20
  stateEffect: boolean = true
  textAlign: TextAlign = TextAlign.Center
  buttonRadius: number = 0
  buttonBackgroundColor: ResourceColor = $r('app.color.material_blue')
  /**
   * The padding of the button.
   */
  buttonPadding: Padding = {
    top: 8,
    bottom: 8,
    left: 16,
    right: 16
  }
  /**
   * The callback function when the button is clicked.
   */
  onButtonClick?: (event: ClickEvent) => void
  // onButtonLongClick?: (event: ClickEvent) => void

  // *************************************************
  @State private _rippleRadius: number = 100
  @State private _shadowOptions: ShadowOptions = {
    radius: 3,
    color: Color.Gray,
    offsetX: -1,
    offsetY: 3
  }

  build() {
    RippleLayout({
      minRippleRadius: 10,
      rippleBackgroundColor: this.buttonBackgroundColor,
      stateEffect: this.stateEffect,
      maxRippleRadius: this._rippleRadius,
      backgroundRadius: this.buttonRadius,
      contentLayout: () => {
        this.contentLayout()
      },
      onRippleTouch: (event) => {
        // if (event === RippleEvent.RIPPLE_START) {
        //   this._shadowOptions = {
        //     radius: 3,
        //     color: Color.Gray,
        //     offsetX: -5,
        //     offsetY: 5
        //   }
        // } else {
        //   this._shadowOptions = {
        //     radius: 3,
        //     color: Color.Gray,
        //     offsetX: 0,
        //     offsetY: 3
        //   }
        // }
      }
    })
  }

  @Builder
  contentLayout() {
    Text(this.label)
      .fontColor(Color.White)
      .onClick((event) => {
        this.onButtonClick?.(event)
      })
      .fontSize(this.fontSize)
      .fontWeight(this.fontWeight)
      .fontStyle(this.fontStyle)
      .padding(this.buttonPadding)
      .textOverflow({
        overflow: this.textOverflow
      })
      .maxLines(1)
      .height(this.layoutHeight)
      .width(this.layoutWidth)
      .textAlign(this.textAlign)
      .onAreaChange((_oldValue: Area, newValue: Area) => {
        this._rippleRadius = Math.max(newValue.width as number, newValue.height as number)
      })
      .borderRadius(this.buttonRadius)
      .shadow(this._shadowOptions)
  }
}

