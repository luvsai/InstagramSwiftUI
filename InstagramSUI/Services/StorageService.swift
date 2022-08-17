//
//  StorageService.swift
//  InstagramSUI
//
//  Created by Lavanya Sai Kumar Kantubhukta on 06/04/22.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import SwiftUI
import MapKit

class StorageService {
    static var lat : Float64 = 28.7
    static var long : Float64 = 77.0
    
    // storing
    
    static func saveProfileSnapshot(userID : String, username: String, email: String, imageData: Data ,
                                 onSucess: @escaping (_ user : User) -> Void ,onError: @escaping (_ errorMessage : String) -> Void ) {
        
        
        let storageProfileImageRef =  FirebaseStatic.storageProfileID(userID: userID)
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        //add profile image first
        storageProfileImageRef.putData(imageData, metadata: metaData) {(StorageMetadata, error) in
            if error != nil {
                onError(error!.localizedDescription)
                print("Image upload failed")
               
                
                return
            }
             
            //get the download url of the image
            storageProfileImageRef.downloadURL { (url, error) in
                if let metaImageuUrl = url?.absoluteString {
                    
                    
//                    //if current user logged in create profile change request
//                    if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
//                        changeRequest.photoURL = url
//                        changeRequest.displayName = username
//                        changeRequest.commitChanges{ error in
//
//                            if error != nil {
//
//                                onError("")
//
//
//                                return
//                            }
//
//                        }
//
//                    }
                    
                    //new user login
                    let firestoreUserID = FirebaseStatic.getUserIDDocRef(userID: userID)
                    
                    let user = User.init(uid: userID, email: email, profileImageURL: metaImageuUrl, username: username, searchName: username.splitString(), bio: "")
                    
                    guard let dict = try? user.asDictionary() else {return}
                    
                    firestoreUserID.setData(dict) {
                        (error) in
                        if error != nil {
                            print("Signup 8")
                            
                            print("failed to set user data into firestore")
                            
                            StorageService.signout()
                            onError("")
                        }
                        
                    }
                    
                    onSucess(user)
                    
                }
            }
            
            
            
            
        }
        
        
    }
    
    
    
    //save post
    
    static func savePostPhoto( caption : String ,imageData : Data, username: String, userProurl : String,   onSucess: @escaping ( ) -> Void ,onError: @escaping (_ errorMessage : String) -> Void ) {
       
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        
        let postID = FirebaseStatic.PostsUserID(userID: userID ).collection("posts").document().documentID
        
        let storagePostRef = FirebaseStatic.storagePostID(postID: postID)
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        //add profile image first
        storagePostRef.putData(imageData, metadata: metaData) {(StorageMetadata, error) in
            if error != nil {
                onError(error!.localizedDescription)
                print("Post upload failed")
               
                
                return
            }
        
            print("post upload success")
            
            
            //store the post reference in firestore
            
            storagePostRef.downloadURL { url, error in
                if error != nil {
                    onError(error!.localizedDescription)
                    print("Post store ref failed")
                   
                    
                    return
                }
                if let metaImageUrl = url?.absoluteString {
                    let FSpostRef = FirebaseStatic.PostsUserID(userID: userID).collection("posts").document(postID)
                    
                    let post = PostModel.init(caption: caption, likes: [:] , latitude: CLLocationDegrees(CLLocationDegrees(StorageService.lat as CLLocationDegrees)) , longitude:  CLLocationDegrees(CLLocationDegrees(StorageService.long as CLLocationDegrees)) , ownerID: userID, postID: postID, username: username, profile: userProurl, mediaURL: metaImageUrl, date: Date().timeIntervalSince1970, likeCount: 0)
                    
                    
                    guard let dict = try? post.asDictionary() else {return}
               
                
                    FSpostRef.setData(dict) {
                        (error) in
                        
                        if error != nil {
                        onError("Failed")
                            return
                            
                        }
                        //store the data in timeline posts
                        FirebaseStatic.timelineUserID(userID: userID).collection("timeline").document(postID).setData(dict)
                        
                        //stor the post to all posts
                        FirebaseStatic.AllPosts.document(postID).setData(dict )
                        
                        
                        
                        
                    }
                    
                    onSucess()
                    
                }
                
                
                
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    static func signout() {
        
//        let firebaseAuth = Auth.auth()
//        do {
//          try firebaseAuth.signOut()
//
//        } catch let signOutError as NSError {
//          print("Error signing out: %@", signOutError)
//        }
//
        let user = Auth.auth().currentUser;
          user?.delete(completion: { _ in
                print("user deleted after failed to update the data")
            })
        
    }
    
    
    
    
    
}
