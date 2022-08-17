//
//  ChatService.swift
//  InstagramSUI
//
//  Created by Lavanya Sai Kumar Kantubhukta on 09/04/22.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore

class ChatService {
    
    
    static func sendMessage (senderUID : String , receiverUID : String, textmessage : String , onSucess : @escaping() -> Void , onError : @escaping() -> Void) {
        
        
        //for sender to read
        let senderchatDocID = FirebaseStatic.storeRoot.collection("chats").document(senderUID).collection(receiverUID).document().documentID
         
        
        let receiverchatDocID = FirebaseStatic.storeRoot.collection("chats").document(receiverUID).collection(senderUID).document().documentID
    
        
        let  smessage = MessageModel.init(mid : senderchatDocID , message:  textmessage , date: Date().timeIntervalSince1970, sent: true, seen: false)
        
        let rmessage =  MessageModel.init(mid: receiverchatDocID,message:  textmessage , date: Date().timeIntervalSince1970, sent: false, seen: false)
        
        
        
        let scRef = FirebaseStatic.storeRoot.collection("chats").document(senderUID).collection(receiverUID).document(senderchatDocID)
        let rcRef = FirebaseStatic.storeRoot.collection("chats").document(receiverUID).collection(senderUID).document(receiverchatDocID)
        
//         
//        guard let sdict = try? smessage.asDictionary() else { return}
//        guard let rdict = try? rmessage.asDictionary() else { return} 
        
        
        do {
        try scRef.setData(from: smessage) {
            error in
             
            if error != nil{
                
                onError()
                
                
            }
            
            
        }
        
         try  rcRef.setData(from : rmessage) {
            error in
             
            if error != nil{
                
                onError()
                
                
            }
            
            
        }
            
            
        } catch{
            onError()
        }
        onSucess()
        
         
    }
    
    
    
    
    
    
    
    
}
