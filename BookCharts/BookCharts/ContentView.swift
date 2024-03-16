//
//  ContentView.swift
//  BookCharts
//
//  Created by Ale Patrón on 2/25/24.
//

import Charts
import SwiftUI

struct ContentView: View {

    private let bookData = BookDataProvider.bookData

    var body: some View {
        VStack {
            Text("Book Tracker")
                .font(.system(size: 45))
                .bold()
            Chart(bookData) { bookStat in
                ForEach(Array(bookStat.counts.keys), id: \.self) { genre in
                    let count = bookStat.counts[genre] ?? 0
                    BarMark(
                        x: .value("Year", bookStat.year, unit: .year),
                        y: .value("Count", count),
                        width: 35
                    )
                    .foregroundStyle(by: .value("Genre", genre.label))
                }
            }.chartXAxis {
                AxisMarks(values: .automatic(desiredCount: bookData.count))
            }
            .chartXAxisLabel("Year")
            .chartYAxisLabel("Count")
            .chartLegend(position: .top)
        }.padding()
    }
}

#Preview {
    ContentView()
}
