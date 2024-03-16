//
//  BookStat.swift
//  BookCharts
//
//  Created by Ale Patrón on 3/15/24.
//

import Foundation

struct BookStat: Identifiable {
    let id = UUID()
    let year: Date
    let counts: [Genre: Int]
}

enum Genre: String {
    case business
    case fiction
    case nonFiction
    case biography

    var label: String {
        switch self {
        case .nonFiction:
            return "Non-Fiction"
        default:
            return self.rawValue.capitalized
        }
    }
}
