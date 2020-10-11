package com.example.get_share_options
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler


internal class MethodCallHandlerImpl(private val shareOptions: ShareOptions) : MethodCallHandler {

    private var channel: MethodChannel?=null

   override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "getShareOptions" -> onGetShareOptions(result)
            "share" -> onShare(call, result)
            else -> {
                result.notImplemented()
            }
        }
    }

    private fun onShare(call: MethodCall, result: MethodChannel.Result) {

        val activityInfo = call.argument<Map<String,String>>("activityInfo")!!
        val sharedText = call.argument<Map<String,Any>>("content")!!
        shareOptions.share(activityInfo, sharedText);
        result.success(null)
    }

    private fun onGetShareOptions(result: MethodChannel.Result) {
        result.success(shareOptions.getShareOptions())

    }

    fun startListening(messenger: BinaryMessenger) {
        if (channel != null) {
            stopListening()
        }
        channel = MethodChannel(messenger, "share_options")
        channel!!.setMethodCallHandler(this)
    }

    fun stopListening() {
        if (channel == null) {
            return
        }
        channel!!.setMethodCallHandler(null)
        channel = null
    }


}