import UIKit
import MessageUI

@available(iOS 8.0, *)
@objc(SMSSenderPlugin) class SMSSenderPlugin : CDVPlugin, MFMessageComposeViewControllerDelegate {
    var thisCommand: CDVInvokedUrlCommand?
    
    func sendMessage(command: CDVInvokedUrlCommand) {

        let mobile_number = command.arguments[0] as? String ?? ""
        let message = command.arguments[1] as? String ?? ""
        let messageCVC = MFMessageComposeViewController()
        messageCVC.body = message
        messageCVC.recipients = [mobile_number]
        messageCVC.messageComposeDelegate = self
        thisCommand = command
        viewController.presentViewController(messageCVC, animated: true, completion: nil)
    }

    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_OK
        )

        switch result.rawValue {
            case MessageComposeResultCancelled.rawValue :
                //Canceled
                pluginResult = CDVPluginResult(
                    status: CDVCommandStatus_OK,
                    messageAsString: "Canceled"
                )
            case MessageComposeResultFailed.rawValue :
                //Failed
                pluginResult = CDVPluginResult(
                    status: CDVCommandStatus_ERROR,
                    messageAsString: "Failed"
                )
            case MessageComposeResultSent.rawValue :
                //Message Sent
                pluginResult = CDVPluginResult(
                    status: CDVCommandStatus_OK,
                    messageAsString: "Sent"
                )
            default:
                break
        }

        self.commandDelegate!.sendPluginResult(
            pluginResult, 
            callbackId: thisCommand!.callbackId
        )

        controller.dismissViewControllerAnimated(true, completion: nil)
    }

}