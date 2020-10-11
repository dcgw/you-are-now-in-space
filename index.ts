import domready = require("domready");
import Game from "./game";
import {version} from "./package.json";

console.log("You Are Now In Space v" + version);

domready(() => {
    const game = new Game();
    const engine = game.engine;

    engine.canvas.style.position = "absolute";
    engine.canvas.style.imageRendering = "pixelated";

    // Work around Firefox not supporting image-rendering: pixelated
    // See https://github.com/excaliburjs/Excalibur/issues/1676
    if (engine.canvas.style.imageRendering === "") {
        engine.canvas.style.imageRendering = "crisp-edges";
    }

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


    function onKey(event: KeyboardEvent): void {
        engine.canvas.focus();

        switch (event.code) {
            case "ArrowUp":
            case "ArrowDown":
            case "ArrowLeft":
            case "ArrowRight":
            case "KeyX":
                event.preventDefault();
        }
    }

    let pointerTimeout = 0;

    function onMouseMove(): void {
        showPointer();

        if (pointerTimeout) {
            clearTimeout(pointerTimeout);
        }

        pointerTimeout = window.setTimeout(() => {
            if (game.active) {
                hidePointer();
            }
        }, 500);
    }

    function onFocus(): void {
        hidePointer();
        game.active = true;
    }

    function onBlur(): void {
        showPointer();
        game.active = false;
    }

    function hidePointer(): void {
        engine.canvas.style.cursor = "none";
    }

    function showPointer(): void {
        engine.canvas.style.cursor = "auto";
    }

    scale();

    window.addEventListener("resize", scale);
    window.addEventListener("keydown", onKey);
    window.addEventListener("keypress", onKey);
    window.addEventListener("keyup", onKey);
    window.addEventListener("mousemove", onMouseMove, true);
    window.addEventListener("focus", onFocus, true);
    window.addEventListener("blur", onBlur, true);

    game.start();
});