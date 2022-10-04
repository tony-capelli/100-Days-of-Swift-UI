//
//  ImageSaver.swift
//  InstaFilterApp
//
//  Created by Tony Capelli on 04/10/22.
//

import UIKit

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage){
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer){
        print("Save finisched!")
    }
}
