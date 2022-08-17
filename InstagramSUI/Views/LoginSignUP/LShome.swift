//
//  LShome.swift
//  InstagramSUI
//
//  Created by Lavanya Sai Kumar Kantubhukta on 06/04/22.
//

import SwiftUI

struct LShome: View {
    @EnvironmentObject var userLSMO : UserLoginStateManager
    
    var body: some View {
        
       
      
        if userLSMO.isLoggedIn{
            
            //user is logged in go to dashboard()
            Dashboard()
        
        }else{
            ZStack{
                    Color.white.ignoresSafeArea()
                    
                    VStack{
                        Image(systemName: "camera")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .foregroundColor(acl)
                        Text("Welcome to Instagram")
                            .headlinetext()
                        
                        Text("please login in to your account or signup to create a new account")
                            .multilineTextAlignment(.center)
                            .padding(.horizontal,20)
                            .foregroundColor(.black)
                        NavigationLink{
                            Login() 
                                .environmentObject(userLSMO)
                        } label: {
                            LSButton(text: "Log In")
                        }.padding(.top,20)
                        
                        NavigationLink {
                            Create()
                                .environmentObject(userLSMO)
                        } label: {
                            LSButton(text: "Sign Up", bgcolor: .white , fgcolor: acl)
                        }.padding(.top,15)
                        
                        
                        
                        
                    }
                    
            }.navigationBarHidden(true)
        }
            
        
    }
}

struct LShome_Previews: PreviewProvider {
    static var previews: some View {
        LShome()
            .environmentObject(UserLoginStateManager())
    }
}
