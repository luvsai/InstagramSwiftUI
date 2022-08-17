//
//  SearchBarView.swift
//  InstagramSUI
//
//  Created by Lavanya Sai Kumar Kantubhukta on 08/04/22.
//

import SwiftUI

struct SearchBarView: View {
    @StateObject var CMO = ChatManager()
    
    @State var stext = ""
    @State var users = [User] ()
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView (showsIndicators: false) {
                    VStack {
                        HStack (spacing : 10){
                            
                            LSTextField(btext: $stext, text: "Enter user Name" )
                           
                            Button {
                                
                                   SearchService.searchUsers(input: stext) { users in
                                       self.users = users
                                   }
                              
                            } label: {
                                Image(systemName: "magnifyingglass")
                                    .font(.system(size:30))
                                    .foregroundColor(.blue)
                            }

                           
                                 
                            
                            
                        }.padding(.bottom,30)
                         ForEach(users , id: \.uid) { user in
                          
                             NavigationLink(destination: {
                                 
                                 ChatView( name: user.username,pourl: user.profileImageURL  )
                                     .environmentObject(CMO)
                                 
                             }, label: {
                                  
                             
                                 VStack {
                                    HStack{
                                        
                                        if let purl = user.profileImageURL{
                                        if  let url = URL(string: purl ) {
                                            AsyncImage (url: url) { image in
                                                image
                                                    .resizable()
                                                    .frame(width: 45, height: 45)
                                                    .cornerRadius(50)
                                                    .padding(.horizontal,2)
                                                    .padding(.top,5)
                                                    .padding(.leading,20)
                                                
                                            } placeholder: {
                                                Image("proimg" )
                                                    .resizable()
                                                    .frame(width: 45, height: 45)
                                                    .cornerRadius(50)
                                                    .padding(.horizontal,2)
                                                    .padding(.top,5)
                                                    .padding(.leading,20)
                                            }

                                         }
                                        }
                                        else {
                                        
                                        Image(systemName: "person")
                                            .font(.system(size: 30))
                                        }
                                        
                                        
                                        Spacer()
                                        Text("\(user.username)")
                                            .font(.system(size: 20))
                                            .foregroundColor(.black)
                                        Spacer()
                                        Button {
                                             
                                        } label: {
                                             Text("Folow")
                                                .frame( height: 10 )
                                                .padding()
                                                .background(Color.blue)
                                                .foregroundColor(.white)
                                                .cornerRadius(30)
                                                
                                                
                                        }.padding(.leading)
                                        
                                        
                                        
                                        
                                    } .frame(width: (Swidth * (4/5)) , height: 50, alignment: .center)
                                        .padding(.horizontal,15)
                                        .padding(.vertical,5)
                                        .background(.white)
                                        .cornerRadius(25)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 25)
                                                .stroke(.gray, lineWidth: 1)
                                            
                                        )
                                    
                                    .foregroundColor(.gray)
                                  
                                 }
                             }).simultaneousGesture(TapGesture().onEnded{
                                 //write code to pass data
                                 self.CMO.Receiver = user.uid
                                 self.CMO.loadMessages()
                                 
                             })
                            
                            
                        }
                        
                          
                        Spacer()
                    }.navigationBarHidden(true)
                    
                }
            }
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}
