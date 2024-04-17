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
import { RippleEvent } from './RippleEvent'

/**
 * This is a ripple layout.
 * When the user touches the layout, the ripple effect will be displayed.
 */
@Component
@Preview
export struct RippleLayout {
  /**
   * The background radius of the ripple effect.
   */
  backgroundRadius: number = 4
  /**
   * The maximum radius of the ripple effect.
   */
  @Prop maxRippleRadius: number = 100
  /**
   * The minimum radius of the ripple effect.
   */
  @Prop minRippleRadius: number = 30
  /**
   * The background color of the ripple effect.
   */
  rippleBackgroundColor: ResourceColor = Color.Transparent
  /**
   * The foreground color of the ripple effect.
   * only support string type now.
   * @default "#4af2f2f2"
   */
  rippleForegroundColor: string = "#4af2f2f2"
  /**
   * The radius of the ripple effect.
   */
  @State @Watch("updateCanvas") _currenRippleRadius: number = this.minRippleRadius;
  @BuilderParam contentLayout: () => void
  /**
   * Enable press water ripple effect
   */
  stateEffect: boolean = true
  /**
   * The callback function when the user touches the layout.
   */
  onRippleTouch?: (event: RippleEvent) => void
  // ************************************private params**********************************************88
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  @State private _touchX: number = 0;
  @State private _touchY: number = 0;
  /**
   * The width of the ripple effect.
   */
  @State rippleWidth: Length = 0;
  /**
   * The height of the ripple effect.
   */
  @State rippleHeight: Length = 0;

  updateCanvas(): void {
    // clear canvas
    this.context.clearRect(0, 0, this.context.width, this.context.height)
    this.drawRoundBackground();
    this.context.clip()
    this.context.beginPath()
    this.context.arc(this._touchX, this._touchY, this._currenRippleRadius, 0, 6.28)
    this.context.closePath();
    this.context.fillStyle = this.rippleForegroundColor
    this.context.fill()
    // console.log('updateCanvas')
  }

  build() {
    Stack() {
      Canvas(this.context)
        .width(this.rippleWidth)
        .height(this.rippleHeight)
        .backgroundColor(this.rippleBackgroundColor)
        .onReady(() => {

        })
        .borderRadius(this.backgroundRadius)

      Column() {
        this.contentLayout();
      }.onAreaChange((oldValue: Area, newValue: Area) => {
        console.log('onAreaChange', newValue.width, newValue.height)
        this.rippleWidth = newValue.width;
        this.rippleHeight = newValue.height;
      })
    }
    .onTouch((event: TouchEvent) => {
      this.handleTouch(event)
    })
    // .onAreaChange((oldValue: Area, newValue: Area) => {
    //   this.rippleWidth = newValue.width;
    //   this.rippleHeight = newValue.height;
    // })
    // .shadow({
    //   radius: 3,
    //   color: Color.Gray,
    //   offsetX: 0,
    //   offsetY: 3
    // })
    .borderRadius(this.backgroundRadius)
  }

  aboutToAppear(): void {

  }

  handleTouch(event: TouchEvent): void {
    switch (event.type) {
      case TouchType.Down:
        this._currenRippleRadius = this.minRippleRadius;
        this.onRippleTouch?.(RippleEvent.RIPPLE_START)
        this.startRipple(event.touches[0].x, event.touches[0].y)
        break;
      case TouchType.Up:
        this.stopRipple()
        this.onRippleTouch?.(RippleEvent.RIPPLE_END)
        this._currenRippleRadius = this.minRippleRadius;
        this.context.clearRect(0, 0, this.context.width, this.context.height)
        break;
      case TouchType.Move:
        break;
      case TouchType.Cancel:

        break;
      default:
        break;
    }
  }

  interval: number = -1;

  stopRipple(): void {
    clearInterval(this.interval)
  }

  /**
   * start ripple
   * @param x: the x position of the touch
   * @param y: the y position of the touch
   */
  startRipple(x: number, y: number): void {
    if (!this.stateEffect) {
      return
    }
    this._touchX = x
    this._touchY = y

    let id = setInterval(() => {
      if (this._currenRippleRadius >= this.maxRippleRadius) {
        this._currenRippleRadius = this.maxRippleRadius
        return
      }
      this._currenRippleRadius += 3
    }, 10)

    this.interval = id
  }

  /**
   *
   * draw round rect
   * @param x
   * @param y
   * @param width
   * @param height
   * @param radius
   * @param fillColor
   **/
  fillRoundRect(ctx: CanvasRenderingContext2D, x: number, y: number, width: number, height: number, radius: number, fillColor: string) {
    //圆的直径必然要小于矩形的宽高
    if (2 * radius > width || 2 * radius > height) {
      radius = Math.min(width / 2, height / 2)
    }

    ctx.save();
    ctx.translate(x, y);
    //绘制圆角矩形的各个边
    this.drawRoundRectPath(ctx, width, height, radius);

    ctx.fillStyle = fillColor || "#000"; //若是给定了值就用给定的值否则给予默认值
    ctx.fill()
    ctx.restore();
  }

  /**
   * draw round rect
   *
   * @param ctx
   * @param width
   * @param height
   * @param radius
   * @param ctx
   * @param width
   * @param height
   * @param radius
   */
  drawRoundRectPath(ctx: CanvasRenderingContext2D, width: number, height: number, radius: number) {
    ctx.beginPath();
    ctx.arc(width - radius, height - radius, radius, 0, Math.PI / 2);
    ctx.lineTo(radius, height);
    ctx.arc(radius, height - radius, radius, Math.PI / 2, Math.PI);
    ctx.lineTo(0, radius);
    ctx.arc(radius, radius, radius, Math.PI, Math.PI * 3 / 2);
    ctx.lineTo(width - radius, 0);
    ctx.arc(width - radius, radius, radius, Math.PI * 3 / 2, Math.PI * 2);
    ctx.lineTo(width, height - radius);
    ctx.closePath();
  }

  /**
   * draw round background
   */
  drawRoundBackground() {
    this.fillRoundRect(this.context, this._touchX - this._currenRippleRadius, this._touchY - this._currenRippleRadius,
      this.context.width, this.context.height, this.backgroundRadius, "#00000000")
  }
}