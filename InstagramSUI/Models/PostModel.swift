//
//  PostModel.swift
//  InstagramSUI
//
//  Created by Lavanya Sai Kumar Kantubhukta on 07/04/22.
//

import Foundation

import MapKit
struct PostModel : Encodable, Decodable  { 
    var caption : String
    var likes : [String: String]
    var latitude : CLLocationDegrees
    var longitude : CLLocationDegrees
    var ownerID : String
    var postID : String
    var username : String
    var profile : String
    var mediaURL : String
    var date : Double
    var likeCount : Int
    
 
    
}
