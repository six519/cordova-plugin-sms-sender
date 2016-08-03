"use strict";

var exec = require("cordova/exec");

var sMSSenderPlugin = {
	sendMessage: function(mobile_number, message, sc, ec) {
		exec(sc, ec, "SMSSenderPlugin", "sendMessage", [mobile_number, message]);
	}
};

module.exports = sMSSenderPlugin;