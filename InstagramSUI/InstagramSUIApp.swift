//
//  InstagramSUIApp.swift
//  InstagramSUI
//
//  Created by Lavanya Sai Kumar Kantubhukta on 05/04/22.
//

import SwiftUI
import UIKit
import Foundation

import Firebase

import GoogleSignIn 

@main
struct InstagramSUIApp: App {
    let persistenceController = PersistenceController.shared
    
    
    
    @UIApplicationDelegateAdaptor (AppDelegate.self) var appDelegate
    
    init() {
        FirebaseApp.configure()
         print("firebase")
        
    }
    

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
            
           StartApp()
          //  ChatView()
        }
    }
}

 
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        
        
        
       // print("Firebase")
        return true
    }
    
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
      -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
    
    
}
