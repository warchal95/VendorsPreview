//
//  OpeningHoursTextResolver.swift
//  VendorsPreview
//
//  Created by Michał Warchał on 08/04/2022.
//

import Foundation

class OpeningHoursTextResolver {
    
    private let currentDate: Date
    private let calendar = Calendar(identifier: .gregorian)
    
    init(currentDate: Date = Date()) {
        self.currentDate = currentDate
    }
    
    func resolve(openingHours: OpeningHours?) -> String {
        guard
            let openingHours = openingHours,
            let dayOfWeek = Calendar.current.dateComponents([.weekday], from: currentDate).weekday
        else {
            return NSLocalizedString("closed_today", comment: "Closed Vendor information")
        }
        let openingHoursDay = openingHoursDay(from: openingHours, in: dayOfWeek)
        guard let opensAt = openingHoursDay?.first?.opensAt, let closesAt = openingHoursDay?.first?.closesAt else {
            return NSLocalizedString("closed_today", comment: "Closed Vendor information")
        }
        let hoursAndMinutePrefix = 5
        let openedFrom = NSLocalizedString("opened_from", comment: "Opened from")
        let openedTo = NSLocalizedString("opened_to", comment: "Opened to")
        return "\(openedFrom)" + opensAt.prefix(hoursAndMinutePrefix) + " " + openedTo + closesAt.prefix(hoursAndMinutePrefix)
    }
    
    private func openingHoursDay(from openingHours: OpeningHours, in dayOfWeek: Int) -> [OpeningHours.OpeningHoursDay]? {
        switch dayOfWeek {
        case 1: return openingHours.sunday
        case 2: return openingHours.monday
        case 3: return openingHours.tuesday
        case 4: return openingHours.wednesday
        case 5: return openingHours.thursday
        case 6: return openingHours.friday
        case 7: return openingHours.saturday
        default: return nil
        }
    }
}
