package com.example.get_share_options.data_classes

import android.content.pm.PackageManager
import android.content.pm.ResolveInfo
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.Drawable
import java.io.ByteArrayOutputStream



data class ResolveInfoData   (val resolveInfo: ResolveInfo) {

    private val name: String = resolveInfo.loadLabel(packageManager).toString();
    private val icon: ByteArray = drawableToBytes(resolveInfo.loadIcon(packageManager))
    private val activityInfo: ActivityInfoData = ActivityInfoData(resolveInfo.activityInfo)

    companion object {
        lateinit var packageManager: PackageManager

        fun toResolvesInfo(resolves: List<ResolveInfo>): List<ResolveInfoData> {

            return resolves.map { resolveInfo -> ResolveInfoData(resolveInfo) }
        }

        fun toMaps(resolves: List<ResolveInfoData>): List<Map<String, Any>> {
            return resolves.map { resolveInfo -> resolveInfo.toMap() }
        }

    }

    fun toMap(): Map<String, Any> {
        return mapOf("name" to name, "icon" to icon, "activityInfo" to activityInfo.toMap())
    }



    private fun drawableToBytes(drawable: Drawable): ByteArray {


        val bitmap = getBitmapFromDrawable(drawable)

        val stream = ByteArrayOutputStream()


        bitmap.compress(Bitmap.CompressFormat.PNG, 100, stream)


        return stream.toByteArray()


    }


    private fun getBitmapFromDrawable(drawable: Drawable): Bitmap {
        val bmp: Bitmap =
            Bitmap.createBitmap(drawable.intrinsicWidth, drawable.intrinsicHeight, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bmp)
        drawable.setBounds(0, 0, canvas.width, canvas.height)
        drawable.draw(canvas)
        return bmp
    }
}


