//
//  MessgeModel.swift
//  InstagramSUI
//
//  Created by Lavanya Sai Kumar Kantubhukta on 09/04/22.
//

import Foundation


struct MessageModel : Encodable, Decodable {
    var mid :  String
    var message : String
    var date : Double
    var sent : Bool
    var seen : Bool
    
}
