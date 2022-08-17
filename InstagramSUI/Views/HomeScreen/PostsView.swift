//
//  Posts.swift
//  InstagramSUI
//
//  Created by Lavanya Sai Kumar Kantubhukta on 07/04/22.
//

import SwiftUI

struct PostsView: View {
    @EnvironmentObject var userLSMO : UserLoginStateManager
    @EnvironmentObject var  userPM : PostsManager
    
    
    @State var showPUP  = false
    
  
    var body: some View {
        
        ZStack {
            
            //topbar
            NavigationView {
                VStack {
                    HStack{
                        Image(systemName: "camera")
                            .font(.system(size: 30))
                            .foregroundColor(Color.blue)
                        Spacer()
                        Text("Instagram")
                            .font(Font.custom("Chalkduster", size: 20))
                            .foregroundColor(Color.blue)
                            .onTapGesture {
                                userPM.loadUserPosts(userID: userLSMO.UserID) { posts in
                                    userPM.userposts = posts
                                }
                            }
                        Spacer()
                        //add post button
                        
                           
                         
                        NavigationLink(destination: {
                            PostUpload()
                                .environmentObject(userLSMO)
                        }, label: {
                            
                            Image(systemName: "plus.app.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.blue)
                            
                        })
                           
                                 
                        
                        
                        
                        
                        
                    }.padding(.horizontal,15)
                    
                    
                    // Divider()
                    //   .padding(0)
                    ScrollView( showsIndicators: false){
                        
                        VStack{
                            //stories
                            ScrollView(.horizontal,showsIndicators: false){
                                
                                HStack{
                                    ForEach(1..<20) {num in
                                        StoriesTemplate()
                                            .padding(.top,5)
                                            .padding(.leading,10)
                                        
                                    }
                                    
                                }
                                
                            }
                            
                            
                            
                            //posts
                            
                            
                            ForEach( userPM.allposts ,id: \.postID ) {post in
                                PostTemplate(  dyn: true, uname: post.username, prourl: post.profile, posturl: post.mediaURL, likesCount: post.likeCount, caption: post.caption, timeP:  post.date , lat: post.latitude, long: post.longitude)
                            }
                            
                        }
                        
                    }
                    
                }.navigationBarHidden(true)
            }
        }.onAppear{
            self.userPM.loadAllPosts { posts in
                
            }
            
        }
             
        
        
    }
    
    
    
}

struct Posts_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
            
    }
}

//        ScrollView{
//            ScrollViewReader { value in
//
//                    ForEach(1..<40) {num in
//                        Image(systemName: "house.fill").padding(.trailing,50)
//                            .foregroundColor(.green)
//                    }
//
//
//
//                    .onAppear{
//                        value.scrollTo(38, anchor: .center)
//
//                    }
//            }
//        }
