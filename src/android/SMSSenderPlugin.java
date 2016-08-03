package com.ferdinandsilva.android;

import java.util.Arrays;
import java.util.ArrayList;
import java.util.List;

import android.content.Context;
import android.content.Intent;
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

    public SMSSenderPlugin() {
    }

    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
    }
    
    public void sendMessage(String mobile_number, String message) {
        SmsManager smsManager = SmsManager.getDefault();
        smsManager.sendTextMessage(mobile_number, null, message, null, null);
    }

    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {

        JSONObject r = new JSONObject();

        if ("sendMessage".equals(action)) {
            sendMessage(args.get(0).toString(), args.get(1).toString());
            r.put("ok", "ok");
            callbackContext.success(r);
        } else {
            return false;
        }

        return true;    
    }

}