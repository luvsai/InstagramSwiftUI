//
//  ChatManager.swift
//  InstagramSUI
//
//  Created by Lavanya Sai Kumar Kantubhukta on 09/04/22.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift


class ChatManager : ObservableObject {
    
    @Published var messages = [MessageModel]()
    @Published var Receiver = ""
    @Published var Sender = ""
    
    init(){
         
        checkuser()
        
    }
    func checkuser() -> User? {
        guard let user = Auth.auth().currentUser else{return nil}
        Sender = user.uid
      
        return  nil
    }
    
    
    func sendMessage(textmessage : String) {
        
        
        let  smessage = MessageModel.init(mid : "" , message:  textmessage , date: Date().timeIntervalSince1970, sent: true, seen: false)
        
        let rmessage =  MessageModel.init(mid: "",message:  textmessage , date: Date().timeIntervalSince1970, sent: false, seen: false)
        
        
        ChatService.sendMessage(senderUID: Sender, receiverUID: Receiver, textmessage: textmessage) {
             //onSuccess
            print("messageSentSuccessFully")
        } onError: {
             
        }

        
        
        
    }
    
    
    func loadMessages() {
        
        let listener = FirebaseStatic.storeRoot.collection("chats").document(Sender).collection(Receiver).whereField("date", isGreaterThan: 1)
            .addSnapshotListener { qsnapshot, error in
                
                guard let documents = qsnapshot?.documents else {
                    print("Error fetching the docs")
                    return
                    
                }
                var messages = [MessageModel] ()
//                for document in documents{
//                    let dict = document.data()
//
//                    guard let decoded = try? MessageModel.init(fromDictionary:  dict) else {return}
//
//
//                     messages.append(decoded)
//
//
//                }
                
                 messages = documents.compactMap { document -> MessageModel? in
                    do{
                        return try document.data(as: MessageModel.self )
                        
                    }
                    catch {
                        return nil
                        
                    }
                }
                
                messages = messages.sorted(by: { $0.date < $1.date })
                //self.messages.append(contentsOf: messages)
                
                self.messages = messages
                
            }
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
}
