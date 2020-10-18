package com.example.get_share_options

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.IOException

/** Handles the method calls for the plugin.  */
internal class MethodCallHandler(private val shareOptions: ShareOptions) : MethodChannel.MethodCallHandler {


    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "shareFiles" -> expectMapArguments(call,result,::onShareFiles)
            "shareText" -> expectMapArguments(call,result,::onShareText)
            "getShareOptions" -> expectMapArguments(call, result,::onGetShareOptions)
            else -> result.notImplemented()
        }
    }

    private fun onShareFiles(call: MethodCall, result: MethodChannel.Result) {

        val action = call.argument<String>("action")!!
        val mimeType = call.argument<String>("mimeType")!!

        val paths = call.argument<List<String>>("paths")!!

        val text = call.argument<String>("text")
        val subject = call.argument<String>("subject")

        val name = call.argument<String>("name")!!
        val packageName = call.argument<String>("packageName")!!

        try {
            shareOptions.shareFiles(action,mimeType, paths, text, subject, name, packageName)
            result.success(null)
        } catch (e: IOException) {

            result.error(e.localizedMessage, e.message, e.cause)
        }

    }

    private fun onGetShareOptions(call: MethodCall, result: MethodChannel.Result) {

            val action = call.argument<String>("action")!!

            val type = call.argument<String>("mimeType")!!
        try {

            result.success(shareOptions.getShareOptions(action, type))

        } catch (e: IOException) {
            result.error(e.localizedMessage, e.message, e.cause)
        }
    }

    private fun onShareText(call: MethodCall, result: MethodChannel.Result) {
        val text = call.argument<String>("text")!!
        val subject = call.argument<String>("subject")
        val name = call.argument<String>("name")!!
        val packageName = call.argument<String>("packageName")!!
        try {
            shareOptions.shareText(text, subject, name, packageName)
            result.success(null)
        } catch (e: IOException) {
            result.error(e.localizedMessage, e.message, e.cause)
        }
    }

    private fun expectMapArguments(call: MethodCall, result: MethodChannel.Result, method: (call: MethodCall, result: MethodChannel.Result) -> Unit) {
        require(call.arguments is Map<*, *>) { "Map argument expected" }
        method(call, result);

    }


}