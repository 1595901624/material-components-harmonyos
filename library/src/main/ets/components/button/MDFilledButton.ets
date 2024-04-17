/**
 * MIT License
 *
 * Copyright (c) 2024 Cloris
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
import { RippleEvent } from '../../basic/RippleEvent'

import { RippleLayout } from '../../basic/RippleLayout'

/**
 * The filled button’s contrasting surface color makes it
 * the most prominent button after the FAB.
 * It’s used for final or unblocking actions in a flow.
 */
@Component
@Preview
export struct MDFilledButton {
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
    radius: 0,
    color: Color.Gray,
    offsetX: 0,
    offsetY: 0
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
        if (event === RippleEvent.RIPPLE_START) {
          this._shadowOptions = {
            radius: 3,
            color: Color.Gray,
            offsetX: 0,
            offsetY: 3
          }
        } else {
          this._shadowOptions = {
            radius: 0,
            color: Color.Gray,
            offsetX: 0,
            offsetY: 0
          }
        }
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

