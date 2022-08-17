//
//  Login.swift
//  InstagramSUI
//
//  Created by Lavanya Sai Kumar Kantubhukta on 06/04/22.
//

import SwiftUI


struct Login: View {
    @EnvironmentObject var userLSMO : UserLoginStateManager
    @Environment(\.dismiss) var dismiss
    @State var email : String = ""
    @State var password : String = ""
    
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alerTitle: String = "Empty Fieds"
    
    
    var body: some View {
        ZStack {
          
            if userLSMO.isLoggedIn{
                Dashboard()
                
            }
            else {
                ZStack{
                    Color.white.ignoresSafeArea()
                    VStack{
                        
                        
                        
                        HStack{
                            LSback()
                                .onTapGesture {
                                    dismiss()
                                }
                            Spacer()
                        }
                        
                        
                        if userLSMO.isLoggedIn {
                            HStack {
                                 
                                Text(userLSMO.AccountLoginmsg)
                                    
                                    .padding()
                                    .font(.system(size: 20))
                                    .foregroundColor(userLSMO.AccountStatus ? .green : .red)
                                Spacer()
                            }
                        }
                        
                        HStack {
                            Text("Sigin In")
                                .headlinetext()
                                .padding()
                            Spacer()
                        }
                        
                        VStack(  ){
                            LSTextField(btext: $email,text: "E-mail").padding(.top,20)
                            LSSecureField(btext: $password,text: "Password").padding(.top,20)
                            
                            HStack{
                                Spacer()
                                Text("Forgot password?")
                                    .bold()
                                    .foregroundColor(acl)
                                    .padding(.horizontal, 25)
                                    .padding(.top,30)
                                
                            }
                        }.padding(40)
                        
                        Button {
                            logincheck()
                        } label: {
                            LSButton(text:  "Log In")
                        }.alert( isPresented: $showingAlert) {
                            Alert(title: Text(alerTitle) , message: Text(error), dismissButton: .default(Text("OK")))
                        }

                        
                      
                        Spacer()
                        
                      
                    }
                    
                }.navigationBarHidden(true)
            }
        }
    }
    func validate() -> String?{
        if email.trimmingCharacters(in: .whitespaces).isEmpty ||
          
            password.trimmingCharacters(in: .whitespaces).isEmpty {
             
            return "please Fill the fields"
            
        }
        if password.count < 6 {
            return "password should be atleast 6 chars"
        }
       
        return nil
        
        
    }
    
    func logincheck() {
        if let error = validate() {
            
            self.error = error
            self.showingAlert = true
        }
        //proceed sigining up
        userLSMO.Login(  email: email, password: password )
        
        
        
        
    }
    
    
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login( )
            .environmentObject(UserLoginStateManager())
    }
}
