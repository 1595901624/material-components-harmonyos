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
import { canvasUtil } from '../../util/CanvasUtil'

/**
 * Use checkboxes (instead of switches or radio buttons) if multiple options can be selected from a list
 * Label should be scannable
 * Selected items are more prominent than unselected items
 *
 * Unselected, selected (hover), and indeterminate checkboxes
 */
@Component
@Preview
export struct MDCheckBox {
  boxSize: number = 20
  /**
   * if true, the checkbox is in the indeterminate state,
   * and the callback is not called
   */
  @Prop @Watch("updateCanvas") indeterminate: boolean = false
  /**
   * if true, the checkbox is checked
   */
  @Prop @Watch("updateCanvas") checked: boolean = false
  /**
   * radius of the checkbox
   */
  radius: number = 4
  /**
   * width of the border line
   */
  borderLineWidth: number = 2
  /**
   * callback when the checkbox is checked
   */
  onCheckedChange?: (checked: boolean) => void
  rippleColor: ResourceColor = "#20000000"
  // ************************************private params**********************************************
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  @State _currentRippleColor: ResourceColor = Color.Transparent

  build() {
    Stack() {
      Canvas(this.context)
        .onReady(() => {
          this.onDraw()
        })
        .width(this.boxSize)
        .height(this.boxSize)
    }
    .width(this.boxSize)
    .height(this.boxSize)
    .padding(this.boxSize)
    .borderRadius(this.boxSize)
    .backgroundColor(this._currentRippleColor)
    .onTouch((event) => {
      this.handleTouchEvent(event)
    })
  }

  handleTouchEvent(event: TouchEvent) {
    switch (event.type) {
      case TouchType.Down:
        animateTo({
          duration: 150,
          onFinish: () => {
          }
        }, () => {
          this._currentRippleColor = this.rippleColor
        })
        break;
      case TouchType.Up:
        animateTo({
          duration: 150,
          onFinish: () => {
          }
        }, () => {
          this._currentRippleColor = Color.Transparent
        })
        if (this.indeterminate) {
          return;
        }
        this.checked = !this.checked
        this.onCheckedChange?.(this.checked)
        break;
      case TouchType.Move:
        break;
      case TouchType.Cancel:
        break;
    }
  }

  updateCanvas() {
    this.onDraw()
  }

  onDraw() {
    canvasUtil.clearCanvas(this.context)
    this.drawCircleRipple();
    if (this.indeterminate) {
      this.drawIndeterminate()
    } else {
      if (this.checked) {
        this.drawChecked()
      } else {
        this.drawCheckedFalse()
      }
    }
  }

  /**
   * draw checked
   */
  drawChecked() {
    this.drawSquare(this.context, 0, 0, this.boxSize, this.radius, "#000000")
    const lineWidth = this.boxSize / 10 === 0 ? 1 : this.boxSize / 10
    this.context.beginPath()
    this.context.strokeStyle = "#ffffff"
    this.context.lineWidth = lineWidth
    this.context.moveTo(this.boxSize / 10 * 2, this.boxSize / 2)
    this.context.lineTo(this.boxSize / 10 * 4, this.boxSize / 10 * 7)
    this.context.lineTo(this.boxSize / 10 * 8, this.boxSize / 4)
    this.context.stroke()
    this.context.closePath()
  }

  /**
   * draw indeterminate
   */
  drawIndeterminate() {
    this.drawSquare(this.context, 0, 0, this.boxSize, this.radius, "#000000")
    const lineWidth = this.boxSize / 10 === 0 ? 1 : this.boxSize / 10
    this.context.beginPath()
    this.context.strokeStyle = "#ffffff"
    this.context.lineWidth = lineWidth
    this.context.moveTo(this.boxSize / 10 * 2, this.boxSize / 2)
    this.context.lineTo(this.boxSize / 10 * 8, this.boxSize / 2)
    this.context.stroke()
  }

  drawCheckedFalse() {
    this.drawStrokeSquare(this.context, 0, 0, this.boxSize, this.radius, "#000000", this.borderLineWidth)
  }

  /**
   * draw square
   */
  drawSquare(ctx: CanvasRenderingContext2D, x: number, y: number, width: number, radius: number, fillColor: string) {
    canvasUtil.fillRoundRect(ctx, x, y, width, width, radius, fillColor)
  }

  /**
   * draw stroke square
   */
  drawStrokeSquare(ctx: CanvasRenderingContext2D, x: number, y: number, width: number, radius: number, strokeColor: string, strokeWidth: number) {
    canvasUtil.strokeRoundRect(ctx, x, y, width, width, radius, strokeColor, strokeWidth)
  }

  drawCircleRipple() {
    // this.context.fillStyle = "#20ea2121"
    // this.context.arc(this.boxSize / 2, this.boxSize / 2, this.boxSize, 0, 2 * Math.PI)
    // this.context.fill()
  }
}