//
//  ChatView.swift
//  InstagramSUI
//
//  Created by Lavanya Sai Kumar Kantubhukta on 09/04/22.
//

import SwiftUI
import MapKit

struct ChatView: View {
    
    @State var stext = ""
    @EnvironmentObject var  CMO : ChatManager
    @State var name = "user"
    @State var pourl = "user"
    
    var body: some View {
        ZStack{
            VStack{
                
                
                HStack{
                    if  let url = URL(string:  pourl) {
                        AsyncImage (url: url) { image in
                            image
                                .resizable()
                                .frame(width: 45, height: 45 )
                                .cornerRadius(50)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 10)
                                .overlay(Circle()
                                    .stroke()
                                    .frame(width:  50,height:  50)
                                    )
                            
                        } placeholder: {
                            Image("poimg")
                                .resizable()
                                .frame(width: 45, height: 45 )
                                .cornerRadius(50)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 10)
                                .overlay(Circle()
                                    .stroke()
                                    .frame(width:  50,height:  50)
                                    )
                        }

                     }
                    
                    
                   
                    Spacer()
                    Text(name)
                        .font(.system(size: 30))
                        .padding(.trailing,30)
                }.background(Color(hue: 0.578, saturation: 0.198, brightness: 0.971, opacity: 0.516))
                    
                ScrollView(showsIndicators : false){
                    ScrollViewReader { value in
                  
                        VStack() {
                            ForEach(CMO.messages, id:  \.mid) {message in
                                chatcomponents(text: message.message, time: Date(timeIntervalSince1970: message.date).timeAgo(), ali: message.sent ? true : false, back:  message.sent ? .blue : .gray, tc: .white)
                                    .id(message.mid)
                                
                            }
                        }.onAppear{
                            if CMO.messages.count != 0{
                            value.scrollTo(CMO.messages[CMO.messages.count - 1].mid, anchor: .bottom)
                                
                            }
    
                        }
                        .onChange(of: CMO.messages.count, perform: { count in
                            if CMO.messages.count != 0{
                                          value.scrollTo(CMO.messages[CMO.messages.count - 1].mid)
                            }
                        })
                        
                         
                    }
                }
               
                
                HStack(){
                        TextField( "Enter message" ,text:$stext )
                        .frame(width: Swidth * ( (2.5) / 4) )
                        .padding(9)
                        .cornerRadius(10)
                        .border(Color.black, width: 1)
                        
                        
                    Button {
                        let msg = stext
                        CMO.sendMessage(textmessage: msg)
                        stext = ""
                        
                    } label: {
                        Text("Send")
                            .font(.system(size: 20))
                            .frame( height: 30 )
                            .padding( .horizontal,10)
        
                            .background(acl)
                        
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            
                            
                    }
                    
                }
                
                
                
                
                
                
            }.navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("chat")
            
            
           
            
        }
        
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
