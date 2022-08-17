//
//  UserModel.swift
//  InstagramSUI
//
//  Created by Lavanya Sai Kumar Kantubhukta on 06/04/22.
//

import Foundation

struct User : Encodable , Decodable{
    var uid: String
    var email : String
    var profileImageURL : String
    var username : String
    var searchName: [String]
    var bio : String
    
}
