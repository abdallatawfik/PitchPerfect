//
//  Date+ToString.swift
//  PitchPerfect
//
//  Created by Abdalla Tawfik on 2/9/18.
//  Copyright © 2018 AT Apps. All rights reserved.
//

import Foundation

// MARK: - Date (ToString)

extension Date {
    func toString(dateFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
