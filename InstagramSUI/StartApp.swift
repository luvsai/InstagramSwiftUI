//
//  StartApp.swift
//  InstagramSUI
//
//  Created by Lavanya Sai Kumar Kantubhukta on 06/04/22.
//

import SwiftUI

struct StartApp: View {
    
    @StateObject var userLSMO = UserLoginStateManager()
//    @StateObject var session = SessionStore()
    var body: some View {
        SplashScreen()
            .environmentObject(userLSMO)
//            .environmentObject(session)
      //  OnboardingView()
    }
}

struct StartApp_Previews: PreviewProvider {
    static var previews: some View {
        StartApp()
        
    }
}
