//
//  StatsCardView.swift
//  StatsCardView
//
//  Created by Rychillie Umpierre de Oliveira on 20/05/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> WidgetEntry {
        WidgetEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (WidgetEntry) -> Void) {
        let entry = WidgetEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        var entries: [WidgetEntry] = []
        
        entries.append(.init(date: .now))

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct WidgetEntry: TimelineEntry {
    let date: Date
}

struct StatsCardViewEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        FilterTransactionsView(startDate: .now.startOfMonth, endDate: .now.endtOfMonth) { transactions in
            CardView(
                income: total(transactions, category: .income),
                expense: total(transactions, category: .expense)
            )
        }
    }
}

struct StatsCardView: Widget {
    let kind: String = "StatsCardView"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            StatsCardViewEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
                .modelContainer(for: Transaction.self)
        }
        .supportedFamilies([.systemMedium])
        .contentMarginsDisabled()
        .configurationDisplayName(NSLocalizedString("My Widget", comment: ""))
        .description(NSLocalizedString("This is an example widget.", comment: ""))
    }
}

#Preview(as: .systemMedium) {
    StatsCardView()
} timeline: {
    WidgetEntry(date: .now)
}
