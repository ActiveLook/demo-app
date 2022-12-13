//
//  ImagePickerViewController.swift
//  example
//
//  Created by Sylvain Romillon on 07/11/2022.
//

import Foundation
import UIKit
import ActiveLookSDK

class ImagePickerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - Public properties

    public var glasses: Glasses!
        
    @IBOutlet weak var previewImage: UIImageView!
    
    // MARK: - Private properties
    
    
    // MARK: - Life cycle

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        glasses.onDisconnect { [weak self] in
            guard let self = self else { return }
            print("glasses disconnected:  \(self.glasses.name)")

            let alert = UIAlertController(title: "Glasses disconnected", message: "Connection to glasses lost", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                self.navigationController?.popToRootViewController(animated: true)
            }))

            self.present(alert, animated: true)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
    }
    
    @IBAction func selectPhotoPressed(_ sender: Any) {
        let imagePickerVC = UIImagePickerController()
                imagePickerVC.sourceType = .photoLibrary
                imagePickerVC.delegate = self
                present(imagePickerVC, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)

        if let image = info[.originalImage] as? UIImage {
            if ((image.size.width * image.scale * image.size.height * image.scale)  >= 100000 ){
                let dialogMessage = UIAlertController(title: "Confirm", message: "Your image should have a resolution less then 300x300", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                    print("Ok button tapped")
                 })
                dialogMessage.addAction(ok)
                self.present(dialogMessage, animated: true, completion: nil)
            }else{
                previewImage.image = image
                
                glasses.clear()
                
                //glasses.imgStream(image: image, x: 0, y: 0, imgStreamFmt: ImgStreamFmt.MONO_1BPP)

                
                glasses.cfgWrite(name: "demotest", version: 1, password: 1337)
                glasses.cfgSet(name: "demotest")
                glasses.imgSave(id: 0, image: image, imgSaveFmt: ImgSaveFmt.MONO_4BPP)
                glasses.imgDisplay(id: 0, x: 0, y: 0)
                glasses.imgDelete(id: 0)
                
                /*
                glasses.cfgWrite(name: "demotest", version: 1, password: 1337)
                glasses.cfgSet(name: "demotest")
                glasses.imgSave(id: 0, image: image, imgSaveFmt: ImgSaveFmt.MONO_1BPP)
                glasses.imgDisplay(id: 0, x: 0, y: 0)
                glasses.imgDelete(id: 0)
                */
            }
        }
    }
    
}
