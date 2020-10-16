package com.example.get_share_options

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.IOException

/** Handles the method calls for the plugin.  */
internal class MethodCallHandler(private val shareOptions: ShareOptions) : MethodChannel.MethodCallHandler {


    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {

            "share" -> onShare(call, result)
            "getShareOptions" -> onGetShareOptions(call, result)
            else -> result.notImplemented()
        }
    }

    private fun onGetShareOptions(call: MethodCall, result: MethodChannel.Result) {
        try {
            val text = call.argument<String>("text")

            val paths = call.argument<List<String>>("paths")

            result.success(shareOptions.getShareOptions(text, paths))

        } catch (e: Throwable) {
            result.error(e.message, null, null);
        }
    }

    private fun onShare(call: MethodCall, result: MethodChannel.Result) {
        expectMapArguments(call)
        val paths = call.argument<List<String>>("paths")
        val text = call.argument<String>("text")
        val subject = call.argument<String>("subject")
        val name = call.argument<String>("name").toString()
        val packageName = call.argument<String>("packageName").toString()

        try {
            shareOptions.share(paths, text, subject, name, packageName)
            result.success(null)
        } catch (e: Throwable) {
//e.cause
//            result.error("0", "Can't found this share app which matches this class or package name on this device",null)
            result.error(e.message, e.localizedMessage, e)
        }
    }

    private fun expectMapArguments(call: MethodCall) {
        require(call.arguments is Map<*, *>) { "Map argument expected" }
    }

}