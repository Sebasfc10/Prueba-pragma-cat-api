package com.example.cat_api_prueba_pragma_jeant

import android.content.Context
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import com.bumptech.glide.Glide
import io.flutter.plugin.platform.PlatformView

class NativeImageView(context: Context, id: Int, creationParams: Map<String, Any>?) : PlatformView {
    private val imageView: ImageView = ImageView(context).apply {
        layoutParams = ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT)
    }

    init {
        val imageUrl = creationParams?.get("imageUrl") as? String
        imageUrl?.let {
            Glide.with(context).load(it).into(imageView)
        }
    }

    override fun getView(): View {
        return imageView
    }

    override fun dispose() {}
}
