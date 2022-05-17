//
//  ContactsModel.swift
//  table
//
//  Created by SOUCHET Julie on 17/05/2022.
//

import Foundation

struct ContactsModel: Codable {
    var results: Results
}

struct Results: Codable {
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
