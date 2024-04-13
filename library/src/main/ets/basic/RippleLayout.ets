/*
 * Copyright (c) , zanglikun 2024. cloris
 */

/**
 * This is a ripple layout.
 * When the user touches the layout, the ripple effect will be displayed.
 */
@Component
@Preview
export struct RippleLayout {
  /**
   * The width of the ripple effect.
   */
  rippleWidth: Length = 0;
  /**
   * The height of the ripple effect.
   */
  rippleHeight: Length = 0;
  /**
   * The radius of the ripple effect.
   */
  radius: number = 4
  @BuilderParam contentLayout: () => void
  // ************************************private params**********************************************88
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  @State @Watch("updateCanvas") _rippleRadius: number = 30;
  @State private _touchX: number = 0;
  @State private _touchY: number = 0;

  updateCanvas(): void {
    // clear canvas
    this.context.clearRect(0, 0, this.context.width, this.context.height)
    this.context.beginPath()
    this.context.arc(this._touchX, this._touchY, this._rippleRadius, 0, 6.28)
    this.context.fillStyle = '#4af2f2f2'
    this.context.fill()
    console.log('updateCanvas')
  }

  build() {
    Stack() {
      Canvas(this.context)
        .width(this.rippleWidth)
        .height(this.rippleHeight)
        .backgroundColor("#1976D2")
        .onReady(() => {

        })
        .borderRadius(this.radius)
      this.contentLayout();
    }
    .width(this.rippleWidth)
    .height(this.rippleHeight)
    .onTouch((event: TouchEvent) => {
      this.handleTouch(event)
    })
    // .onAreaChange((oldValue: Area, newValue: Area) => {
    //   this.rippleWidth = newValue.width;
    //   this.rippleHeight = newValue.height;
    // })
    .shadow({
      radius: 3,
      color: Color.Gray,
      offsetX: 0,
      offsetY: 3
    })
    .borderRadius(this.radius)
  }

  aboutToAppear(): void {

  }

  handleTouch(event: TouchEvent): void {
    switch (event.type) {
      case TouchType.Down:
        this._rippleRadius = 30;
        this.startRipple(event.touches[0].x, event.touches[0].y)
        break;
      case TouchType.Up:
      // this._rippleRadius = 30;
        this.stopRipple()
        this._rippleRadius = 30;
        this.context.clearRect(0, 0, this.context.width, this.context.height)
        break;
      case TouchType.Move:
        this._rippleRadius = 30;
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
    this._touchX = x
    this._touchY = y

    let id = setInterval(() => {
      if (this._rippleRadius >= 300) {
        return
      }
      this._rippleRadius += 3
    }, 1)

    this.interval = id
  }
}