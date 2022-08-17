//
//  chatcomponents.swift
//  InstagramSUI
//
//  Created by Lavanya Sai Kumar Kantubhukta on 09/04/22.
//

import SwiftUI

struct chatcomponents: View {
    var text = "message"
    var time = "10 : 20"
    var ali  = true
    @State var back : Color = .blue
    var tc : Color = .white
    let sx = "http"
    
    var body: some View {
        
        HStack {
            if ali {
                Spacer()
            }
            VStack {
                HStack (spacing: 20){
                    Text(text)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(tc)
                        .padding(.horizontal)
                        .font(.system(size: 18))
                        
                }
                
                 
                .frame(maxWidth:  Swidth * ( 3 / 4), alignment: ali ? .trailing : .leading)
                
                HStack(spacing : 10) {
                    Circle().frame(width: 10, height: 10 )
                        .foregroundColor(.green)
                    Text(time)
                        .padding(.horizontal,10)
                        .font(.system(size: 12))
                       
                        
                }
                .padding(.horizontal)
                .frame(width: Swidth * ( 3 / 4),  alignment: ali ? .trailing : .leading)
                
            }.padding(6)
             
            .background(back)
            .cornerRadius(30)
        .shadow(  radius:  10)
            if !ali {
                Spacer()
            }
        }.padding(5)
        .onAppear{
                if text.contains(sx) {
                    self.back = .cyan
                }
        }
    }
}

struct chatcomponents_Previews: PreviewProvider {
    static var previews: some View {
        chatcomponents()
    }
}
