
@available(iOS 8.0, *)
@objc(SMSSenderPlugin) class SMSSenderPlugin : CDVPlugin {
    func sendMessage(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )

        self.commandDelegate!.sendPluginResult(
            pluginResult, 
            callbackId: command.callbackId
        )
    }
}