import domready = require("domready");
import Game from "./game";
import {Physics, CollisionResolutionStrategy, CollisionGroupManager} from "excalibur";

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

        engine.canvas.style.left = Math.floor((window.innerWidth - scaledWidth) * 0.5) + "px";
        engine.canvas.style.top = Math.floor((window.innerHeight - scaledHeight) * 0.5) + "px";
        engine.canvas.style.width = scaledWidth + "px";
        engine.canvas.style.height = scaledHeight + "px";
        Physics.collisionResolutionStrategy = CollisionResolutionStrategy.RigidBody;
        CollisionGroupManager.create("aliens");
        CollisionGroupManager.create("player");
    }

    scale();

    window.addEventListener("resize", scale);

    game.start();
});