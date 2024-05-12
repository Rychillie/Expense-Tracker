//
//  Recents.swift
//  Expense Tracker
//
//  Created by Rychillie Umpierre de Oliveira on 11/05/24.
//

import SwiftUI

struct Recents: View {
    var body: some View {
        GeometryReader {
            /// For Animation Purpose
            let size = $0.size
            
            NavigationStack {
                ScrollView(.vertical) {
                    LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
                        Section {
                            
                        } header: {
                            
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    Recents()
}
