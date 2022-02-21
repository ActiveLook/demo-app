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
import UIKit

class ConfigurationCommandsViewController: CommandsTableViewController {

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Configuration commands"
        
        commandNames = [
            "UPLOAD test configuration",
            "Read default configuration",
            "Write test configuration",
            "Read test configuration",
            "Select test configuration",
            "Select default configuration",
            "Get configuration count",
            "Configuration list",
            "Configuration space available",
            "DELETE test configuration"
        ]
        commandActions = [
            self.uploadTestConfig,
            self.readDefaultConfig,
            self.writeTestConfig,
            self.readTestConfig,
            self.setTestConfig,
            self.setDefaultConfig,
            self.configCount,
            self.configList,
            self.configSpace,
            self.deleteTestConfig
        ]
    }

    
    // MARK: - Actions
    
    func uploadTestConfig() {
        self.uploadConfig(named: "ConfigDemo-4.0")
    }

    func readDefaultConfig() {
        glasses.cfgRead(name: "ALooK", callback: { (config: ConfigurationElementsInfo) in
            let alert = UIAlertController(title: "Configuration info",
                                          message: "Version: \(config.version)\nnb layout: \(config.nbLayout)",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        })
    }
    
    func writeTestConfig() {
        glasses.cfgWrite(name: "DemoApp", version: 1, password: 42)
    }
    
    func readTestConfig() {
        glasses.cfgRead(name: "DemoApp", callback: { (config: ConfigurationElementsInfo) in
            let alert = UIAlertController(title: "Configuration info",
                                          message: "Version: \(config.version)\nnb layout: \(config.nbLayout)",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        })
    }
    
    func setTestConfig() {
        glasses.cfgSet(name: "DemoApp")
    }
    
    func setDefaultConfig() {
        glasses.cfgSet(name: "ALooK")
    }
    
    func configCount() {
        glasses.cfgGetNb(callback: { (number: Int) in
            var plural: (toBe: String, name: String) = ("is", "")
            if number > 1 {
                plural = ("are", "s")
            }
            let alert = UIAlertController(title: "Configuration Number",
                                          message: "There \(plural.toBe) \(number) config\(plural.name) on the glasses",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        })
    }

    func configList() {
        glasses.cfgList(callback: { (configs: [ConfigurationDescription]) in
            var message = ""
            for config in configs {
                message += "name: \(config.name)\nsize: \(config.size)\nversion: \(config.version)\n"
            }
            print("Configuration List:\n\(message)")
            
            let alert = UIAlertController(
                title: "Configuration List",
                message: message,
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        })
    }

    func configSpace() {
        glasses.cfgFreeSpace(callback: { (freeSpace: FreeSpace) in
            let alert = UIAlertController(
                title: "Configuration Free Space",
                message: "total space: \(freeSpace.totalSize)\nfree space: \(freeSpace.freeSpace)",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        })
    }

    func deleteTestConfig() {
        glasses.cfgDelete(name: "DemoApp")
    }

    func uploadConfig(named filename: String) {
        if let filePath = Bundle.main.path(forResource: filename, ofType: "txt") {
            do {
                let cfg = try String(contentsOfFile: filePath)
                glasses.loadConfiguration(cfg: cfg.components(separatedBy: "\n"))
            } catch {}
        }
    }
}
