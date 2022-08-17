//
//  File.swift
//  InstagramSUI
//
//  Created by Lavanya Sai Kumar Kantubhukta on 08/04/22.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage


class SearchService {
    
    
    
    static func searchUsers (input : String, onSucess : @escaping (_ user: [User]) -> Void) {

        FirebaseStatic.storeRoot.collection("users")
            .whereField("searchName", arrayContains: input.lowercased() ).getDocuments { querysnapshot, error in

                guard let snap = querysnapshot else {
                    print("errr")
                    return

                }

                var users = [User] ()
                for document in snap.documents{
                    let dict = document.data()

                    guard let decoded = try? User.init(fromDictionary:  dict) else {return}
                    if decoded.uid != Auth.auth().currentUser!.uid {

                        users.append(decoded)
                    }

                }
                print(users)
                onSucess(users)

            }
        
        
        
        
        
        
    }
}
