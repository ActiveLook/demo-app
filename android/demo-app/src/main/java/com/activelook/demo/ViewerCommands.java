package com.activelook.demo;

import android.content.ContentResolver;
import android.graphics.Bitmap;
import android.net.Uri;
import android.provider.MediaStore;
import android.util.Log;
import android.widget.Toast;

import androidx.activity.result.ActivityResultCallback;
import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.core.util.Consumer;

import com.activelook.activelooksdk.Glasses;
import com.activelook.activelooksdk.types.DemoPattern;
import com.activelook.activelooksdk.types.ImgSaveFormat;

import java.util.Map;

public class ViewerCommands extends MainActivity2 {

    @Override
    protected String getCommandGroup() {
        return "Viewer commands";
    }

    @Override
    protected Map.Entry<String, Consumer<Glasses>>[] getCommands() {

        Glasses connectedGlasses;
        return new Map.Entry[]{
                item("erase Cfg", glasses -> {
                    glasses.cfgDelete("Viewer");
                    ViewerCommands.this.snack(String.format("Config erased"));
                }),
                item("Cfg read", glasses -> {
                    glasses.cfgRead(
                            "Viewer",
                            r -> snack(String.format("cfgRead: %s", r))
                    );
                }),
                item("imgSave", glasses -> {
                    mGetContent.launch(("image/*"));
                }),
                item("Next image", glasses  -> {
                    glasses.clear();
                    glasses.cfgSet("Viewer");
                    glasses.demo(DemoPattern.IMAGE);
                }),
                item("Enable gesture", glasses -> {
                    glasses.gesture(true);
                    glasses.subscribeToSensorInterfaceNotifications(() ->
                            gestureNextImg()
                    );
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
                        toast(String.format("Saving image..."));
                        Bitmap bitmap = MediaStore.Images.Media.getBitmap(cr, uri);
                        connectedGlasses.cfgWrite("Viewer", 1, 1337);
                        connectedGlasses.cfgRead("Viewer", cfgi -> {
                            connectedGlasses.imgSave((byte) cfgi.getNbImg(), bitmap, ImgSaveFormat.MONO_4BPP_HEATSHRINK_SAVE_COMP);
                            bitmap.recycle();
                            connectedGlasses.cfgRead("Viewer", r -> snack(String.format("Image saved : n°%s",cfgi.getNbImg())));
                        });
                    } catch (Exception e) {
                        Log.e("imagePicker","Error"+ e.getMessage());
                    }
                }
            }
    );

    private void gestureNextImg(){
        connectedGlasses.clear();
        connectedGlasses.cfgSet("Viewer");
        connectedGlasses.demo(DemoPattern.IMAGE);
    }

    private Toast toast(Object data) {
        Log.d("ViewerCommands", data.toString());
        Toast toast = Toast.makeText(this, data.toString(), Toast.LENGTH_SHORT);
        toast.show();
        return toast;
    }
}
