package com.heyteago.photoview;

import android.content.Intent;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;

import java.util.ArrayList;

public class ReactNativePhotoViewModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;

    public ReactNativePhotoViewModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "ReactNativePhotoView";
    }

    @ReactMethod
    public void previewImage(ReadableMap option, Promise promise) {
        String[] urls = new String[0];
        String current = "";
        try {
            ReadableArray array = option.getArray("urls");
            if (array != null) {
                int count = array.size();
                urls = new String[count];
                for (int i = 0; i < count; i++) {
                    urls[i] = array.getString(i);
                }
            }
            current = option.getString("current");
        } catch (Exception e) {
            promise.reject(e);
        }
        if (urls.length > 0) {
            Intent intent = new Intent(getCurrentActivity(), PhotoViewActivity.class);
            intent.putExtra("urls", urls);
            intent.putExtra("current", current);
            getCurrentActivity().startActivity(intent);
            promise.resolve(true);
        }
        promise.resolve(false);
    }
}
