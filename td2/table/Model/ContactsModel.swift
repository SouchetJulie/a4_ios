//
//  ContactsModel.swift
//  table
//
//  Created by SOUCHET Julie on 17/05/2022.
//

import Foundation

struct Results: Codable {
    var results: [ContactModel]
}

struct ContactModel: Codable {
    var name: Name
    var email: String
    var picture: Picture
}

struct Name: Codable {
    var title: String
    var last: String
    var first: String
}

struct Picture: Codable {
    var large: String
}
