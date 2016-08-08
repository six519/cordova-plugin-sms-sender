Supported Platform
==================

iOS/Android

Installation
============

``cordova plugin add https://github.com/six519/cordova-plugin-sms-sender.git``

or via npm

``cordova plugin add cordova-plugin-sms-sender``

Usage
=====
::

    //send sms
    window.sMSSenderPlugin.sendMessage('<MOBILE_NUMBER>', '<MESSAGE>', function(e){
        //success callback
    }, function(e){
        //error callback
        alert('The error is: ' + e);
    });