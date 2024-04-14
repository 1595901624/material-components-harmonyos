/*
 * Copyright (c) , cloris 2024.
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
    this.context.beginPath()
    this.context.arc(this._touchX, this._touchY, this._currenRippleRadius, 0, 6.28)
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
}