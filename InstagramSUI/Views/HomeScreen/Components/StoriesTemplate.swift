//
//  StoriesTemplate.swift
//  InstagramSUI
//
//  Created by Lavanya Sai Kumar Kantubhukta on 07/04/22.
//

import SwiftUI

struct StoriesTemplate: View {
    var imgname = "proimg"
    var textv = "sara"
    var body: some View {
        VStack {
            StoryImg(imgname: imgname)
            Text(textv)
                .font(.callout)
                .bold()
        }
      
        
    }
    
}

struct StoriesTemplate_Previews: PreviewProvider {
    static var previews: some View {
        StoriesTemplate()
    }
}



struct StoryImg: View {
    var imgname = "proimg"
    var wi : CGFloat = 68
    var hi : CGFloat = 68
    var body: some View {
        VStack{
            Image(imgname)
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(50)
        }.overlay(
            Circle()
                .stroke(LinearGradient(colors: [.red, .purple, .orange, .yellow, .orange], startPoint: .topLeading, endPoint: .bottomTrailing) , lineWidth: 2.3)
                .frame(width: wi, height: hi )
            )
        
    }
    
}
