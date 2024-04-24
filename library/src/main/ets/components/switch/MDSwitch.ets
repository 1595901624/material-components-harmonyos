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

@Component
@Preview
export struct MDSwitch {
  switchWidth: Length = 80
  switchHeight: Length = 40
  radius: number = 80
  @State checked: boolean = false
  // ************************************private params**********************************************
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  _falseRadius = 0
  _trueRadius = 0

  build() {
    Canvas(this.context)
      .onReady(() => {
        this._falseRadius = this.context.height / 2 * 0.5
        this._trueRadius = this.context.height / 2 * 0.74
        this.onDraw()
        // this.drawSelectedFalse()
        // this.drawSelectedTrue()
      })
      .width(this.switchWidth)
      .height(this.switchHeight)
      .onClick(() => {
        this.checked = !this.checked
        this.onDraw()
      })
  }

  onDraw() {
    canvasUtil.clearCanvas(this.context)
    if (this.checked) {
      this.drawSelectedTrue()
    } else {
      this.drawSelectedFalse()
    }
  }

  drawSelectedFalse() {
    canvasUtil.fillRoundRect(this.context, 2, 2, this.context.width - 4, this.context.height - 4, this.radius, "#30000000")
    canvasUtil.strokeRoundRect(this.context, 2, 2, this.context.width - 4, this.context.height - 4, this.radius, "#000000", 2)
    canvasUtil.drawCircle(this.context, this.context.height / 2, this.context.height / 2, this._falseRadius, "#000000")
  }

  /**
   * draw selected true
   */
  drawSelectedTrue() {
    canvasUtil.fillRoundRect(this.context, 2, 2, this.context.width - 4, this.context.height - 4, this.radius, "#30000000")
    canvasUtil.strokeRoundRect(this.context, 2, 2, this.context.width - 4, this.context.height - 4, this.radius, "#000000", 2)
    canvasUtil.drawCircle(this.context, this.context.width - this.context.height / 2 - 4, this.context.height / 2, this._trueRadius, "#000000")
  }
}