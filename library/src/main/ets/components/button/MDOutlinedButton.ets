/*
 * Copyright (c) , cloris 2024.
 */
import { RippleEvent } from '../../basic/RippleEvent'

import { RippleLayout } from '../../basic/RippleLayout'

/**
 * Use an outlined button for actions that need attention but aren’t the primary action, such as See all or Add to cart.
 * This is also the button to use for giving someone the opportunity to change their mind or escape a flow.
 */
@Component
@Preview
export struct MDOutlinedButton {
  /**
   * The label of the button.
   */
  @Prop label: string = ''
  layoutWidth: Length = 'auto'
  layoutHeight: Length = 'auto'
  fontSize: number = 16
  fontColor: ResourceColor = Color.Black
  fontWeight: FontWeight = FontWeight.Normal
  fontStyle: FontStyle = FontStyle.Normal
  textOverflow: TextOverflow = TextOverflow.Ellipsis
  maxLines: number = 1
  minFontSize: number = 12
  maxFontSize: number = 20
  stateEffect: boolean = true
  textAlign: TextAlign = TextAlign.Center
  buttonRadius: number = 0
  buttonBorderColor: ResourceColor = Color.Black
  buttonNormalBackgroundColor: ResourceColor = Color.Transparent
  buttonPressBackgroundColor: string = "#307f5700"
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
    radius: 0,
    color: Color.Gray,
    offsetX: 0,
    offsetY: 0
  }

  build() {
    RippleLayout({
      minRippleRadius: 10,
      rippleBackgroundColor: this.buttonNormalBackgroundColor,
      rippleForegroundColor: this.buttonPressBackgroundColor,
      stateEffect: this.stateEffect,
      maxRippleRadius: this._rippleRadius,
      backgroundRadius: this.buttonRadius,
      contentLayout: () => {
        this.contentLayout()
      },
      onRippleTouch: (event) => {
      }
    })
  }

  @Builder
  contentLayout() {
    Text(this.label)
      .fontColor(this.fontColor)
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
      .borderColor(this.buttonBorderColor)
      .borderWidth(1)
      .borderRadius(this.buttonRadius)
      .shadow(this._shadowOptions)
  }
}

