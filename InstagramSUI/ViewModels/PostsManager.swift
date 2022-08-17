//
//  PostUploadManager.swift
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


class PostsManager : ObservableObject{
   
    
    
     @Published var userposts = [PostModel]()
    @Published var allposts = [PostModel]()
    
    init(){
        self.callloaduposts()
        self.loadAllPosts { posts in
             
        }
        
        
        
    }
    
    func callloaduposts(){
        print("loadied posts1")
        guard let user = Auth.auth().currentUser else{return}
        let uid = user.uid
        self.loadUserPosts(userID: uid) { posts in
            self.userposts = posts
            print("loadied posts")
        }
        print("loadied posts2")
        
        
        //load all posts
        
        

    }
    
    
//
//    static func uploadPost(caption : String, imageData : Data, onSucess: @escaping() -> Void, onError: @escaping (_ errorMessage: String) -> Void ) {
//
//        //StorageService.savePostPhoto(user:  , caption:  , postID:  , imageData:  , onSucess:  , onError:  )
//
//
//
//    }
    

    
    
    
    
    
    
    func loadUserPosts(userID : String, onSuccess: @escaping(_  posts : [PostModel]) -> Void) {
        
        FirebaseStatic.PostsUserID(userID: userID).collection("posts").getDocuments{
            (snapshot,error) in
           guard let snap = snapshot else {
               print("error loading snapshots")
               return }
           
           var posts = [PostModel] ()
            print("1")
            for doc in snap.documents{
                let dict = doc.data()
                guard let decoder = try?  PostModel.init(fromDictionary:  dict) else {return}
                posts.append(decoder)
                
                
            }
            posts = posts.sorted(by: { $0.date > $1.date })
            print("2")
            onSuccess(posts)
            self.userposts = posts
            
        }
            
           
            
      
        
        
    }
    
    
    
    func loadAllPosts(  onSuccess: @escaping(_  posts : [PostModel]) -> Void) {
        
        FirebaseStatic.AllPosts.getDocuments{
            (snapshot,error) in
           guard let snap = snapshot else {
               print("error loading snapshots")
               return }
           
           var posts = [PostModel] ()
            print("1")
            for doc in snap.documents{
                let dict = doc.data()
                guard let decoder = try?  PostModel.init(fromDictionary:  dict) else {return}
                posts.append(decoder)
                
                
            }
            posts = posts.sorted(by: { $0.date > $1.date })
            print("2")
            self.allposts = posts
            onSuccess(posts)
            
        }
            
           
            
      
        
        
    }
    
    
    
    
    
}
