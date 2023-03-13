package com.activelook.demo;

import androidx.core.util.Consumer;

import com.activelook.activelooksdk.Glasses;
import com.activelook.activelooksdk.types.TextSegment;
import com.activelook.activelooksdk.types.WidgetValueType;
import com.activelook.activelooksdk.types.Rotation;
import com.activelook.activelooksdk.types.TextHorizontalAlignment;
import com.activelook.activelooksdk.types.TextVerticalAlignment;
import com.activelook.activelooksdk.types.WidgetSize;

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
                item("Widget Open Gauge Large", glasses -> {
                    glasses.clear();
                    glasses.widgetOpenGauge(WidgetSize.WIDGET_SIZE_LARGE, (short)30, (short)30, (byte)(50), (byte)(1), WidgetValueType.WIDGET_VAL_TYPE_DUR_HMS, " ", "1:03:24");
                }),
                item("Widget Open Gauge Thin", glasses -> {
                    glasses.clear();
                    glasses.widgetOpenGauge(WidgetSize.WIDGET_SIZE_THIN, (short)30, (short)30, (byte)(50), (byte)(1), WidgetValueType.WIDGET_VAL_TYPE_DUR_HMS, " ", "1:03:24");
                }),
                item("Widget Open Gauge Half", glasses -> {
                    glasses.clear();
                    glasses.widgetOpenGauge(WidgetSize.WIDGET_SIZE_HALF, (short)30, (short)30, (byte)(50), (byte)(1), WidgetValueType.WIDGET_VAL_TYPE_DUR_HMS, " ", "1:03:24");
                }),
                item("Widget Range Gauge Large", glasses -> {
                    glasses.clear();
                    glasses.widgetRangeGauge(WidgetSize.WIDGET_SIZE_LARGE, (short)30, (short)30, (byte)(50), (byte)(1), WidgetValueType.WIDGET_VAL_TYPE_NUMBER, "W", "1200", "120", "2000");
                }),
                item("Widget Range Gauge Thin", glasses -> {
                    glasses.clear();
                    glasses.widgetRangeGauge(WidgetSize.WIDGET_SIZE_THIN, (short)30, (short)30, (byte)(50), (byte)(1), WidgetValueType.WIDGET_VAL_TYPE_NUMBER, "W", "1200", "120", "2000");
                }),
                item("Widget Range Gauge Half", glasses -> {
                    glasses.clear();
                    glasses.widgetRangeGauge(WidgetSize.WIDGET_SIZE_HALF, (short)30, (short)30, (byte)(50), (byte)(1), WidgetValueType.WIDGET_VAL_TYPE_NUMBER, "W", "1200", "120", "2000");
                }),
                item("Widget Zones Gauge Large", glasses -> {
                    glasses.clear();
                    glasses.widgetZoneGauge(WidgetSize.WIDGET_SIZE_LARGE, (short)30, (short)30, (byte)(50), (byte)(1), WidgetValueType.WIDGET_VAL_TYPE_TEXT, "BPM", "80", (byte)(2), (byte)(5));
                }),
                item("Widget Zones Gauge Thin", glasses -> {
                    glasses.clear();
                    glasses.widgetZoneGauge(WidgetSize.WIDGET_SIZE_THIN, (short)30, (short)30, (byte)(50), (byte)(1), WidgetValueType.WIDGET_VAL_TYPE_TEXT, "BPM", "80", (byte)(2), (byte)(5));
                }),
                item("Widget Zones Gauge Half", glasses -> {
                    glasses.clear();
                    glasses.widgetZoneGauge(WidgetSize.WIDGET_SIZE_HALF, (short)30, (short)30, (byte)(50), (byte)(1), WidgetValueType.WIDGET_VAL_TYPE_TEXT, "BPM", "80", (byte)(2), (byte)(5));
                }),
                item("Widget Target Large", glasses -> {
                    glasses.clear();
                    glasses.widgetProgressBar(WidgetSize.WIDGET_SIZE_LARGE, (short)30, (short)30, (byte)(50), (byte)(1), WidgetValueType.WIDGET_VAL_TYPE_NUMBER, "kCal", "125.2", "640", false);
                }),
                item("Widget Target Thin", glasses -> {
                    glasses.clear();
                    glasses.widgetProgressBar(WidgetSize.WIDGET_SIZE_THIN, (short)30, (short)30, (byte)(50), (byte)(1), WidgetValueType.WIDGET_VAL_TYPE_NUMBER, "kCal", "125.2", "640", false);
                }),
                item("Widget Target Half", glasses -> {
                    glasses.clear();
                    glasses.widgetProgressBar(WidgetSize.WIDGET_SIZE_HALF, (short)30, (short)30, (byte)(50), (byte)(1), WidgetValueType.WIDGET_VAL_TYPE_NUMBER, "kCal", "125.2", "640", false);
                }),
                item("Widget Target Left Large", glasses -> {
                    glasses.clear();
                    glasses.widgetProgressBar(WidgetSize.WIDGET_SIZE_LARGE, (short)30, (short)30, (byte)(50), (byte)(1), WidgetValueType.WIDGET_VAL_TYPE_NUMBER, "kCal", "125.2", "640", true);
                }),
                item("Widget Target Left Thin", glasses -> {
                    glasses.clear();
                    glasses.widgetProgressBar(WidgetSize.WIDGET_SIZE_THIN, (short)30, (short)30, (byte)(50), (byte)(1), WidgetValueType.WIDGET_VAL_TYPE_NUMBER, "kCal", "125.2", "640", true);
                }),
                item("Widget Target Left Half", glasses -> {
                    glasses.clear();
                    glasses.widgetProgressBar(WidgetSize.WIDGET_SIZE_HALF, (short)30, (short)30, (byte)(50), (byte)(1), WidgetValueType.WIDGET_VAL_TYPE_NUMBER, "kCal", "125.2", "640", true);
                }),
                item("Widget Bar Chart Large", glasses -> {
                    glasses.clear();
                    byte values[] = {(byte)200, (byte)150, (byte)100, (byte)130, (byte)30};
                    glasses.widgetBarChart(WidgetSize.WIDGET_SIZE_LARGE, (short)30, (short)30, (byte)(1), WidgetValueType.WIDGET_VAL_TYPE_NUMBER, "kCal", "125.2", (byte) 2, (byte) 5, values);
                }),
                item("Widget Bar Chart Thin", glasses -> {
                    glasses.clear();
                    byte values[] = {(byte)200, (byte)150, (byte)100, (byte)130, (byte)30};
                    glasses.widgetBarChart(WidgetSize.WIDGET_SIZE_THIN, (short)30, (short)30, (byte)(1), WidgetValueType.WIDGET_VAL_TYPE_NUMBER, "kCal", "125.2", (byte) 2, (byte) 5, values);
                }),
                item("Widget Bar Chart Half", glasses -> {
                    glasses.clear();
                    byte values[] = {(byte)200, (byte)150, (byte)100, (byte)130, (byte)30};
                    glasses.widgetBarChart(WidgetSize.WIDGET_SIZE_HALF, (short)30, (short)30, (byte)(1), WidgetValueType.WIDGET_VAL_TYPE_NUMBER, "kCal", "125.2", (byte) 2, (byte) 5, values);
                }),
                item("Widget Data Large", glasses -> {
                    glasses.clear();
                    glasses.widgetData(WidgetSize.WIDGET_SIZE_LARGE, (short)30, (short)30, (byte)(1), WidgetValueType.WIDGET_VAL_TYPE_NUMBER, "kCal", "125.2");
                }),
                item("Widget Data Thin", glasses -> {
                    glasses.clear();
                    glasses.widgetData(WidgetSize.WIDGET_SIZE_THIN, (short)30, (short)30, (byte)(1), WidgetValueType.WIDGET_VAL_TYPE_NUMBER, "kCal", "125.2");
                }),
                item("Widget Data Half", glasses -> {
                    glasses.clear();
                    glasses.widgetData(WidgetSize.WIDGET_SIZE_HALF, (short)30, (short)30, (byte)(1), WidgetValueType.WIDGET_VAL_TYPE_NUMBER, "kCal", "125.2");
                }),
                item("Text Advanced", glasses -> {
                    glasses.clear();
                    glasses.txtAdvanced((short)(100), (short)(100), Rotation.TOP_LR, TextHorizontalAlignment.TXT_ALIGN_CENTER, TextVerticalAlignment.TXT_ALIGN_BASELINE, (byte) 2, new TextSegment[] {new TextSegment("bon",(byte)3,(byte)15), new TextSegment("jour",(byte)1,(byte)4)});
                }),
        };
    }

}
