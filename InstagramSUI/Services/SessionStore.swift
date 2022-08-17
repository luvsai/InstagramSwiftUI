//
//  SessionStore.swift
//  InstagramSUI
//
//  Created by Lavanya Sai Kumar Kantubhukta on 07/04/22.
//

import Foundation


import Combine

import Firebase
import FirebaseAuth

//listens for authentication States

class SessionStore : ObservableObject {
    
    var didChange = PassthroughSubject<SessionStore, Never> ()
    
    @Published var session : User? {
        didSet{
            self.didChange.send(self)
        }
        
    }
    
    var handle : AuthStateDidChangeListenerHandle?
    
    func listen() {
        handle = Auth.auth().addStateDidChangeListener({ auth, user in
            if let user  = user {
                
                let firestoreusesrID = FirebaseStatic.getUserIDDocRef(userID: user.uid)
                
                firestoreusesrID.getDocument { doc, err in
                    if let dict = doc?.data() {
                        
                        guard let decodedUser = try? User.init(fromDictionary:  dict) else {return}
                        self.session = decodedUser
                    }
                }
            }else {
                self.session = nil
                
            }
        })
    }
    
    func logout() {
        
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()

        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
    func unbind() {
        if let handle = handle{
            
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    
    deinit{
        unbind()
        
    }
    
}

