package com.activelook.demo;

import android.app.Application;
import android.util.Log;
import android.util.Pair;

import androidx.core.util.Consumer;
import androidx.core.util.Predicate;

import com.activelook.activelooksdk.Sdk;
import com.activelook.activelooksdk.types.GlassesUpdate;

public class DemoApp extends Application {

    private Sdk alsdk;
    private boolean connected;
    private String token = BuildConfig.ACTIVELOOK_SDK_TOKEN;
    private Consumer<GlassesUpdate> onUpdateStart;
    private Consumer<Pair<GlassesUpdate, Runnable>> onUpdateAvailableCallback;
    private Consumer<GlassesUpdate> onUpdateProgress;
    private Consumer<GlassesUpdate> onUpdateSuccess;
    private Consumer<GlassesUpdate> onUpdateError;

    @Override
    public void onCreate() {
        super.onCreate();
        this.connected = false;
        this.onUpdateStart = gu -> {
            Log.d("GLASSES_UPDATE", String.format("onUpdateStart    : %s", gu));
        };
        this.onUpdateAvailableCallback = gu_f -> {
            Log.d("GLASSES_UPDATE", String.format("onUpdateAvailableCallback   : %s", gu_f.first));
            gu_f.second.run();
        };
        this.onUpdateProgress = gu -> {
            Log.d("GLASSES_UPDATE", String.format("onUpdateProgress : %s", gu));
        };
        this.onUpdateSuccess = gu -> {
            Log.d("GLASSES_UPDATE", String.format("onUpdateSuccess  : %s", gu));
        };
        this.onUpdateError = gu -> {
            Log.d("GLASSES_UPDATE", String.format("onUpdateError  : %s", gu));
        };
        this.alsdk = Sdk.init(this.getApplicationContext(),
            token,
            this::onUpdateStart,
            this::onUpdateAvailableCallback,
            this::onUpdateProgress,
            this::onUpdateSuccess,
            this::onUpdateError
        );
    }

    public Sdk getActiveLookSdk(final Consumer<GlassesUpdate> onUpdateStart,
                                final Consumer<Pair<GlassesUpdate, Runnable>> onUpdateAvailableCallback,
                                final Consumer<GlassesUpdate> onUpdateProgress,
                                final Consumer<GlassesUpdate> onUpdateSuccess,
                                final Consumer<GlassesUpdate> onUpdateError) {
        this.onUpdateStart = onUpdateStart;
        this.onUpdateAvailableCallback = onUpdateAvailableCallback;
        this.onUpdateProgress = onUpdateProgress;
        this.onUpdateSuccess = onUpdateSuccess;
        this.onUpdateError = onUpdateError;
        return this.alsdk;
    }

    public boolean isConnected() {
        return this.connected;
    }

    public void onConnected() {
        this.connected = true;
    }

    public void onDisconnected() {
        this.connected = false;
    }

    private void onUpdateStart(final GlassesUpdate glassesUpdate) {
        if (this.onUpdateStart != null) {
            this.onUpdateStart.accept(glassesUpdate);
        }
    }
    private void onUpdateAvailableCallback(final android.util.Pair<GlassesUpdate, Runnable> glassesUpdate) {
        if (this.onUpdateAvailableCallback != null) {
            this.onUpdateAvailableCallback.accept(glassesUpdate);
        }
    }
    private void onUpdateProgress(final GlassesUpdate glassesUpdate) {
        if (this.onUpdateProgress != null) {
            this.onUpdateProgress.accept(glassesUpdate);
        }
    }
    private void onUpdateSuccess(final GlassesUpdate glassesUpdate) {
        if (this.onUpdateSuccess != null) {
            this.onUpdateSuccess.accept(glassesUpdate);
        }
    }
    private void onUpdateError(final GlassesUpdate glassesUpdate) {
        if (this.onUpdateError != null) {
            this.onUpdateError.accept(glassesUpdate);
        }
    }

}
