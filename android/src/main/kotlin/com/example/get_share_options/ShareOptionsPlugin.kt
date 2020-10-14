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
import io.flutter.plugin.common.PluginRegistry.Registrar

/** Plugin method host for presenting a share sheet via Intent  */
class ShareOptionsPlugin : FlutterPlugin, ActivityAware {
    //    fun registerWith(registrar: Registrar) {
//        val plugin = ShareOptionsPlugin()
//        plugin.setUpChannel(registrar.context(), registrar.activity(), registrar.messenger())
//    }

    private var handler: MethodCallHandler? = null
    private var share: ShareOptions? = null
    private var methodChannel: MethodChannel? = null
    override fun onAttachedToEngine(binding: FlutterPluginBinding) {
        Log.d("Plugin","attached")
        setUpChannel(binding.applicationContext, null, binding.binaryMessenger)
    }

    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
        Log.d("Plugin","onDetachedFromEngine")

        methodChannel!!.setMethodCallHandler(null)
        methodChannel = null
        share = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        Log.d("Plugin","onAttachedToActivity")

        share?.setActivity(binding.activity)
    }

    override fun onDetachedFromActivity() {
        Log.d("Plugin","onDetachedFromActivity")

        tearDownChannel()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        Log.d("Plugin","onReattachedToActivityForConfigChanges")

        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        Log.d("Plugin","onDetachedFromActivityForConfigChanges")

        onDetachedFromActivity()
    }

    private fun setUpChannel(context: Context, activity: Activity?, messenger: BinaryMessenger) {
        Log.d("Plugin","setUpChannel")

        methodChannel = MethodChannel(messenger, Companion.CHANNEL)
        share = ShareOptions(context, activity)
        handler = MethodCallHandler(share!!)
        methodChannel!!.setMethodCallHandler(handler)
    }

    private fun tearDownChannel() {
        Log.d("Plugin","tearDownChannel")

        share?.setActivity(null)
        methodChannel!!.setMethodCallHandler(null)
    }

    companion object {
        private const val CHANNEL = "share_options"
    }

}