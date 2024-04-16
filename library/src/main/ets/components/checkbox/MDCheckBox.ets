/*
 * Copyright (c) , cloris 2024.
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
  // ************************************private params**********************************************88
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Canvas(this.context)
      .onReady(() => {
        this.drawSquare(this.context, 0, 0, this.boxSize, 4, "#000000")
      })
      .width(this.boxSize)
      .height(this.boxSize)
      .onClick(() => {

      })
  }

  /**
   * draw checked
   */
  drawChecked() {
    this.context.beginPath()
    this.context.strokeStyle = "#ffffff"
    this.context.lineWidth = 2
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
    this.context.beginPath()
    this.context.strokeStyle = "#ffffff"
    this.context.lineWidth = 2
    this.context.moveTo(this.boxSize / 10 * 2, this.boxSize / 2)
    this.context.lineTo(this.boxSize / 10 * 8, this.boxSize / 2)
    this.context.stroke()
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
}