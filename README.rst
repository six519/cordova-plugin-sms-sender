Supported Platform
==================

iOS/Android

Installation
============

``cordova plugin add https://github.com/six519/cordova-plugin-sms-sender.git``

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