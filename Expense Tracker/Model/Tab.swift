//
//  Tab.swift
//  Expense Tracker
//
//  Created by Rychillie Umpierre de Oliveira on 11/05/24.
//

import SwiftUI

enum Tab: String {
    case recents = "Recents"
    case search = "Filter"
    case charts = "Charts"
    case settings = "Settings"
    
    @ViewBuilder
    var tabContent: some View {
        switch self {
        case .recents:
            Image(systemName: "calendar")
            Text(LocalizedStringKey("Recents"))
        case .search:
            Image(systemName: "magnifyingglass")
            Text(LocalizedStringKey("ScreenFilter"))
        case .charts:
            Image(systemName: "chart.bar.xaxis")
            Text(LocalizedStringKey("Charts"))
        case .settings:
            Image(systemName: "gearshape")
            Text(LocalizedStringKey("Settings"))
        }
    }
}
