/*
 
Copyright 2021 Microoled
Licensed under the Apache License, Version 2.0 (the “License”);
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an “AS IS” BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
 
*/

import Foundation
import ActiveLookSDK

class WidgetCommandsViewController : CommandsTableViewController {
    

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Widget commands"
        
        commandNames = [
            "Widget Open Gauge Large",
            "Widget Open Gauge Thin",
            "Widget Open Gauge Half",
            "Widget Range Gauge Large",
            "Widget Range Gauge Thin",
            "Widget Range Gauge Half",
            "Widget Zones Gauge Large",
            "Widget Zones Gauge Thin",
            "Widget Zones Gauge Half",
            "Widget Target Large",
            "Widget Target Thin",
            "Widget Target Half",
            "Widget Target Left Large",
            "Widget Target Left Thin",
            "Widget Target Left Half",
            "Widget Bar Chart Large",
            "Widget Bar Chart Thin",
            "Widget Bar Chart Half",
            "Widget Data Large",
            "Widget Data Thin",
            "Widget Data Half",
            "Clear"
        ]

        commandActions = [
            self.widgetOpenGaugeLarge,
            self.widgetOpenGaugeThin,
            self.widgetOpenGaugeHalf,
            self.widgetRangeGaugeLarge,
            self.widgetRangeGaugeThin,
            self.widgetRangeGaugeHalf,
            self.widgetZonesGaugeLarge,
            self.widgetZonesGaugeThin,
            self.widgetZonesGaugeHalf,
            self.widgetTargetLarge,
            self.widgetTargetThin,
            self.widgetTargetHalf,
            self.widgetTargetLeftLarge,
            self.widgetTargetLeftThin,
            self.widgetTargetLeftHalf,
            self.widgetBarChartLarge,
            self.widgetBarChartThin,
            self.widgetBarChartHalf,
            self.widgetDataLarge,
            self.widgetDataThin,
            self.widgetDataHalf,
            self.clear
        ]
    }
    
    
    // MARK: - Actions
    func widgetOpenGaugeLarge(){
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        glasses.widgetOpenGauge(size: WidgetSize.large, x: 30, y: 30, value: 50, imgId: 1, valueType: WidgetValueType.duration_hms, unit: " ", shownValue:"1:03:24")
    }

    func widgetOpenGaugeThin(){
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        glasses.widgetOpenGauge(size: WidgetSize.thin, x: 30, y: 30, value: 50, imgId: 1, valueType: WidgetValueType.duration_hms, unit: " ", shownValue:"1:03:24")
    }

    func widgetOpenGaugeHalf(){
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        glasses.widgetOpenGauge(size: WidgetSize.half, x: 30, y: 30, value: 50, imgId: 1, valueType: WidgetValueType.duration_hms, unit: " ", shownValue:"1:03:24")
    }

    func widgetRangeGaugeLarge(){
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        glasses.widgetRangeGauge(size: WidgetSize.large, x: 30, y: 30, value: 50, imgId: 1, valueType: WidgetValueType.number, unit: "W", shownValue:"1200", min: "120", max: "2000")
    }

    func widgetRangeGaugeThin(){
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        glasses.widgetRangeGauge(size: WidgetSize.thin, x: 30, y: 30, value: 50, imgId: 1, valueType: WidgetValueType.number, unit: "W", shownValue:"1200", min: "120", max: "2000")
    }

    func widgetRangeGaugeHalf(){
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        glasses.widgetRangeGauge(size: WidgetSize.half, x: 30, y: 30, value: 50, imgId: 1, valueType: WidgetValueType.number, unit: "W", shownValue:"1200", min: "120", max: "2000")
    }

    func widgetZonesGaugeLarge(){
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        glasses.widgetGaugeZone(size: WidgetSize.large, x: 30, y: 30, value: 50, imgId: 1, valueType: WidgetValueType.text, unit: "BPM", shownValue:"80", chosenZone: 2, zoneNb: 5)
    }

    func widgetZonesGaugeThin(){
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        glasses.widgetGaugeZone(size: WidgetSize.thin, x: 30, y: 30, value: 50, imgId: 1, valueType: WidgetValueType.text, unit: "BPM", shownValue:"80", chosenZone: 2, zoneNb: 5)
    }

    func widgetZonesGaugeHalf(){
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        glasses.widgetGaugeZone(size: WidgetSize.half, x: 30, y: 30, value: 50, imgId: 1, valueType: WidgetValueType.text, unit: "BPM", shownValue:"80", chosenZone: 2, zoneNb: 5)
    }

    func widgetTargetLarge(){
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        glasses.widgetTargetLeft(size: WidgetSize.large, x: 30, y: 30, value: 50, imgId: 1, valueType: WidgetValueType.number, unit: "kCal", shownValue:"125.2", goal: "640")
    }

    func widgetTargetThin(){
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        glasses.widgetTargetLeft(size: WidgetSize.thin, x: 30, y: 30, value: 50, imgId: 1, valueType: WidgetValueType.number, unit: "kCal", shownValue:"125.2", goal: "640")
    }

    func widgetTargetHalf(){
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        glasses.widgetTargetLeft(size: WidgetSize.half, x: 30, y: 30, value: 50, imgId: 1, valueType: WidgetValueType.number, unit: "kCal", shownValue:"125.2", goal: "640")
    }

    func widgetTargetLeftLarge(){
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        glasses.widgetTargetLeft(size: WidgetSize.large, x: 30, y: 30, value: 50, imgId: 1, valueType: WidgetValueType.number, unit: "kCal", shownValue:"125.2", goal: "640")
    }

    func widgetTargetLeftThin(){
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        glasses.widgetTargetLeft(size: WidgetSize.thin, x: 30, y: 30, value: 50, imgId: 1, valueType: WidgetValueType.number, unit: "kCal", shownValue:"125.2", goal: "640")
    }

    func widgetTargetLeftHalf(){
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        glasses.widgetTargetLeft(size: WidgetSize.half, x: 30, y: 30, value: 50, imgId: 1, valueType: WidgetValueType.number, unit: "kCal", shownValue:"125.2", goal: "640")
    }

    func widgetBarChartLarge(){
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        let values: [UInt8] = [200, 150, 100, 130, 30]
        glasses.widgetBarChart(size: WidgetSize.large, x: 30, y: 30, imgId: 1, valueType: WidgetValueType.number, unit: "kCal", shownValue:"125.2", chosenZone: 2, zoneNb: 5, zoneNbValue: values)
    }

    func widgetBarChartThin(){
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        let values: [UInt8] = [200, 150, 100, 130, 30]
        glasses.widgetBarChart(size: WidgetSize.thin, x: 30, y: 30, imgId: 1, valueType: WidgetValueType.number, unit: "kCal", shownValue:"125.2", chosenZone: 2, zoneNb: 5, zoneNbValue: values)
    }

    func widgetBarChartHalf(){
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        let values: [UInt8] = [200, 150, 100, 130, 30]
        glasses.widgetBarChart(size: WidgetSize.half, x: 30, y: 30, imgId: 1, valueType: WidgetValueType.number, unit: "kCal", shownValue:"125.2", chosenZone: 2, zoneNb: 5, zoneNbValue: values)
    }

    func widgetDataLarge(){
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        glasses.widgetData(size: WidgetSize.large, x: 30, y: 30, imgId: 1, valueType: WidgetValueType.number, unit: "kCal", shownValue:"125.2")
    }

    func widgetDataThin(){
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        glasses.widgetData(size: WidgetSize.thin, x: 30, y: 30, imgId: 1, valueType: WidgetValueType.number, unit: "kCal", shownValue:"125.2")
    }

    func widgetDataHalf(){
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        glasses.widgetData(size: WidgetSize.half, x: 30, y: 30, imgId: 1, valueType: WidgetValueType.number, unit: "kCal", shownValue:"125.2")
    }

}
