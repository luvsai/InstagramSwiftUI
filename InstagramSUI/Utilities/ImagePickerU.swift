//
//  ImagePickerU.swift
//  InstagramSUI
//
//  Created by Lavanya Sai Kumar Kantubhukta on 06/04/22.
//

import Foundation
import SwiftUI
import UIKit
import Photos
import CoreImage
import MobileCoreServices
import AVFoundation


struct ImagePicker : UIViewControllerRepresentable {
    @Binding var pickedImage : UIImage
    @Binding var showImagePicker : Bool
    @Binding var imageData : Data
    
    @Binding  var isImagePicked : Bool
    
    @Binding var soureType :  UIImagePickerController.SourceType
    
    
    
    func makeUIViewController(context: Context) -> some UIImagePickerController {
        
        
        
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        picker.sourceType = self.soureType
        picker.mediaTypes = [kUTTypeImage as String, kUTTypeMovie  as String]
        return picker
    }
    
    // called after the makeUIViewController
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
//    func makeCoordinator() -> ImagePicker.Coordinator {
//        Coordinator(self)
//    }
//
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    class Coordinator : NSObject , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
        var parent : ImagePicker
        init(_ parent: ImagePicker) {
            self.parent = parent
            AVCaptureDevice.requestAccess(for: .video){ response in
                if response{
                    
                    
                    
                    
                }
            }
            
            
        }
        
        
        
        //func to handle user picking a photo //func auto completes
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            //video
            if let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL{
                print("-----------99999909990-09")
                print(videoURL)
                print("-----------99999909990-09")
                
                if  let vurl = URL(string: videoURL.absoluteString ?? "") {
                    
                    
                    FirebaseStatic.storageRoot.child("videonew.mov") .putFile(from: vurl , metadata: nil) { (metadata, error) in
                        if error != nil {
                          
                            print (error?.localizedDescription)
                            return
                        }
                        
                        FirebaseStatic.storageRoot.child("videonew.mov").downloadURL { (url, error) in
                            if let metaVideoUrl = url?.absoluteString {
                                print(metaVideoUrl)
                                
                            }
                        }
                        
                        
                    }
                }
                
            }
            
            
            if  let uiImage = info[.editedImage] as?  UIImage {
                parent.pickedImage = uiImage //setting the image
                parent.isImagePicked = true
                
                
                if let mediaData = uiImage.jpegData( compressionQuality: 0.5) {
                    parent.imageData = mediaData
                    
                }
                
                parent.showImagePicker = false
                
                
            }
            else {
                //return error to alert that other than image is picked
                
            }
            
        }
        
        
        
    }
    
    
}
