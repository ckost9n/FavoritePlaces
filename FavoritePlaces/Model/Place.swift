//
//  Place.swift
//  FavoritePlaces
//
//  Created by Konstantin on 27.09.2021.
//

import UIKit
import RealmSwift

class Place: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var location: String?
    @objc dynamic var type: String?
    @objc dynamic var imageData: Data?
    @objc dynamic var date = Date()
    
}
