import UIKit
import MessageUI

@available(iOS 8.0, *)
@objc(SMSSenderPlugin) class SMSSenderPlugin : CDVPlugin, MFMessageComposeViewControllerDelegate {
    func sendMessage(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_OK
        )

        let mobile_number = command.arguments[0] as? String ?? ""
        let message = command.arguments[1] as? String ?? ""

        let messageCVC = MFMessageComposeViewController()
        messageCVC.body = message
        messageCVC.recipients = [mobile_number]
        messageCVC.messageComposeDelegate = self

        viewController.presentViewController(messageCVC, animated: true, completion: nil)

        self.commandDelegate!.sendPluginResult(
            pluginResult, 
            callbackId: command.callbackId
        )
    }

    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        switch result.rawValue {
            case MessageComposeResultCancelled.rawValue :
                //Canceled
                print("Cancelled!")
            case MessageComposeResultFailed.rawValue :
                //Failed
                print("Failed")
            case MessageComposeResultSent.rawValue :
                //Message Sent
                print("Sent")
            default:
                break
        }
        controller.dismissViewControllerAnimated(true, completion: nil)
    }

}