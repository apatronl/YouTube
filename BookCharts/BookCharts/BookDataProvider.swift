//
//  BookDataProvider.swift
//  BookCharts
//
//  Created by Ale Patrón on 3/15/24.
//

import Foundation

struct BookDataProvider {
    static let bookData: [BookStat] = [
        BookStat(
            year: Date.fromYear(2020),
            counts: [
                .business: 6,
                .fiction: 2,
                .nonFiction: 3,
            ]
        ),
        BookStat(
            year: Date.fromYear(2021),
            counts: [
                .business: 4,
                .fiction: 2,
                .nonFiction: 2,
            ]
        ),
        BookStat(
            year: Date.fromYear(2022),
            counts: [
                .business: 6,
                .nonFiction: 6,
            ]
        ),
        BookStat(
            year: Date.fromYear(2023),
            counts: [
                .business: 2,
                .fiction: 1,
                .nonFiction: 3,
                .biography: 1,
            ]
        ),
        BookStat(
            year: Date.fromYear(2024),
            counts: [.nonFiction: 2]
        ),
    ]
}

extension Date {
    static func fromYear(_ year: Int) -> Date {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = year
        let date = calendar.date(from: dateComponents)!
        return date
    }
}
