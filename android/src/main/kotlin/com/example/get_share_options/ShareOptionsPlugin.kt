package com.example.get_share_options

import android.app.Activity
import android.content.Context
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

class ShareOptionsPlugin : FlutterPlugin, ActivityAware {
    companion object {
        private const val CHANNEL = "share_options"
    }

    private var handler: MethodCallHandler? = null
    private var share: ShareOptions? = null
    private var methodChannel: MethodChannel? = null

    override fun onAttachedToEngine(binding: FlutterPluginBinding) {
        Log.d("Plugin","attached")
        setUpChannel(binding.applicationContext,  binding.binaryMessenger)
    }

    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
        Log.d("Plugin","onDetachedFromEngine")

        methodChannel!!.setMethodCallHandler(null)
        methodChannel = null
        share = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        share?.setActivity(binding.activity)
    }

    override fun onDetachedFromActivity() {
        Log.d("Plugin","onDetachedFromActivity")
        share?.setActivity(null)
        methodChannel!!.setMethodCallHandler(null)
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        Log.d("Plugin","onReattachedToActivityForConfigChanges")

        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        Log.d("Plugin","onDetachedFromActivityForConfigChanges")

        onDetachedFromActivity()
    }

    private fun setUpChannel(context: Context, messenger: BinaryMessenger) {
        Log.d("Plugin","setUpChannel")

        methodChannel = MethodChannel(messenger, Companion.CHANNEL)
        share = ShareOptions(context)
        handler = MethodCallHandler(share!!)
        methodChannel!!.setMethodCallHandler(handler)
    }



}