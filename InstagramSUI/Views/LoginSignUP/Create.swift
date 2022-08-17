//
//  Create.swift
//  InstagramSUI
//
//  Created by Lavanya Sai Kumar Kantubhukta on 06/04/22.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct Create: View {
    @EnvironmentObject var userLSMO : UserLoginStateManager
    
    
    
    
    
    init() {
        
    }
    @State var uname : String = ""
    
    @State var email : String = ""
    @State var password : String = ""
    
    
    
    @State private var profileImage  = UIImage(systemName: "person.crop.circle.badge.plus")!
    @State private var pickedImage : UIImage?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData : Data = Data()
    @State private var sourceType : UIImagePickerController.SourceType = .photoLibrary
    
    @State private var isImagePicked = false
    
    
    
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alerTitle: String = "Empty Fieds"
    
    
    
    
    @Environment(\.dismiss) var dismiss
    
    func loadImage() {
        guard let inputImage = pickedImage else {return}
        
        profileImage = inputImage
    }
    
    
    var body: some View {
        if userLSMO.isLoggedIn{
            
            //user is logged in go to dashboard()
            Dashboard()
            
        }else{
            ZStack {
                
                Color.white.ignoresSafeArea()
                ScrollView( showsIndicators:  false) {
                    VStack{
                        HStack{
                            LSback() //back button
                                .onTapGesture {
                                    withAnimation {
                                        dismiss()
                                    }
                                    
                                }
                            Spacer()
                        }
                        if userLSMO.AccountCreated {
                            HStack {
                                
                                Text(userLSMO.AccountCreatedmsg)
                                
                                    .padding()
                                    .font(.system(size: 20))
                                    .foregroundColor(userLSMO.AccountStatus ? .green : .red)
                                Spacer()
                            }
                        }
                        
                        HStack {
                            Text("Create new account")
                                .headlinetext()
                                .padding()
                            Spacer()
                        }
                        
                        VStack{
                            //imagepicker
                            if isImagePicked {
                                Image(uiImage: self.profileImage )
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 160, height: 160, alignment: .center)
                                    .clipShape(Circle())
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 78)
                                            .stroke(acl, lineWidth: 2)
                                    ).onTapGesture {
                                        self.showingActionSheet = true
                                    }
                            }
                            else {
                                Image(systemName: "person.crop.circle.badge.plus")
                                    .font(.system(size: 90))
                                    .frame(width: 160, height: 160, alignment: .center)
                                    .clipShape(Circle())
                                
                                    .foregroundColor(.gray)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 78)
                                            .stroke(acl, lineWidth: 2)
                                    ).onTapGesture {
                                        self.showingActionSheet.toggle()
                                    }
                            }
                            
                            
                            
                            LSTextField(btext: $uname,text: "User Name").padding(.top,20)
                            LSTextField(btext: $email,text: "E-mail").padding(.top,20)
                            LSSecureField(btext: $password,text: "Password")
                                .padding(.top,20)
                            
                            
                            HStack{
                                Spacer()
                                
                                
                            }
                        }.padding(40)
                        
                        //---------sign up button
                        Button {
                            
                            print("---?>>")
                            signUPcheck()
                        } label: {
                            LSButton(text:  "Sign up")
                        }.alert( isPresented: $showingAlert) {
                            Alert(title: Text(alerTitle) , message: Text(error), dismissButton: .default(Text("OK")))
                        }
                        
                        
                        
                        Spacer()
                        
                        
                    }
                }
                
            }.sheet(isPresented:  $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(pickedImage: self.$profileImage, showImagePicker: self.$showingImagePicker, imageData: self.$imageData ,isImagePicked : self.$isImagePicked,soureType: self.$sourceType)
            }
            .actionSheet(isPresented: $showingActionSheet, content: {
                ActionSheet(title: Text(""),buttons: [
                    .default(Text("Choose A Photo")) {
                        self.sourceType = .photoLibrary
                        self.showingImagePicker = true
                    },
                    .default(Text("Take A Photo")) {
                        self.sourceType = .camera
                        self.showingImagePicker = true
                        
                    },
                    .cancel()
                    
                ]  )
            })
            .navigationBarHidden(true)
        }
        
    }
    
    
    
    func clear() {
        self.email = ""
        self.uname = ""
        self.password = ""
        
    }
    
    
    
    //validate for empty feilds
    
    func validate() -> String?{
        if email.trimmingCharacters(in: .whitespaces).isEmpty ||
            uname.trimmingCharacters(in: .whitespaces).isEmpty ||
            password.trimmingCharacters(in: .whitespaces).isEmpty ||
            imageData.isEmpty {
            return "please Fill the fields"
            
        }
        if password.count < 6 {
            return "password should be atleast 6 chars"
        }
        return nil
        
        
    }
    func signUPcheck() {
        if let error = validate() {
            
            self.error = error
            self.showingAlert = true
        }
        //proceed sigining up
        userLSMO.Create(username: uname, email: email, password: password, imageData: imageData)
        
        
        
        
    }
    
    
    
}

struct Create_Previews: PreviewProvider {
    static var previews: some View {
        Create()
            .environmentObject(UserLoginStateManager())
    }
}
