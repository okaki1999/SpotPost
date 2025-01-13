//
//  DateFormatter+Extensions.swift
//  SpotPost
//
//  Created by fujita taiki on 2025/01/12.
//

import Foundation

extension DateFormatter {
    static var short: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
}

