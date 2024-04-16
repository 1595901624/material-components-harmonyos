/*
 * Copyright (c) , cloris 2024.
 */


@Component
@Preview
@Entry
export struct CheckBox {
  // ************************************private params**********************************************88
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Canvas(this.context).onReady(() => {

    })
  }
}