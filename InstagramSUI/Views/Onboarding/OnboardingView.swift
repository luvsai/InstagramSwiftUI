//
//  OnboardingView.swift
//  InstagramSUI
//
//  Created by Lavanya Sai Kumar Kantubhukta on 06/04/22.
//

import SwiftUI

struct OnboardingView: View {
    @State private var tabSelected = 1
    
    @EnvironmentObject var userLSMO : UserLoginStateManager
    
    var body: some View {
        
        NavigationView {
            ZStack(alignment: .center ){
                Color("AccentColor").ignoresSafeArea()
                
                TabView(selection: $tabSelected ){
                    OnboardingViewTemplate(SystemImage: "camera", title: "Stories" , description: "Share posts , photos , comments with your network").tag(1)
                    OnboardingViewTemplate(SystemImage: "message", title: "Messages" , description: "Communicate with your friends with private messages").tag(2)
                    OnboardingViewTemplate(SystemImage: "location", title: "Checkins" , description: "checkin with your friends when posting photos").tag(3)
                    OnboardingViewTemplate(SystemImage: "bell", title: "Notifications" , description: "Get notified whenn getting new messages").tag(4)
                }.tabViewStyle(.page(indexDisplayMode: .always))
                    
                  //  .indexViewStyle(.page(backgroundDisplayMode: .always)) //optional
                
                VStack{
                    Spacer()
                    HStack{
                        NavigationLink {
                            LShome()
                                .environmentObject(userLSMO)
                        } label: {
                            Text("Skip")
                        }

                      
                        Spacer()

                       

                        if tabSelected != 4 {
                                Button {
                                    if tabSelected != 4{
                                     tabSelected += 1
                                    }
                                } label: {
                                    Text("Next")
                                    
                                
                            }
                            .padding(.horizontal,20)
                        }
                    }
                    
                }.foregroundColor(.white)
                
                
              
                
              
            }.navigationBarHidden(true)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .preferredColorScheme(.light)
            .environmentObject(UserLoginStateManager())
            
    }
}




struct OnboardingViewTemplate: View  {
    
    let SystemImage : String
    let title : String
    let description : String
    var body: some View {
       
        VStack (alignment: .center, spacing: 30 ) {
            Image(systemName: SystemImage)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
               
            
            Text(title)
                .font(.title).bold()
               
            
            Text(description)
                .multilineTextAlignment(.center)
              
            
            
            
        }.padding(.horizontal, 40)
            .foregroundColor(.white)
    }
}
