//
//  Structs.swift
//  TheMaze
//
//  Created by Hugo Medina on 16/05/2019.
//  Copyright © 2019 Razeware. All rights reserved.
//

import Foundation

struct Group: Codable {
    let _id: String?
    var _rev: String?
    var users: [User]
}

struct User: Codable {
    let _id: String?
    var _rev: String?
    let hiscore: Int?
}
