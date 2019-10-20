import domready = require("domready");
import Game from "./game";
import {version} from "./package.json";

console.log("You Are Now In Space v" + version);

domready(() => {
    const game = new Game();
    const engine = game.engine;

    function scale(): void {
        const scaleFactor = Math.floor(Math.min(
            window.innerWidth / game.width,
            window.innerHeight / game.height
        ));

        const scaledWidth = game.width * scaleFactor;
        const scaledHeight = game.height * scaleFactor;

        engine.canvas.tabIndex = 0;
        engine.canvas.style.left = Math.floor((window.innerWidth - scaledWidth) * 0.5) + "px";
        engine.canvas.style.top = Math.floor((window.innerHeight - scaledHeight) * 0.5) + "px";
        engine.canvas.style.width = scaledWidth + "px";
        engine.canvas.style.height = scaledHeight + "px";
    }

    scale();

    window.addEventListener("resize", scale);

    game.start();
});