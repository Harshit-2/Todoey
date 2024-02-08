//
//  Category.swift
//  Todoey
//
//  Created by Harshit ‎ on 1/7/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = "" // Forward relationship
    @objc dynamic var colour: String = ""
    let items = List<Item>()
}
