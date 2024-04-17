class CanvasUtil {
  /**
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

  strokeRoundRect(ctx: CanvasRenderingContext2D, x: number, y: number, width: number, height: number, radius: number, strokeColor: string, strokeWidth: number) {
    //圆的直径必然要小于矩形的宽高
    if (2 * radius > width || 2 * radius > height) {
      radius = Math.min(width / 2, height / 2)
    }

    ctx.save();
    ctx.translate(x, y);
    //绘制圆角矩形的各个边
    this.drawRoundRectPath(ctx, width, height, radius);
    ctx.strokeStyle = strokeColor || "#000"; //若是给定了值就用给定的值否则给予默认值
    ctx.lineWidth = strokeWidth || 1;
    ctx.stroke()
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
  private drawRoundRectPath(ctx: CanvasRenderingContext2D, width: number, height: number, radius: number) {
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
   * clear canvas
   * @param ctx
   */
  clearCanvas(ctx: CanvasRenderingContext2D) {
    ctx.clearRect(0, 0, ctx.width, ctx.height)
  }
}

export const canvasUtil = new CanvasUtil()