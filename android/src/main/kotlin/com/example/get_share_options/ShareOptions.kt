package com.example.get_share_options

import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.net.Uri
import com.example.get_share_options.data_classes.ActivityInfoData
import com.example.get_share_options.data_classes.ResolveInfoData
import java.io.File


/** GetShareOptionsPlugin */
class ShareOptions(private val applicationContext: Context) {


    private fun getShareOptionsDataClass(): List<ResolveInfoData> {
        val intent = Intent(Intent.ACTION_SEND)
        intent.type = "text/plain"

        val packageManager = applicationContext.packageManager

        ResolveInfoData.packageManager = packageManager

        val intents = packageManager.queryIntentActivities(
                intent,
                0
        )

        return ResolveInfoData.toResolvesInfo(intents)

    }


    fun getShareOptions(): List<Map<String, Any>> {

        return ResolveInfoData.toMaps(getShareOptionsDataClass())
    }


    fun share(map: Map<String, String>, content: Map<String, Any>) {
        shareDataClass(ActivityInfoData.from(map), content)
    }

    private fun shareDataClass(activityInfo: ActivityInfoData, content: Map<String, Any>) {

        val sendIntent = Intent(Intent.ACTION_SEND).apply {

            val text = content["text"] as String

            val subject = content["subject"] as String

            putExtra(Intent.EXTRA_TEXT, text)

            putExtra(Intent.EXTRA_SUBJECT, subject)

            type = "*/*"

            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)

            component = ComponentName(
                    activityInfo.packageName,
                    activityInfo.name
            )


        }

        applicationContext.startActivity(sendIntent)
    }


}
