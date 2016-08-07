package com.ferdinandsilva.android;

import java.util.Arrays;
import java.util.ArrayList;
import java.util.List;

import android.app.Activity;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.ContentValues;
import android.net.Uri;
import android.app.Activity;
import android.telephony.SmsManager;

import org.apache.cordova.CordovaWebView;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaInterface;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class SMSSenderPlugin extends CordovaPlugin {
    public static final String TAG = "SMSSenderPlugin";
    public static final String MESSAGE_SENT = "sent";

    public static Context thisContext;

    public SMSSenderPlugin() {
    }

    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
        SMSSenderPlugin.thisContext = cordova.getActivity().getApplicationContext();
    }
    
    public void sendMessage(String mobile_number, String message, final CallbackContext callbackContext) {
        
        Intent messageSentIntent = new Intent(MESSAGE_SENT);
        PendingIntent messageSentPendingIntent = PendingIntent.getBroadcast(SMSSenderPlugin.thisContext, 0, messageSentIntent, PendingIntent.FLAG_UPDATE_CURRENT);

        SMSSenderPlugin.thisContext.registerReceiver(new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {

                switch (getResultCode()) {
                    case SmsManager.RESULT_ERROR_GENERIC_FAILURE:
                        callbackContext.error("generic failure");
                        break;
                    case SmsManager.RESULT_ERROR_NO_SERVICE:
                        callbackContext.error("no service");
                        break;
                    case SmsManager.RESULT_ERROR_NULL_PDU:
                        callbackContext.error("null pdu");
                        break;
                    case SmsManager.RESULT_ERROR_RADIO_OFF:
                        callbackContext.error("radio off");
                        break;
                    case Activity.RESULT_OK:
                        callbackContext.success("message sent");
                        break;
                }
            }
        }, new IntentFilter(MESSAGE_SENT));
        
        SmsManager smsManager = SmsManager.getDefault();
        smsManager.sendTextMessage(mobile_number, null, message, messageSentPendingIntent, null);
    }

    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {

        if ("sendMessage".equals(action)) {
            sendMessage(args.get(0).toString(), args.get(1).toString(), callbackContext);
        } else {
            return false;
        }

        return true;    
    }

}