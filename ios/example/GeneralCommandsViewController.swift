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
import UIKit
import ActiveLookSDK

class GeneralCommandsViewController: CommandsTableViewController {

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "General commands"

        var saveSGCmdName = "Save SerializedGlasses"

        if ( UserDefaults.standard.object( forKey: "SerializedGlasses" ) != nil ) {
            saveSGCmdName = "Remove SerializedGlasses"
        }
        
        commandNames = [
            "Power on",
            "Power off",
            "Clear",
            "Set low grey level",
            "Set max grey level",
            "Test pattern 1",
            "Test pattern 2",
            "Test pattern 3",
            "Get battery level",
            "Get version",
            "Toggle led",
            "Shift screen to the left",
            "Shift screen to the right",
            "Reset screen shift",
            "Get settings",
            saveSGCmdName
        ]

        commandActions = [
            self.powerOn,
            self.powerOff,
            self.clear,
            self.setLowGreyLevel,
            self.setMaxGreylevel,
            self.displayDemoPattern1,
            self.displayDemoPattern2,
            self.displayDemoPattern3,
            self.getBatteryLevel,
            self.getVersion,
            self.toggleLed,
            self.shiftToLeft,
            self.shiftToRight,
            self.resetShift,
            self.getSettings,
            self.saveSerializedGlasses
        ]
    }
    
    // MARK: - Actions
    
    func powerOn() {
        glasses.power(on: true)
    }
    
    func powerOff() {
        glasses.power(on: false)
    }
    
    // clear() is declared in CommandsTableViewController and is used by several subclasses
    
    func setLowGreyLevel() {
        glasses.grey(level: 3)
    }
    
    func setMaxGreylevel() {
        glasses.grey(level: 15)
    }
        
    func displayDemoPattern1() {
        glasses.test(pattern: .fill)
    }
    
    func displayDemoPattern2() {
        glasses.test(pattern: .cross)
    }
    
    func displayDemoPattern3() {
        glasses.test(pattern: .image)
    }
    
    func getBatteryLevel() {
        glasses.battery { batteryLevel in
            let alert = UIAlertController(title: "Battery level", message: "\(batteryLevel) %", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }

    func getVersion() {
        glasses.vers { glassesVersion in
            let gv = glassesVersion
            let message = """
                Firmware version: \(gv.firmwareVersion)
                ManufaturingYear: \(gv.manufacturingYear)
                ManufacturingWeek: \(gv.manufacturingWeek)
                Serial Number: \(gv.serialNumber)
                """

            let alert = UIAlertController(title: "Glasses version", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func toggleLed() {
        glasses.led(state: .toggle)
    }
    
    func shiftToLeft() {
        glasses.shift(x: -50, y: 0)
    }
    
    func shiftToRight() {
        glasses.shift(x: 50, y: 0)
    }
    
    func resetShift() {
        glasses.shift(x: 0, y: 0)
    }

    func getSettings() {
        glasses.settings { glassesSettings in
            let gs = glassesSettings
            let message = """
                "X shift: \(gs.xShift)\n
                y shift: \(gs.yShift)\n
                Luma: \(gs.luma)\n
                Gesture detection enabled: \(gs.gestureDetectionEnabled)\n
                Brightness adjustment enabled: \(gs.brightnessAdjustmentEnabled)
                """

            let alert = UIAlertController(title: "Glasses settings", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }

    func saveSerializedGlasses() {

        let toggleCmdEntryName: () -> Void = {

            guard let index = self.commandNames.firstIndex(where: { $0.hasSuffix("SerializedGlasses") }) else {
                fatalError("No more `[...] SerializedGlasses` entry in commands.")
            }

            enum titleAction: String {
                case Save
                case Delete
            }

            var str = self.commandNames[index]
            var compts = str.components(separatedBy: " ")

            if ( compts[0].contains(titleAction.Save.rawValue) ) {
                compts[0] = titleAction.Delete.rawValue
            } else {
                compts[0] = titleAction.Save.rawValue
            }
            str = compts.joined(separator: " ")
            self.commandNames[index] = str

            // TODO: reload row, not whole table!
            self.tableView.reloadData()
        }

        if ( UserDefaults.standard.object(forKey: "SerializedGlasses") != nil ) {
            UserDefaults.standard.removeObject(forKey: "SerializedGlasses")
        } else {
            do {
                let sg: SerializedGlasses = try glasses.getSerializedGlasses()
                UserDefaults.standard.set(sg, forKey: "SerializedGlasses")

                let message = """
                To test auto-reconnect:
                    1. Kill the app
                    2. Relaunch the app
                -> It will reconnect automatically

                To stop auto-reconnect, `Delete SerializedGlasses`.
                """
                let alert = UIAlertController(title: "Usage",
                                              message: message,
                                              preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                    self.navigationController?.popToRootViewController(animated: true)
                }))

                self.navigationController?.present(alert, animated: true)
            } catch {
                print(error)
            }
        }
        toggleCmdEntryName()
    }
}
