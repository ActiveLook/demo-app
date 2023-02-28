package com.activelook.demo;

import android.content.ContentResolver;
import android.content.Context;
import android.graphics.Bitmap;
import android.net.Uri;
import android.provider.MediaStore;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
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
    LinearLayout newLinearLayout;
    @Override
    protected String getCommandGroup() {
        LinearLayout linearLayout = findViewById(R.id.linearLayout);
        newLinearLayout = new LinearLayout(ViewerCommands.this);
        newLinearLayout.setLayoutParams(new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.MATCH_PARENT));
        newLinearLayout.setOrientation(1);
        linearLayout.addView(newLinearLayout);
        return "Viewer commands";
    }

    @Override
    protected Map.Entry<String, Consumer<Glasses>>[] getCommands() {
        addButtons();
        return new Map.Entry[]{
                item("Add image", glasses -> {
                    mGetContent.launch(("image/*"));
                }),
                item("Display next image", glasses  -> {
                    glasses.clear();
                    glasses.cfgSet("viewer");
                    glasses.demo(DemoPattern.IMAGE);
                }),
                item("Enable gesture", glasses -> {
                    glasses.gesture(true);
                    glasses.subscribeToSensorInterfaceNotifications(() ->
                            gestureNextImg()
                    );
                }),
                item("Read 'viewer' config", glasses -> {
                    glasses.cfgRead(
                            "viewer",
                            r -> snack(String.format("cfgRead: %s", r))
                    );
                }),
                item("erase 'viewer' config", glasses -> {
                    glasses.cfgDelete("viewer");
                    ViewerCommands.this.snack(String.format("Config erased"));
                    newLinearLayout.removeAllViews();
                })
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
                        connectedGlasses.cfgWrite("viewer", 1, 1337);
                        connectedGlasses.cfgRead("viewer", cfgi -> {
                            connectedGlasses.imgSave((byte) cfgi.getNbImg(), bitmap, ImgSaveFormat.MONO_4BPP_HEATSHRINK_SAVE_COMP);
                            bitmap.recycle();
                            connectedGlasses.cfgRead("viewer", r -> snack(String.format("Image saved : n°%s",cfgi.getNbImg())));
                            addButtons();
                        });
                    } catch (Exception e) {
                        Log.e("imagePicker","Error"+ e.getMessage());
                    }
                }
            }
    );

    private void gestureNextImg(){
        connectedGlasses.clear();
        connectedGlasses.cfgSet("viewer");
        connectedGlasses.demo(DemoPattern.IMAGE);
    }

    private Toast toast(Object data) {
        Log.d("viewerCommands", data.toString());
        Toast toast = Toast.makeText(this, data.toString(), Toast.LENGTH_SHORT);
        toast.show();
        return toast;
    }

    private void addButtons(){
        connectedGlasses.cfgRead("viewer", cfgi -> {
            runOnUiThread(() -> {
                newLinearLayout.removeAllViews();

                for(int i = 0; i< cfgi.getNbImg(); i++){
                    final LayoutInflater inflater = (LayoutInflater) this.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
                    View convertView = inflater.inflate(R.layout.command_button, null);
                    convertView.setLayoutParams(new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.MATCH_PARENT));
                    Button button = convertView.findViewById(R.id.command_button);

                    int imageId = i;
                    //Button button = new Button(ViewerCommands.this);
                    button.setText("img "+imageId);
                    newLinearLayout.addView(convertView);
                    button.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            connectedGlasses.clear();
                            connectedGlasses.cfgSet("viewer");
                            connectedGlasses.imgDisplay((byte) imageId, (short) 0, (short) 0);
                        }
                    });
                }
            });
        });
    }
}
