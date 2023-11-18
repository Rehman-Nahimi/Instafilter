//
//  Imagesaver.swift
//  Instafilter
//
//  Created by Ray Nahimi on 12/11/2023.
//

import UIKit

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage){
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo:
        UnsafeRawPointer){
        print("Save Finished")
    }
}

