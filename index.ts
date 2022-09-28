import domready = require("domready");
import Game from "./game";
import {version} from "./package.json";

console.log("You Are Now In Space v" + version);

domready(() => {
    const game = new Game();
    const engine = game.engine;

    // Work around Firefox not supporting image-rendering: pixelated
    // See https://github.com/excaliburjs/Excalibur/issues/1676
    if (engine.canvas.style.imageRendering === "") {
        engine.canvas.style.imageRendering = "crisp-edges";
    }

    engine.canvas.setAttribute("tabindex", "-1");

    function scale(): void {
        const scaleFactor = Math.floor(Math.min(
            window.innerWidth / game.width,
            window.innerHeight / game.height
        ));

        engine.screen.viewport = {
            width: game.width * scaleFactor,
            height: game.height * scaleFactor
        };
        engine.screen.applyResolutionAndViewport();
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
