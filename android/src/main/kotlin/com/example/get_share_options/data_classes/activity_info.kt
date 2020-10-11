package com.example.get_share_options.data_classes

import android.content.pm.ActivityInfo

data class ActivityInfoData(val name :String, val packageName :String) {

    constructor(activityInfo: ActivityInfo):this(activityInfo.name,activityInfo.packageName)

    companion object {

        fun from(map: Map<String, String>) = object {
            val name by map
            val packageName by map
            val data = ActivityInfoData(name, packageName)
        }.data
    }


    fun toMap(): Map<String, String> {
        return mapOf("name" to name, "packageName" to packageName)
    }



}
