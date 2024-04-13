@Component
@Entry
@Preview
export struct Ripple {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  @State @Watch("updateCanvas") _radius: number = 30;
  @State private _touchX: number = 0;
  @State private _touchY: number = 0;

  updateCanvas(): void {
    // clear canvas
    this.context.clearRect(0, 0, this.context.width, this.context.height)
    this.context.beginPath()
    this.context.arc(this._touchX, this._touchY, this._radius, 0, 6.28)
    this.context.fillStyle = '#4af2f2f2'
    this.context.fill()
    console.log('updateCanvas')
  }

  build() {
    Stack() {
      Canvas(this.context)
        .width(200)
        .height(40)
        .backgroundColor("#1976D2")
        .onReady(() => {

          // this.context.arc(100, 100, this._radius, 0, 6.28)
          // this.context.fillStyle = '#000000'
          // this.context.fill()
        })
        .borderRadius(4)
      // Circle({
      //   width: this._radius,
      //   height: this._radius
      // })
      Column() {
        Text("你好")
          .fontColor(Color.White)
      }.width(200)
      .height(40)
      .borderRadius(4)
      .justifyContent(FlexAlign.Center)
    }
    .onTouch((event: TouchEvent) => {
      this.handleTouch(event)
    })
    .shadow({
      radius: 3,
      color: Color.Gray,
      offsetX: 0,
      offsetY: 3
    })
    .borderRadius(4)
    .position({
      x: "20%",
      y: "50%"
    })
  }

  aboutToAppear(): void {

  }

  handleTouch(event: TouchEvent): void {
    switch (event.type) {
      case TouchType.Down:
        this._radius = 30;
        this.startRipple(event.touches[0].x, event.touches[0].y)
        break;
      case TouchType.Up:
      // this._radius = 30;
        this.stopRipple()
        this._radius = 30;
        this.context.clearRect(0, 0, this.context.width, this.context.height)
        break;
      case TouchType.Move:
        this._radius = 30;
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
      if (this._radius >= 300) {
        return
      }
      this._radius += 3
    }, 1)

    this.interval = id
  }
}