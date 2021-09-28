//
//  Place.swift
//  FavoritePlaces
//
//  Created by Konstantin on 27.09.2021.
//

import UIKit

struct Place {
    
    var name: String
    var location: String?
    var type: String?
    var image: UIImage?
    var restorauntImage: String?
    
    static let restaurantNames = [
        "Burger Heroes", "Kitchen", "Bonsai", "Дастархан",
        "Индокитай", "X.O", "Балкан Гриль", "Sherlock Holmes",
        "Speak Easy", "Morris Pub", "Вкусные истории",
        "Классик", "Love&Life", "Шок", "Бочка"
    ]
    
    static func getPlaces() -> [Place] {
        
        var places: [Place] = []
        
        for place in restaurantNames {
            places.append(Place(name: place, location: "Уфа", type: "ресторан", image: nil, restorauntImage: place))
        }
        
        return places
    }
    
}
