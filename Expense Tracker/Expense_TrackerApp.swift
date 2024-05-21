//
//  Expense_TrackerApp.swift
//  Expense Tracker
//
//  Created by Rychillie Umpierre de Oliveira on 11/05/24.
//

import SwiftUI
import WidgetKit

@main
struct Expense_TrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    WidgetCenter.shared.reloadAllTimelines()
                }
        }
        .modelContainer(for: [Transaction.self])
    }
}
