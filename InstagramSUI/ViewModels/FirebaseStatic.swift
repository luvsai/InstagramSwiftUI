//
//  FirebaseStatic.swift
//  InstagramSUI
//
//  Created by Lavanya Sai Kumar Kantubhukta on 08/04/22.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import SwiftUI



class FirebaseStatic {
    
    
    // cloud storage references
    static var storage = Storage.storage()
     
    static  var storageRoot =
           storage.reference(forURL: "gs://wsctraininginsta.appspot.com")
      
     static var storageProfile = storageRoot.child("profile") // storage handle for profile picture
     
     
     static var storagePost = storageRoot.child("posts")
     
     static func storagePostID(postID : String) -> StorageReference {
         
         
         return storagePost.child(postID)
     }
     
     
     
     
     static func storageProfileID(userID : String) -> StorageReference{
         
         return storageProfile.child(userID)
         
         
     }
  
    
    
    ///--- FireStore
    static var storeRoot = Firestore.firestore()
    static func getUserIDDocRef(userID : String) ->  DocumentReference {
        
        return storeRoot.collection("users").document(userID)
        
    }
    
    
    //posts
    static var Posts = FirebaseStatic.storeRoot.collection("posts")
    
    static var AllPosts = FirebaseStatic.storeRoot.collection("allPosts")
    
    static var Timeline = FirebaseStatic.storeRoot.collection("timeline")
    
    static func PostsUserID(userID : String) -> DocumentReference {
        return Posts.document(userID)
        
        
    }
    static func timelineUserID(userID : String) -> DocumentReference {
        return Timeline.document(userID)
        
    }
    
    
    
}
