import UIKit
import MessageUI

@available(iOS 8.0, *)
@objc(SMSSenderPlugin) class SMSSenderPlugin : CDVPlugin {
    func sendMessage(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_OK
        )

        let mobile_number = command.arguments[0] as? String ?? ""
        let message = command.arguments[1] as? String ?? ""

        let messageVC = MFMessageComposeViewController()
        messageVC.body = message
        messageVC.recipients = [mobile_number]

        viewController.presentViewController(messageVC, animated: true, completion: nil)

        self.commandDelegate!.sendPluginResult(
            pluginResult, 
            callbackId: command.callbackId
        )
    }
}