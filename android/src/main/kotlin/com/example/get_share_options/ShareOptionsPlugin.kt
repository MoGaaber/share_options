package com.example.get_share_options

import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.pm.ResolveInfo
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Canvas
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.util.Base64
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.io.ByteArrayOutputStream
import java.io.Serializable


/** GetShareOptionsPlugin */
public class ShareOptionsPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var applicationContext: Context

    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        this.applicationContext = flutterPluginBinding.getApplicationContext()
        channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "share_options")
        channel.setMethodCallHandler(this);

    }


    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "share_options")
            channel.setMethodCallHandler(ShareOptionsPlugin())
        }
    }


    private fun drawableToBytes(drawable: Drawable): ByteArray {


        val bitmap = getBitmapFromDrawable(drawable)

        val stream = ByteArrayOutputStream()


        bitmap.compress(Bitmap.CompressFormat.PNG, 100, stream)

        val bytes = stream.toByteArray()
return  bytes
//        return Base64.encodeToString(bytes, Base64.DEFAULT)


    }


    private fun getBitmapFromDrawable(drawable: Drawable): Bitmap {
        val bmp: Bitmap = Bitmap.createBitmap(drawable.getIntrinsicWidth(), drawable.getIntrinsicHeight(), Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bmp)
        drawable.setBounds(0, 0, canvas.getWidth(), canvas.getHeight())
        drawable.draw(canvas)
        return bmp
    }

    private fun getShareApps(): List<Map<String, Any>> {
        val intent = Intent(Intent.ACTION_SEND)

        intent.type = "text/plain"

        val packageManager = applicationContext.packageManager;

        return packageManager.queryIntentActivities(
                intent,
                0
        ).map { activity ->

            val activityInfo = activity.activityInfo;
            mapOf(
                    "name" to activity.loadLabel(packageManager).toString(),
                    "icon" to drawableToBytes(activity.loadIcon(packageManager)),
                    "activityInfo" to mapOf(
                          "packageName" to  activityInfo.packageName!!,
                            "name" to activityInfo.name!!
                    )
            )
        }
    }

    private fun share(activityInfo:Map<String,String>, sharedText: String) {
        val sendIntent = Intent()

        sendIntent.action = Intent.ACTION_SEND

        sendIntent.type = "text/plain"

        sendIntent.flags = Intent.FLAG_ACTIVITY_NEW_TASK;

        sendIntent.putExtra(Intent.EXTRA_TEXT, sharedText)

        sendIntent.component = ComponentName(
                activityInfo["packageName"]!!,
                activityInfo["name"]!!
                )

        applicationContext.startActivity(sendIntent)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "getShareOptions" -> result.success(getShareApps())
            "share" -> share(call.argument("activityInfo")!!,call.argument("sharedText")!!)
            else -> {
                result.notImplemented()
            }
        }


    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
//    applicationContext = null;

        channel.setMethodCallHandler(null)
    }
}
