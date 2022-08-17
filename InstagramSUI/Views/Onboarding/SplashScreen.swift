//
//  SplashScreen.swift
//  InstagramSUI
//
//  Created by Lavanya Sai Kumar Kantubhukta on 06/04/22.
//
import Foundation
import SwiftUI
let acl : Color = Color("AccentColor")
struct SplashScreen: View {
    @EnvironmentObject var userLSMO : UserLoginStateManager
  //  @EnvironmentObject var session : SessionStore
    
    @State private var isActive  = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive{
            
            //check if onboarding is shown once
            
            if userLSMO.isLoggedIn {
                //go to home screen
                
                Dashboard()
                    .environmentObject(userLSMO)
                
            }else{
            
                OnboardingView()
                    .environmentObject(userLSMO)
                
            }
            
        }
        else {
            VStack {
                ZStack{
                    Color.init(uiColor: .systemBackground).opacity(1)
                       .ignoresSafeArea()
                  //  Color.white.opacity(1).ignoresSafeArea()
                    
                    VStack{
                        
                        Image(systemName: "hare.fill")
                            .font(.system(size: 80))
                            .foregroundColor(acl)//Color("AccentColor"))
                            .padding(.bottom, 40)
                        
                        Text("Instagram")
                            .font(Font.custom("Chalkduster", size: 20))
                            .foregroundColor(Color.blue)
                        
                    }.scaleEffect(size)
                        .opacity(opacity)
                        .onAppear{
                            withAnimation(.easeIn(duration: 1.2)) {
                                
                                self.size = 0.9
                                self.opacity = 1.0
                            }
                        }
                    
                    
                    VStack {
                        Spacer()
                        Text("By Luvsai")
                            .font(Font.custom("Courier-bold", size: 20))
                            .foregroundColor(Color.init(uiColor: .systemGray))
                            .bold()
                            .padding(.bottom,30)
                        
                    }
                    
                    
                    
                }
            }
            .onAppear(){
                 
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2 ) {
                    
                    withAnimation {
                        self.isActive = true
                    }
                  
                }
                
                //2Activate listner for session too
             //   self.session.listen()
                
            }
        }
        
        
        
        
    }
}

struct SplashScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        let userLSMO : UserLoginStateManager = UserLoginStateManager()
        SplashScreen()
            .environmentObject(userLSMO)
            
    }
}
