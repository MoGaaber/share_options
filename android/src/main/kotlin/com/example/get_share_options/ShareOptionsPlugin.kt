package com.example.get_share_options
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin



class ShareOptionsPlugin : FlutterPlugin {


    private var shareOptions: ShareOptions? = null
    private var methodCallHandler: MethodCallHandlerImpl?=null


    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {

        shareOptions = ShareOptions(flutterPluginBinding.applicationContext)
        methodCallHandler =  MethodCallHandlerImpl(shareOptions!!)
        methodCallHandler!!.startListening(flutterPluginBinding.binaryMessenger)

    }


    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {

        if (methodCallHandler == null) {
            return
        }

        methodCallHandler!!.stopListening()
        methodCallHandler =null
        shareOptions =null
    }

}