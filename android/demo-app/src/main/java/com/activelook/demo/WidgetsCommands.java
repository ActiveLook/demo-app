package com.activelook.demo;

import androidx.core.util.Consumer;

import com.activelook.activelooksdk.Glasses;
import com.activelook.activelooksdk.types.TextSegment;
import com.activelook.activelooksdk.types.WidgetValueType;
import com.activelook.activelooksdk.types.Rotation;
import com.activelook.activelooksdk.types.TextHorizontalAlignment;
import com.activelook.activelooksdk.types.TextVerticalAlignment;

import java.util.Map;

public class WidgetsCommands extends MainActivity2 {

    @Override
    protected String getCommandGroup() {
        return "Widgets commands";
    }

    @Override
    protected Map.Entry<String, Consumer<Glasses>>[] getCommands() {
        return new Map.Entry[]{
                item("clear", glasses -> {
                    glasses.clear();
                }),
                item("Widget Open Gauge", glasses -> {
                    glasses.clear();
                    glasses.widgetOpenGauge((short)30, (short)30, (byte)(50), (byte)(1), WidgetValueType.WIDGET_VAL_TYPE_DUR_HMS, " ", "1:03:24");
                }),
                item("Widget Range Gauge", glasses -> {
                    glasses.clear();
                    glasses.widgetRangeGauge((short)30, (short)30, (byte)(50), (byte)(2), WidgetValueType.WIDGET_VAL_TYPE_NUMBER, "W", "1200", "120", "2000");
                }),
                item("Widget Zones Gauge", glasses -> {
                    glasses.clear();
                    glasses.widgetZoneGauge((short)30, (short)30, (byte)(50), (byte)(3), WidgetValueType.WIDGET_VAL_TYPE_TEXT, "BPM", "80", (byte)(2), (byte)(5));
                }),
                item("Widget Progress Bar", glasses -> {
                    glasses.clear();
                    glasses.widgetProgressBar( (short)30, (short)30, (byte)(50), (byte)(4), WidgetValueType.WIDGET_VAL_TYPE_NUMBER, "kCal", "125.2", "640");
                }),
                item("Text Advanced", glasses -> {
                    glasses.clear();
                    glasses.txtAdvanced((short)(100), (short)(100), Rotation.TOP_LR, TextHorizontalAlignment.TXT_ALIGN_CENTER, TextVerticalAlignment.TXT_ALIGN_BASELINE, (byte) 2, new TextSegment[] {new TextSegment("bon",(byte)3,(byte)15), new TextSegment("jour",(byte)1,(byte)4)});
                }),
        };
    }

}
