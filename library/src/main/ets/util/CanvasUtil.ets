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

  drawCircle(ctx: CanvasRenderingContext2D, x: number, y: number, radius: number, fillColor: string) {
    ctx.beginPath()
    ctx.arc(x, y, radius, 0, Math.PI * 2, false)
    ctx.fillStyle = fillColor
    ctx.fill()
  }
}

export const canvasUtil = new CanvasUtil()