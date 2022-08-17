//
//  PostTemplate.swift
//  InstagramSUI
//
//  Created by Lavanya Sai Kumar Kantubhukta on 07/04/22.
//

import SwiftUI
import MapKit
struct PostTemplate: View {
    @State var showingSheet = false
    @State var dyn = false
    
    var uname = "Luvsai"
    var prourl = ""
    var posturl = ""
    var likesCount = 5
    var caption = "Beauty inside heart and love in mind"
    var timeP = 1.3
    var lat : CLLocationDegrees = 22.3
    var long :  CLLocationDegrees = 77.0
    
    var body: some View {
        
        VStack{
            Divider()
            HStack{
                
                if dyn {
                   if  let url = URL(string:  prourl) {
                       AsyncImage (url: url) { image in
                           image
                               .resizable()
                               .frame(width: 45, height: 45)
                               .cornerRadius(50)
                               .padding(.horizontal,10)
                               .padding(.top,5)
                           
                       } placeholder: {
                           Image("proimg" )
                               .resizable()
                               .frame(width: 45, height: 45)
                               .cornerRadius(50)
                               .padding(.horizontal,10)
                               .padding(.top,5)
                       }

                    }
                    
                }else{
                    Image("proimg" )
                        .resizable()
                        .frame(width: 45, height: 45)
                        .cornerRadius(50)
                        .padding(.horizontal,10)
                        .padding(.top,5)
                }
                Text(uname)
                    .bold()
                
                Spacer()
                
                
                
                Button {
                    showingSheet = true
                } label: {
                    Image(systemName: "map")
                        .font(.system(size: 25))
                        .padding(.trailing,20)
                }
                
                
                
                Image(systemName: "ellipsis")
                    .font(.system(size: 25))
                    .padding(.trailing,20)
                
                
                
            }
            //post image
            if dyn {
               if  let url = URL(string:  posturl) {
                   AsyncImage (url: url) { image in
                       image
                           .resizable()
                           .frame(width: .infinity)
                           .aspectRatio(contentMode: .fit)
                       
                   } placeholder: {
                       Image("poimg")
                           .resizable()
                           .frame(width: .infinity)
                           .aspectRatio(contentMode: .fit)
                   }

                }
                
            }else{

            
            Image("poimg")
                .resizable()
                .frame(width: Swidth )
                .aspectRatio(contentMode: .fit)
            }
            
            
            HStack(spacing: 10){
                Image(systemName: "heart.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.red).padding(.leading,10)
                Image(systemName: "message")
                    .font(.system(size: 29))
                    .foregroundColor(.blue)
                Spacer()
                
                
            }
            
            HStack {
                Text("\(likesCount) likes")
                    .bold()
                    .padding(.leading,10)
                Spacer()
            }
            HStack {
                Text( caption)
                    .padding(.leading,10)
                Spacer()
            }
            HStack{
                Text( "View all \(3) comments ")
                    .padding(.leading,10)
                    .foregroundColor(.gray)
                    .font(.system(size: 15))
                Spacer()
                
            }
            HStack{
                if (dyn) {
                      
                    Text(  Date(timeIntervalSince1970: timeP).timeAgo())
                    .padding(.leading,10)
                    .foregroundColor(.gray)
                    .font(.system(size: 15))
               
                    
                }else {
                    
                Text( "3 days ago")
                    .padding(.leading,10)
                    .foregroundColor(.gray)
                    .font(.system(size: 15))
                }
                Spacer()
                
            }
            
            
            
            
        }.sheet(isPresented: $showingSheet) {
            MapView(lat : self.lat,long: self.long)
            
            
        }
        
    }
    
}

struct PostTemplate_Previews: PreviewProvider {
    static var previews: some View {
        PostTemplate()
    }
}
