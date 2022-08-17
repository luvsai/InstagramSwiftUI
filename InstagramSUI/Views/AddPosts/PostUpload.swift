//
//  PostUpload.swift
//  InstagramSUI
//
//  Created by Lavanya Sai Kumar Kantubhukta on 07/04/22.
//

import SwiftUI
import Photos
import CoreImage

struct PostUpload: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userLSMO : UserLoginStateManager
    
    
    //filters
    @State var currentFilter =  CIFilter()
    @State var currentImage = UIImage(systemName: "message")!
    @State var context =  CIContext()
    
    @State var capf = ""
    @State var suc = false
    @State var err = false
    //
    
    @State private var profileImage  = UIImage(systemName: "person.crop.circle.badge.plus")!
    @State private var pickedImage : UIImage?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData : Data = Data()
    @State private var sourceType : UIImagePickerController.SourceType = .photoLibrary
    
    @State private var isImagePicked = false
    
    func loadImage() {
        guard let inputImage = pickedImage else {return}
        
        profileImage = inputImage
    }
    
    
    var body: some View {
        
         
       ZStack{
           NavigationView {
                        
                        
                        
                ScrollView( showsIndicators: false )  {
                        VStack {
                                
                            if suc{
                                Text("post Uploaded succesfully")
                                    .foregroundColor(err ? .red : .green)
                                    .font(.system(size: 30))
                            }
                               
                                
                                HStack {
                                   
                                  
                                    
                                    if isImagePicked {
                                        // next navigations
                                        Spacer()
                                        Spacer()
                                        Button {
                                            alertView()
                                        } label: {
                                            Text("Add Filters")
                                        }
            //                            NavigationLink {
            //
            //                            } label: {
            //                                Text("next")
            //                            }.navigationBarHidden(true)
                                        
                                        Button {
                                            if let mediaData = profileImage.jpegData( compressionQuality: 0.5) {
                                                self.imageData = mediaData
                                                
                                           
          
                                                StorageService.savePostPhoto( caption: self.capf, imageData: imageData, username: userLSMO.UserData?.username ?? "Instagram"  , userProurl: userLSMO.UserData?.profileImageURL ?? "") {
                                                    
                                                    print("postuploadSSS")
                                                    self.suc = true
                                                } onError: { errorMessage in
                                                    print("postfaieldFFF")
                                                    self.suc = true
                                                    self.err = true
                                                    
                                                }

                                            }

                                        } label: {
                                            Text("Post")
                                                .headlinetext()
                                        }

                                    }
                                    
                                    
                                }.padding(.trailing, 10)
                                    .padding(.bottom,20)
                                Divider()
                                
                                
                                
                            VStack {
                                
                                
                                if isImagePicked == true{
                                    
                                    Image(uiImage: self.profileImage )
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: Swidth, height: Sheight/2 )
                                    
                                    
                                }
                                else{
                                    Image(systemName: "photo.on.rectangle")
                                        .font(.system(size: 100))
                                        .foregroundColor(acl)
                                    
                                }
                            
                            
                            }  .onTapGesture {
                                self.showingActionSheet = true
                            }

                            
                            
                            //add comment
                            LSTextField(btext: $capf, text: "Add Caption" )
                            
                                Spacer()
                                
                                
                                
                        }.navigationBarHidden(true)
                            .navigationBarTitleDisplayMode(.inline)
                    }
                        //---
                        
                      
                        
                        //---
                        
                    }
                
                    
                        .sheet(isPresented:   $showingImagePicker, onDismiss: loadImage) {
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
        }
       
        
    }
    
    
    
    
    
    //write function to alert the user to pick filter
    
    //alert to pick the image
    func alertView() {
        
        let ac = UIAlertController(title: "Choose Filter", message: nil, preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "CISepiaTone", style: .default,handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default,handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIPixellate", style: .default,handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIVignette", style: .default,handler: setFilter))
    
        ac.addAction(UIAlertAction(title: "Cancel", style:  .cancel))
        
        
        
        UIApplication.shared.windows.first?.rootViewController?.present(ac, animated: true)
        //   UIWindowScene.windows.first?.rootViewController?.present(alert, animated: true)
        
    }
    
    
    //set filter to the image
    
    func setFilter(action: UIAlertAction) {
        guard let actionTitle = action.title else {return }
        self.currentFilter = CIFilter(name: actionTitle)!
        
        let beginImage = CIImage(image: self.profileImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        imageProcess()
        
    }
    
    
    func imageProcess() {
      
        if let cgImg =  context.createCGImage(currentFilter.outputImage!, from: currentFilter.outputImage!.extent) {
            
            let processedImage = UIImage(cgImage: cgImg)
            self.profileImage = processedImage
            
            
        }
        
    }
    
    
    
    
}
struct PostUpload_Previews: PreviewProvider {
    static var previews: some View {
        PostUpload()
            .environmentObject(UserLoginStateManager())
    }
}
