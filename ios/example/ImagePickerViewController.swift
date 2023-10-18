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
    public var imageFormat : String = ""
    
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
            previewImage.image = image
            
            glasses.clear()
            switch imageFormat{
            case "imageSave4bpp":
                glasses.cfgWrite(name: "DemoApp", version: 1, password: 42)
                glasses.cfgSet(name: "DemoApp")
                glasses.imgSave(id: 1, image: image, imgSaveFmt: ImgSaveFmt.MONO_4BPP)
                glasses.imgDisplay(id: 1, x: 0, y: 0)
                glasses.imgDelete(id: 1)
                break
            case "imageSave4bppHeatshrink":
                glasses.cfgWrite(name: "DemoApp", version: 1, password: 42)
                glasses.cfgSet(name: "DemoApp")
                glasses.imgSave(id: 1, image: image, imgSaveFmt: ImgSaveFmt.MONO_4BPP_HEATSHRINK)
                glasses.imgDisplay(id: 1, x: 0, y: 0)
                glasses.imgDelete(id: 1)
                break
            case "imageSave1bpp":
                glasses.cfgWrite(name: "DemoApp", version: 1, password: 42)
                glasses.cfgSet(name: "DemoApp")
                glasses.imgSave(id: 0, image: image, imgSaveFmt: ImgSaveFmt.MONO_1BPP)
                glasses.imgDisplay(id: 0, x: 0, y: 0)
                glasses.imgDelete(id: 0)
                break
            case "imageStream1bpp":
                glasses.imgStream(image: image, x: 0, y: 0, imgStreamFmt: ImgStreamFmt.MONO_1BPP)
                break
            case "imageStream4bppHeatshrink":
                glasses.imgStream(image: resizeImage(image: image, targetSize: CGSize(width: 244, height: 206))!, x: 30, y: 25, imgStreamFmt: ImgStreamFmt.MONO_4BPP_HEATSHRINK)
                break
            default:
                print("unknown image format")
                break
            }
        }
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}
