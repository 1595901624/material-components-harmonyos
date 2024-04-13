@Component
@Entry
@Preview
export struct RippleDemo {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  @State @Watch("updateCanvas") radius: number = 30;
  @State x: number = 0;
  @State y: number = 0;

  updateCanvas(): void {
    // 清除画布
    this.context.clearRect(0, 0, this.context.width, this.context.height)
    this.context.beginPath()
    this.context.arc(this.x, this.y, this.radius, 0, 6.28)
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

          // this.context.arc(100, 100, this.radius, 0, 6.28)
          // this.context.fillStyle = '#000000'
          // this.context.fill()
        })
        .borderRadius(4)
      // Circle({
      //   width: this.radius,
      //   height: this.radius
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
    // .shadow(ShadowStyle.OUTER_DEFAULT_SM)
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
        this.radius = 30;
        this.startRipple(event.touches[0].x, event.touches[0].y)
      // this.radius = 0
      // setInterval(() => {
      //   if (this.radius >= 100) {
      //     return
      //   }
      //   this.radius += 1
      // }, 1)
      // animateTo({
      //   duration: 3000,
      //   curve: Curve.Friction,
      //   onFinish: () => {
      //
      //   }
      // }, () => {
      //   this.radius = 400
      // })
        break;
      case TouchType.Up:
      // this.radius = 30;
        this.stopRipple()
        this.radius = 30;
        this.context.clearRect(0, 0, this.context.width, this.context.height)
        break;
      case TouchType.Move:
        this.radius = 30;
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

  startRipple(x: number, y: number): void {
    // if (this.radius >= 100) {
    //   return
    // }
    // this.getUIContext().keyframeAnimateTo({}, [
    //   {
    //     duration: 3000,
    //     curve: Curve.Linear,
    //     event: () => {
    //       this.radius = 100
    //     }
    //   }
    // ])

    // animateTo({
    //   duration: 0.1,
    //   curve: Curve.Friction,
    //   onFinish: () => {
    //     this.startRipple(x, y)
    //   }
    // }, () => {
    //   this.radius += 10
    // })

    this.x = x
    this.y = y

    let id = setInterval(() => {
      if (this.radius >= 300) {
        return
      }
      this.radius += 3
    }, 1)

    this.interval = id
  }
}