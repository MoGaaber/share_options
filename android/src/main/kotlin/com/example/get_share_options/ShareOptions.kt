package com.example.get_share_options

import android.app.Activity
import android.content.ComponentName
import android.content.ContentResolver
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Environment
import android.util.Log
import android.webkit.MimeTypeMap
import androidx.core.content.FileProvider
import com.example.get_share_options.data_classes.ResolveInfoData
import java.io.*
import java.util.*


internal class ShareOptions(private val context: Context?, private var activity: Activity?) {

    fun setActivity(activity: Activity?) {
        this.activity = activity
    }

    private fun getShareIntent(paths: List<String?>?): Intent {
        var shareIntent: Intent = Intent()
        if (paths.isNullOrEmpty()) {
            shareIntent = share(shareIntent)
        }

        else {

            val fileUris = getUrisForPaths(paths)
            val mimeTypes: List<String?> = fileUris.map { e -> getMimeType(e) }
            Log.d("tag", mimeTypes.toString())
            when {
                fileUris.isEmpty() -> {
                    shareIntent = share(shareIntent)

                }
                fileUris.size == 1 -> {
                    shareIntent.action = Intent.ACTION_SEND
                    shareIntent.type = if (mimeTypes.isNotEmpty() && mimeTypes[0] != null) mimeTypes[0] else "*/*"
                    shareIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                }
                else -> {
                    shareIntent.action = Intent.ACTION_SEND_MULTIPLE
                    shareIntent.type = (reduceMimeTypes(mimeTypes));
                    shareIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)

                }
            }

        }


        return shareIntent
    }


    private fun getShareOptionsDataClass(paths: List<String>?): List<ResolveInfoData> {

        val packageManager = getContext().packageManager

        ResolveInfoData.packageManager = packageManager

        val intents = packageManager.queryIntentActivities(
                getShareIntent(paths),
                0
        )

        return ResolveInfoData.toResolvesInfo(intents)

    }


    fun getShareOptions(paths: List<String>?): List<Map<String, Any>> {

        return ResolveInfoData.toMaps(getShareOptionsDataClass(paths))
    }


    private fun share(shareIntent: Intent): Intent {
        shareIntent.action = Intent.ACTION_SEND
        shareIntent.type = "text/plain"

        return shareIntent
    }

    private fun getMimeType(uri: Uri): String? {
        var mimeType: String? = null
        mimeType = if (uri.scheme == ContentResolver.SCHEME_CONTENT) {
            val cr: ContentResolver = getContext().contentResolver
            cr.getType(uri)
        } else {
            val fileExtension = MimeTypeMap.getFileExtensionFromUrl(uri
                    .toString())
            MimeTypeMap.getSingleton().getMimeTypeFromExtension(
                    fileExtension.toLowerCase())
        }
        return mimeType
    }


    fun share(paths: List<String?>?, text: String?, subject: String?, name: String, packageName: String) {
        var shareIntent = getShareIntent(paths)

        if (paths.isNullOrEmpty()) {
            shareIntent = share(shareIntent)

        } else {

            clearExternalShareFolder()

            val fileUris = getUrisForPaths(paths)
            when {
                fileUris.isEmpty() -> {
                    shareIntent = share(shareIntent)

                }
                fileUris.size == 1 -> {

                    shareIntent.putExtra(Intent.EXTRA_STREAM, fileUris[0])
                }
                else -> {

                    shareIntent.putParcelableArrayListExtra(Intent.EXTRA_STREAM, fileUris)

                }
            }

        }
        if (!text.isNullOrBlank()) shareIntent.putExtra(Intent.EXTRA_TEXT, text)

        if (!subject.isNullOrBlank()) shareIntent.putExtra(Intent.EXTRA_SUBJECT, subject)

        shareIntent.component = ComponentName(
                packageName,
                name
        )

        startActivity(shareIntent)

    }

    private fun reduceMimeTypes(mimeTypes: List<String?>): String? {
        return if (mimeTypes.size > 1) {
            var reducedMimeType = mimeTypes[0]
            for (i in 1 until mimeTypes.size) {
                val mimeType = mimeTypes[i]
                if (reducedMimeType != mimeType) {
                    if (getMimeTypeBase(mimeType) == getMimeTypeBase(reducedMimeType)) {
                        reducedMimeType = getMimeTypeBase(mimeType) + "/*"
                    } else {
                        reducedMimeType = "*/*"
                        break
                    }
                }
            }
            reducedMimeType
        } else if (mimeTypes.size == 1) {
            mimeTypes[0]
        } else {
            "*/*"
        }
    }

    private fun getMimeTypeBase(mimeType: String?): String {
        return if (mimeType == null || !mimeType.contains("/")) {
            "*"
        } else mimeType.substring(0, mimeType.indexOf("/"))
    }

    private fun startActivity(intent: Intent) {
        when {
            activity != null -> {
                activity!!.startActivity(intent)
            }
            context != null -> {
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                context.startActivity(intent)
            }
            else -> {
                throw IllegalStateException("Both context and activity are null")
            }
        }
    }

    private fun getUrisForPaths(paths: List<String?>): ArrayList<Uri> {
        val uris = ArrayList<Uri>(paths.size)
        for (path in paths) {
            var file = File(path)
            if (!fileIsOnExternal(file)) {
                file = copyToExternalShareFolder(file)
            }
            uris.add(
                    FileProvider.getUriForFile(
                            getContext(), getContext().packageName + ".flutter.share_provider", file))
        }
        return uris
    }


    private fun fileIsOnExternal(file: File): Boolean {
        return try {
            val filePath = file.canonicalPath
            val externalDir = Environment.getExternalStorageDirectory()
            externalDir != null && filePath.startsWith(externalDir.canonicalPath)
        } catch (e: IOException) {
            false
        }
    }

    private fun clearExternalShareFolder() {
        val folder = externalShareFolder
        if (folder.exists()) {
            for (file in folder.listFiles()) {
                file.delete()
            }
            folder.delete()
        }
    }

    private fun copyToExternalShareFolder(file: File): File {
        val folder = externalShareFolder
        if (!folder.exists()) {
            folder.mkdirs()
        }
        val newFile = File(folder, file.name)
        copy(file, newFile)
        return newFile
    }

    private val externalShareFolder: File
        get() = File(getContext().externalCacheDir, "share")

    private fun getContext(): Context {
        if (activity != null) {
            return activity as Activity
        }
        if (context != null) {
            return context
        }
        throw IllegalStateException("Both context and activity are null")
    }

    private fun copy(src: File, dst: File) {
        val inputStream: InputStream = FileInputStream(src)
        try {
            val out: OutputStream = FileOutputStream(dst)
            try {
                // Transfer bytes from in to out
                val buf = ByteArray(1024)
                var len: Int
                while (inputStream.read(buf).also { len = it } > 0) {
                    out.write(buf, 0, len)
                }
            } finally {
                out.close()
            }
        } finally {
            inputStream.close()
        }
    }
}