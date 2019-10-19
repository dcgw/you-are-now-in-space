import {Loader} from "excalibur";
import {colours} from "./palette";

const minColourBarSize = 1152;
const maxColourBarSize = 4608;

export default class Preloader extends Loader {
    private colourIndex = 0;

    public draw(ctx: CanvasRenderingContext2D): void {
        let raster = 0;
        const maxRaster = ctx.canvas.width * ctx.canvas.height;

        ctx.lineCap = "square";
        ctx.lineWidth = 1;
        ctx.setLineDash([]);

        while (raster < maxRaster) {
            const startRaster = raster;
            const endRaster = Math.floor(Math.min(maxRaster,
                raster + minColourBarSize + Math.random() * (maxColourBarSize - minColourBarSize)));

            const startX = startRaster % ctx.canvas.width;
            const startY = Math.floor(startRaster / ctx.canvas.width);

            const endX = endRaster % ctx.canvas.width;
            const endY = Math.floor(endRaster / ctx.canvas.width);

            this.colourIndex = (this.colourIndex + 1) % colours.length;
            ctx.strokeStyle = colours[this.colourIndex].fillStyle();
            ctx.fillStyle = colours[this.colourIndex].fillStyle();
            ctx.beginPath();
            ctx.moveTo(startX, startY);

            if (startY === endY) {
                ctx.fillRect(startX, startY, endX - startX, 1);
            } else {
                ctx.fillRect(startX, startY, ctx.canvas.width - startX, 1);

                if (startY + 2 < endY) {
                    ctx.beginPath();
                    ctx.fillRect(0, startY + 1, ctx.canvas.width, endY - startY - 1);
                }

                ctx.beginPath();
                ctx.fillRect(0, endY, endX, 1);
            }

            raster = endRaster;
        }
    }
}