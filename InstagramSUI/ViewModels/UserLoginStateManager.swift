//
//  UserLoginStateManager.swift
//  InstagramSUI
//
//  Created by Lavanya Sai Kumar Kantubhukta on 07/04/22.
//

import Foundation

import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import SwiftUI




class UserLoginStateManager : ObservableObject {
    
    
   
    
    
    @Published private(set) var isLoggedIn : Bool = MyLocalStorage.status
    
    
    @Published private(set) var UserID : String = ""
    @Published private(set) var uname : String = ""
    private(set) var password : String = ""
    @Published private(set) var email : String = ""
    
    @Published private(set) var AccountCreated = false
    @Published private(set) var AccountCreatedmsg = "Account created status"
    @Published private(set) var AccountStatus = false
    
    @Published private(set) var AccountLogin = false
    @Published private(set) var AccountLoginmsg = "Account created status"
    @Published private(set) var UserData : User? = nil
  
    
    //onboarding
    
    @Published private(set) var onboardingState = false
    //--
    
    
    init(){
       
        if self.isLoggedIn {
            self.checkuser()
            self.loaduserdata()
           
        }
        
        
    }
    func checkuser() -> User? {
        guard let user = Auth.auth().currentUser else{return nil}
        UserID = user.uid
      
        return  nil
    }
  
    
    
    //Create Account
    func Create(username : String , email : String, password : String , imageData :Data  ) {
        
        
        print(email, password)
        
        
        //crearing user account
        
        Auth.auth().createUser(withEmail: email, password: password) {
            
            (authData, error) in
            
            if let error = error   {
                
                self.AccountCreated = true
                self.AccountStatus = false
                self.AccountCreatedmsg = "Accout Created failed"
                MyLocalStorage.status = false
                self.isLoggedIn = false
                
                return
                
                
            }
            guard let userID = authData?.user.uid else {return}
            
            
            
            StorageService.saveProfileSnapshot(userID: userID, username: username, email: email, imageData: imageData) { user in
                
                self.AccountCreated = true
                self.AccountCreatedmsg = "Accout Created successfuly"
                self.AccountStatus = true
                MyLocalStorage.status = true
                self.isLoggedIn = true
                
                if self.isLoggedIn {
                    self.checkuser()
                    self.loaduserdata()
                   
                }
                
                return
                
            } onError: { errorMessage in
                self.AccountCreated = true
                self.AccountStatus = false
                self.AccountCreatedmsg = "Accout Created failed"
                MyLocalStorage.status = false
                self.isLoggedIn = false
               
                return
                
            }

            
            
            
            
            
          
            
     
           
           
        }
    }
    
    //-------------------------------- Login -----
    
    //Login
    func Login(  email : String, password : String   ) {
        
        
        print(email, password)
        
        
        //crearing user account
        
        
        Auth.auth().signIn(withEmail: email, password: password ) {
            authData , err in
            if let err = err {
                
                self.AccountLogin = true
                self.AccountLoginmsg = "Accout loggin failed"
                self.AccountStatus =  false
                MyLocalStorage.status = false
                self.isLoggedIn = false
                return
            }
            self.AccountLogin = true
            self.AccountLoginmsg = "Accout logged successfuly"
            self.AccountStatus = true
            MyLocalStorage.status = true
            self.isLoggedIn = true
            
            
            guard let userID = authData?.user.uid else {return}
            let fireStoreUserID = FirebaseStatic.getUserIDDocRef(userID: userID)
            
            fireStoreUserID.getDocument { doc, err in
               if let dict = doc?.data() {
                    
                    guard let decodedUser = try? User.init(fromDictionary: dict) else {return}
                   self.UserData = decodedUser
                    
                }
            }
            
            if self.isLoggedIn {
                self.checkuser()
                self.loaduserdata()
               
            }
            
            return
            
            
        }
        
        
        
    }
    
    //---logout
    
    
     func signout() {
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            MyLocalStorage.status = false
            self.isLoggedIn = false

        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }

    }
    
    //load user data at the start form the firebase
    func loaduserdata() {
        
        let firestoreusesrID = FirebaseStatic.getUserIDDocRef(userID:  self.UserID)
        
        firestoreusesrID.getDocument { doc, err in
            
            
            if let dict = doc?.data() {
                
                guard let decodedUser = try? User.init(fromDictionary:  dict) else {return}
                self.UserData = decodedUser
            }
        }
        
    }
    
    
    
}


class MyLocalStorage {
    
    
    private static var Key : String = "sessionToken"

    
    public static var Token : String {
        set {
            UserDefaults.standard.set(newValue,forKey: Key)
        }
        get {
            return UserDefaults.standard.string(forKey: Key) ?? "NO data saved"
            
        }
        
    }
    
    
    public static var status : Bool {
        set {
            UserDefaults.standard.set(newValue,forKey: "status")
        }
        get {
            return UserDefaults.standard.bool(forKey: "status")   
            
        }
        
    }
    
    
}
