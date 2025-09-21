//
//  DateFilterView.swift
//  Expense Tracker
//
//  Created by Rychillie Umpierre de Oliveira on 13/05/24.
//

import SwiftUI

struct DateFilterView: View {
    @State var start: Date
    @State var end: Date
    var onSubmit: (Date, Date) -> Void
    var onClose: () -> Void
    var body: some View {
        VStack(spacing: 15) {
            DatePicker(
                LocalizedStringKey("Start Date"),
                selection: $start,
                displayedComponents: [.date]
            )
            
            DatePicker(
                LocalizedStringKey("End Date"),
                selection: $end,
                displayedComponents: [.date]
            )
            
            HStack(spacing: 15) {
                Button(LocalizedStringKey("Cancel")) {
                    onClose()
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 5))
                .tint(.red)
                
                Button(LocalizedStringKey("Filter")) {
                    onSubmit(start, end)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 5))
                .tint(appTint)
            }
            .padding(.top, 10)
        }
        .padding(15)
        .background(.bar, in: .rect(cornerRadius: 10))
        .padding(.horizontal, 30)
    }
}
