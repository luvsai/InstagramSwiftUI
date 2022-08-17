//
//  EditProfile.swift
//  InstagramSUI
//
//  Created by Lavanya Sai Kumar Kantubhukta on 07/04/22.
//

import SwiftUI




struct EditProfile: View {
    @EnvironmentObject var userLSMO : UserLoginStateManager
    @EnvironmentObject var  userPM : PostsManager
    var body: some View {
        ScrollView( showsIndicators: false)  {
            VStack {
                
               
                HStack( spacing:  20) {
                         
                       
                        Text("profile")
                            .font(Font.custom("Chalkduster", size: 20))
                            .foregroundColor(Color.blue)
                            .padding(.leading,10)
                       
                   
                        Text("Logout")
                        
                        Image(systemName: "figure.walk.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.blue)
                            .padding(.trailing)
                            .onTapGesture {
                                userLSMO.signout()
                            }
                         
                        
                        
                    }
                    
                HStack( spacing:  20){
                    VStack{
                        
                        if let purl = userLSMO.UserData?.profileImageURL{
                        if  let url = URL(string: purl ) {
                            AsyncImage (url: url) { image in
                                image
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(50)
                                    .padding(.horizontal,10)
                                    .padding(.top,5)
                                    .padding(.leading,20)
                                
                            } placeholder: {
                                Image("proimg" )
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(50)
                                    .padding(.horizontal,10)
                                    .padding(.top,5)
                                    .padding(.leading,20)
                            }

                         }
                        
                    }
                        if let pname = userLSMO.UserData?.username{
                            HStack {
                                Spacer()
                                Text(pname)
                                    .font(.caption)
                                .bold()
                                Spacer()
                            }
                                
                                
                        }else {
                            Text("Username")
                                .font(.caption)
                        
                        }
                    }
                        
                    
                    VStack {
                        Text("\(self.userPM.userposts.count)")
                            .font(.headline)
                        Text("posts")
                            .font(.headline)
                        
                    }
                    VStack {
                        Text("\(10)")
                            .font(.headline)
                        Text("followers")
                            .font(.headline)
                        
                    }
                    VStack {
                        Text("\(14)")
                            .font(.headline)
                        Text("following")
                            .font(.headline)
                        
                    }
                    Spacer()
                    
                   
                    
                }
                Button {
                     
                } label: {
                    LSButton(text: "Profile Settings" )
                }

                  
               
                    
                    VStack{
                        //stories
                        ScrollView(.horizontal,showsIndicators: false){
                            
                            HStack{
                                ForEach(1..<20) {num in
                                    StoriesTemplate( textv: "Stories")
                                        .padding(.top,5)
                                        .padding(.leading,10)
                                    
                                    
                                }
                                
                            }
                            
                        }
                        
                        
                        
                        //posts
                        
                        
                        ForEach( userPM.userposts ,id: \.postID ) {post in
                            PostTemplate(  dyn: true, uname: post.username, prourl: post.profile, posturl: post.mediaURL, likesCount: post.likeCount, caption: post.caption, timeP:  post.date , lat: post.latitude, long: post.longitude)
                        }
                        
                    }
                    
                

                Spacer()
                
            }
        }.onAppear{
            
            self.userPM.loadUserPosts(userID: self.userLSMO.UserID) { posts in
                 
            }
        }
        
        
    }
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditProfile()
           
            
    }
}

//
//if let purl = userLSMO.UserData?.profileImageURL {
//    if let url = URL(string: purl) {
//
//        AsyncImage(url: url) { image in
//            image
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .cornerRadius(10)
//                .frame(width: 100, height: 100 )
//        } placeholder: {
//            Image(systemName: "logo.playstation")
//
//        }
//    }
//}
