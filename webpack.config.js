const config = require("@softwareventures/webpack-config");

module.exports = config({
    title: "You Are Now In Space",
    vendor: "dcgw",
    html: {
        template: "index.html"
    }
});
