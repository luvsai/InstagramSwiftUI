//
//  LSComponents.swift
//  InstagramSUI
//
//  Created by Lavanya Sai Kumar Kantubhukta on 06/04/22.
//

import SwiftUI

let Swidth = UIScreen.main.bounds.width
let Sheight = UIScreen.main.bounds.height

struct LSComponents: View {
    @State var st : String = ""
    var body: some View {
        VStack{
            LSButton()
            LSTextField(btext: $st)
            LSSecureField(btext: $st)
            LSlogout()
        }
    }
    
}

struct LSComponents_Previews: PreviewProvider {
    static var previews: some View {
        LSComponents()
    }
}

struct LSButton: View {
    var text :String = "Button label"
    var bgcolor : Color = Color("AccentColor")
    var fgcolor : Color = .white
    var body: some View {
        Text(text)
        
            .frame(width: (Swidth * (3/4)) , height: 40, alignment: .center)
            .background(bgcolor)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(acl, lineWidth: 1)
                
            )
        
            .foregroundColor(fgcolor)
        
        
    }
    
}

struct LSTextField: View {
    @Binding var btext: String
    var text :String = "Enter Data"
    var bgcolor : Color = .white
    var fgcolor : Color = Color.init(uiColor: .systemGray)
    var body: some View {
        
        TextField( text , text : $btext)
            .frame(width: (Swidth * (3/4)) , height: 50, alignment: .center)
            .padding(.horizontal,15)
            .background(bgcolor)
            .cornerRadius(25)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.init(uiColor: .systemGray4), lineWidth: 1)
                
            )
        
            .foregroundColor(fgcolor)
        
        
        
    }
    
}


struct LSSecureField: View {
    @Binding var btext: String
    var text :String = "Enter Data"
    var bgcolor : Color = .white
    var fgcolor : Color = Color.init(uiColor: .systemGray)
    @State private var isSecured: Bool = true
    var body: some View {
        
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField( text , text : $btext)
                    
                } else {
                    TextField( text , text : $btext)
                    
                }
            }.padding(.trailing, 32)
            
            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(.gray)
            }
        }.frame(width: (Swidth * (3/4)) , height: 50, alignment: .center)
            .padding(.horizontal,15)
            .background(bgcolor)
            .cornerRadius(25)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.init(uiColor: .systemGray4), lineWidth: 1)
                
            )
        
            .foregroundColor(fgcolor)
        
        
        
        
        
        
    }
    
}

struct LSback: View {
    
    var body: some View {
        Image(systemName: "chevron.backward")
            .padding(.leading,25)
            .foregroundColor(acl)
            .font(.system(size: 30))
        
        
    }
    
}
struct LSlogout: View {
    
    var body: some View {
        
        VStack {
            HStack {
               
                 
                    Image(systemName: "figure.walk.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.blue)
                
            }
          
        }
    }
}
