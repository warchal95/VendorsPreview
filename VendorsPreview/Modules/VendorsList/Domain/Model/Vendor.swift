//
//  Vendor.swift
//  VendorsPreview
//
//  Created by Michał Warchał on 07/04/2022.
//

import Foundation

struct Vendor: Decodable {
    
    struct HeroImage: Decodable {
        let url: String
    }

    let id: Int
    let name: String
    let heroImage: HeroImage
    let description: String
    let openingHours: OpeningHours?
    
    enum CodingKeys: String, CodingKey {
        case id, description
        case name = "display_name"
        case heroImage = "hero_image"
        case openingHours = "opening_hours"
    }
}

struct OpeningHours: Decodable {
    struct OpeningHoursDay: Decodable {
        let opensAt: String?
        let closesAt: String?
        
        enum CodingKeys: String, CodingKey {
            case opensAt = "opens_at"
            case closesAt = "closes_at"
        }
    }

    let monday, tuesday, wednesday, thursday, friday, saturday, sunday: [OpeningHoursDay]
}

