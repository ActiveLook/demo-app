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

class ViewerCommandsViewController : CommandsTableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Demo viewer"
        
        commandNames = [
            "Add image",
            "Display next image",
            "Enable gesture",
            "Read 'viewer' config",
            "erase 'viewer' config"
        ]

        commandActions = [
            self.addImage,
            self.nextImage,
            self.gestureEnable,
            self.readCfgViewer,
            self.eraseCfgViewer,
        ]
    }
    
    
    // MARK: - Actions
    func addImage() {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self
        present(imagePickerVC, animated: true)
    }
    
    func nextImage() {
        glasses.clear()
        glasses.cfgSet(name: "viewer")
        glasses.demo(pattern: .image)
    }
    
    func gestureEnable() {
        glasses.gesture(enabled: true)
        glasses.subscribeToSensorInterfaceNotifications(onSensorInterfaceTriggered: { () -> (Void) in
            self.nextImage()
        })
    }
    
    func readCfgViewer(){
        glasses.cfgRead(name: "viewer", callback: { (config: ConfigurationElementsInfo) in
            let alert = UIAlertController(title: "Configuration info", message: "Version: \(config.version)\nnb img: \(config.nbImg)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        })
    }
    
    func eraseCfgViewer(){
        glasses.cfgDelete(name: "viewer")
        let alert = UIAlertController(title: "Configuration delete", message: "cfg 'viewer' deleted", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
    
        if let image = info[.originalImage] as? UIImage {
            glasses.cfgWrite(name: "viewer", version: 1, password: 1337)
            glasses.cfgSet(name: "viewer")
            
            glasses.cfgRead(name: "viewer", callback: { (config: ConfigurationElementsInfo) in
                let alert = UIAlertController(title: "Updating configuration", message: "Please wait until image get saved", preferredStyle: .alert)
                self.present(alert, animated: true)
                
                self.glasses.imgSave(id: config.nbImg, image: image, imgSaveFmt: ImgSaveFmt.MONO_4BPP_HEATSHRINK_SAVE_COMP)
                
                self.glasses.cfgRead(name: "viewer", callback: { (config: ConfigurationElementsInfo) in
                    self.dismiss(animated: true)
                    let alert = UIAlertController(title: "Updating configuration", message: "Image saved", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                })
            })
        }
    }
}
