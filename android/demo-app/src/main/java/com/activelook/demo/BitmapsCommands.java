package com.activelook.demo;

import android.content.ContentResolver;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.provider.MediaStore;
import android.util.Log;
import android.widget.Toast;

import androidx.activity.result.ActivityResultCallback;
import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.core.util.Consumer;

import com.activelook.activelooksdk.Glasses;
import com.activelook.activelooksdk.types.Image1bppData;
import com.activelook.activelooksdk.types.ImageData;
import com.activelook.activelooksdk.types.ImgSaveFormat;
import com.activelook.activelooksdk.types.ImgStreamFormat;

import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.Map;

public class BitmapsCommands extends MainActivity2 {

    @Override
    protected String getCommandGroup() {
        return "Bitmaps commands";
    }

    @Override
    protected Map.Entry<String, Consumer<Glasses>>[] getCommands() {

        return new Map.Entry[]{
                item("clear()", glasses -> glasses.clear()),
                item("imgList", glasses -> glasses.imgList(r -> {
                    BitmapsCommands.this.snack(String.format("imgList: %s", Arrays.toString(r.toArray())));
                })),
                item("imgSave", glasses -> {
                    try {
                        Bitmap img1 = BitmapFactory.decodeStream(getAssets().open("tigre_304x256.png"));
                        glasses.cfgWrite("DemoApp", 1, 42);
                        glasses.imgSave((byte) 0x01, img1, ImgSaveFormat.MONO_4BPP_HEATSHRINK_SAVE_COMP);
                        img1.recycle();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }),
                item("imgSave 2", glasses -> {
                    try {
                        Bitmap img2 = BitmapFactory.decodeStream(getAssets().open("zebre_304x248.png"));
                        glasses.cfgWrite("DemoApp", 1, 42);
                        glasses.imgSave((byte) 0x02, img2, ImgSaveFormat.MONO_4BPP_HEATSHRINK_SAVE_COMP);
                        img2.recycle();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }),
                item("imgSave1bpp", glasses -> {
                    try {
                        Bitmap img3 = BitmapFactory.decodeStream(getAssets().open("glasses_90x36.png"));
                        glasses.cfgWrite("DemoApp", 1, 42);
                        glasses.imgSave((byte) 0x03, img3, ImgSaveFormat.MONO_1BPP);
                        img3.recycle();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }),
                item("imgDisplay", glasses -> {
                    glasses.clear();
                    glasses.cfgSet("DemoApp");
                    glasses.imgDisplay((byte) 0x01, (short) 0, (short) 0);
                }),
                item("imgDisplay 2", glasses -> {
                    glasses.clear();
                    glasses.cfgSet("DemoApp");
                    glasses.imgDisplay((byte) 0x02, (short) 0, (short) 0);
                }),
                item("imgDisplay 1bpp", glasses -> {
                    glasses.clear();
                    glasses.cfgSet("DemoApp");
                    glasses.imgDisplay((byte) 0x03, (short) 77, (short) 112);
                }),
                item("imgDelete", glasses -> {
                    glasses.cfgWrite("DemoApp", 1, 42);
                    glasses.imgDelete((byte) 0x01);
                }),
                item("imgDeleteAll", glasses -> {
                    glasses.cfgWrite("DemoApp", 1, 42);
                    glasses.imgDelete((byte) 0xFF);
                }),
                item("imgStream", glasses -> {
                    try {
                        Bitmap img1 = BitmapFactory.decodeStream(getAssets().open("tigre_304x256.png"));
                        glasses.cfgWrite("DemoApp", 1, 42);
                        glasses.imgStream(img1, ImgStreamFormat.MONO_4BPP_HEATSHRINK, (short) 0, (short) 0);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }),
                item("imgPicker", glasses -> {
                    mGetContent.launch(("image/*"));
                }),
        };
    }

    ActivityResultLauncher<String> mGetContent = registerForActivityResult(new ActivityResultContracts.GetContent(),
            new ActivityResultCallback<Uri>() {
                @Override
                public void onActivityResult(Uri uri) {
                    // Handle the returned Uri
                    ContentResolver cr = getContentResolver();
                    try {
                        Bitmap bitmap = MediaStore.Images.Media.getBitmap(cr, uri);
                        connectedGlasses.clear();
                        connectedGlasses.imgStream(bitmap, ImgStreamFormat.MONO_4BPP_HEATSHRINK, (short)0, (short) 0);
                        bitmap.recycle();
                    } catch (Exception e) {
                        Log.e("imagePicker","Error"+ e.getMessage());
                    }
                }
            }
    );
}
