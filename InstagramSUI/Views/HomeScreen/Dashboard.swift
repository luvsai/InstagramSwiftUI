//
//  Dashboard.swift
//  InstagramSUI
//
//  Created by Lavanya Sai Kumar Kantubhukta on 07/04/22.
//

import SwiftUI 
struct Dashboard: View {
    
    @StateObject var userPM = PostsManager()
    @EnvironmentObject var userLSMO : UserLoginStateManager
    var body: some View {
        ZStack {
            
            
            
            
            TabView {
                PostsView()
                    .environmentObject(userLSMO)
                    .environmentObject(userPM)

                    .tabItem {
                        Image(systemName: "house.fill")

                    }

                SearchBarView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        
                    }
                
                
                Text("Messaging")
                    .headlinetext()
                    .tabItem {
                        Image(systemName: "message")
                        
                    }
                
                Text("Requests")
                    .headlinetext()
                    .tabItem {
                        Image(systemName: "person.2")
                        
                    }
                
                EditProfile()
                    .environmentObject(userLSMO)
                    .environmentObject(userPM)
                    .tabItem {
                        Image(systemName: "person")
                        
                        
                    }
            }.background(.ultraThinMaterial)
            
            
            
            
            
            
            
            
        }
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
           
    }
}




//    .onChange(of: entries.count) { _ in
//                        value.scrollTo(entries.count - 1)
//                    }
