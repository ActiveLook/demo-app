package com.activelook.demo;

import android.app.Application;

import androidx.core.util.Consumer;
import androidx.core.util.Predicate;

import com.activelook.activelooksdk.Sdk;
import com.activelook.activelooksdk.types.GlassesUpdate;

public class DemoApp extends Application {

    private Sdk alsdk;
    private boolean connected;
    private Consumer<GlassesUpdate> onUpdateStart;
    private Predicate<GlassesUpdate> onUpdateAvailableCallback;
    private Consumer<GlassesUpdate> onUpdateProgress;
    private Consumer<GlassesUpdate> onUpdateSuccess;
    private Consumer<GlassesUpdate> onUpdateError;

    @Override
    public void onCreate() {
        super.onCreate();
        this.connected = false;
        this.onUpdateStart = null;
        this.onUpdateAvailableCallback = null;
        this.onUpdateProgress = null;
        this.onUpdateSuccess = null;
        this.onUpdateError = null;
        this.alsdk = Sdk.init(
            this.getApplicationContext(),
            "x0Ovb1evWAaw_22pzcaL-RMMqGjpYbeUF1Kt0wVIm2Y",
            this::onUpdateStart,
            this::onUpdateAvailableCallback,
            this::onUpdateProgress,
            this::onUpdateSuccess,
            this::onUpdateError
        );
    }

    public Sdk getActiveLookSdk(final Consumer<GlassesUpdate> onUpdateStart,
                                final Predicate<GlassesUpdate> onUpdateAvailableCallback,
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
    private boolean onUpdateAvailableCallback(final GlassesUpdate glassesUpdate) {
        if (this.onUpdateAvailableCallback != null) {
            return this.onUpdateAvailableCallback.test(glassesUpdate);
        }
        return false;
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
