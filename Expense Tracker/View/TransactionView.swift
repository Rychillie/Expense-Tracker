//
//  NewExpenseView.swift
//  Expense Tracker
//
//  Created by Rychillie Umpierre de Oliveira on 17/05/24.
//

import SwiftUI
import WidgetKit

struct TransactionView: View {
    /// Env Properties
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    var editTransaction: Transaction?
    /// View Properties
    @State private var title: String = ""
    @State private var remarks: String = ""
    @State private var amount: Double = .zero
    @State private var dateAdded: Date = .now
    @State private var category: Category = .expense
    /// Random Tint
    @State var tint: TintColor = tints.randomElement()!
    
    @FocusState private var focusTitle: Bool
    @FocusState private var focusRemarks: Bool
    @FocusState private var focusAmount: Bool
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 15) {
                Text("Preview")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .hSpacing(.leading)
                
                /// Preview transaction Card View
                TransactionCardView(transaction: .init(
                    title: title.isEmpty ? String(localized: "Title") : title,
                    remarks: remarks.isEmpty ? String(localized: "Remarks") : remarks,
                    amount: amount,
                    dateAdded: dateAdded,
                    category: category,
                    tintColor: tint
                ))
                
                CustomSection(
                    String(localized: "Title"),
                    "Magic Keyboard",
                    value: $title,
                    focused: $focusTitle,
                    onSubmit: {
                        focusTitle = false
                    }
                )
                
                CustomSection(
                    String(localized: "Remarks"),
                    String(localized: "Apple Product"),
                    value: $remarks,
                    focused: $focusRemarks) {
                        focusRemarks = false
                    }
                
                /// Amount & Category Check Box
                VStack(alignment: .leading, spacing: 10, content: {
                    Text(LocalizedStringKey("Amount & Category"))
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                    
                    HStack(spacing: 15) {
                        HStack(spacing: 4) {
                            Text(currencySymbol)
                                .font(.callout.bold())
                            
                            TextField("0,00", value: $amount, formatter: numberFormatter)
                                .keyboardType(.decimalPad)
                                .onSubmit {focusAmount = false}
                                .focused($focusAmount)
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 12)
                        .background(.background, in: .rect(cornerRadius: 10))
                        .frame(maxWidth: 130)
                        
                        /// Custom Check Box
                        CategoryCheckBox()
                    }
                })
                
                /// Date Picker
                VStack(alignment: .leading, spacing: 10, content: {
                    Text(LocalizedStringKey("Date"))
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                    
                    DatePicker("", selection: $dateAdded, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 12)
                        .background(.background, in: .rect(cornerRadius: 10))
                })
            }
            .padding(15)
        }
        .onTapGesture{
            focusTitle = false
            focusRemarks = false
            focusAmount = false
        }
        .navigationTitle("\(editTransaction == nil ? String(localized: "Add") : String(localized: "Edit")) \(String(localized: "Transaction"))")
        .background(.gray.opacity(0.15))
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save", action: save)
            }
        })
        .onAppear(perform: {
            if let editTransaction {
                /// Load All Existing Data from the Transaction
                title = editTransaction.title
                remarks = editTransaction.remarks
                dateAdded = editTransaction.dateAdded
                if let category = editTransaction.rawCategory {
                    self.category = category
                }
                amount = editTransaction.amount
                if let tint = editTransaction.tint {
                    self.tint = tint
                }
            }
        })
    }
    
    /// Saving Data
    func save() {
        /// Saving Item to SwiftData
        if editTransaction != nil {
            editTransaction?.title = title
            editTransaction?.remarks = remarks
            editTransaction?.amount = amount
            editTransaction?.category = category.rawValue
            editTransaction?.dateAdded = dateAdded
        } else {
            let transaction = Transaction(title: title, remarks: remarks, amount: amount, dateAdded: dateAdded, category: category, tintColor: tint)
            context.insert(transaction)
        }
        /// Dismissing View
        dismiss()
        /// Updating Widgets
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    @ViewBuilder
    func CustomSection(_ title: String, _ hint: String, value: Binding<String>, focused: FocusState<Bool>.Binding, onSubmit: @escaping () -> Void) -> some View {
        VStack(alignment: .leading, spacing: 10, content: {
            Text(title)
                .font(.caption)
                .foregroundStyle(.gray)
                .hSpacing(.leading)
            
            TextField(hint, text: value)
                .padding(.horizontal, 15)
                .padding(.vertical, 12)
                .background(.background, in: .rect(cornerRadius: 10))
                .onSubmit(onSubmit)
                .focused(focused)
        })
    }
    
    /// Custom CheckBox
    @ViewBuilder
    func CategoryCheckBox() -> some View {
        HStack(spacing: 10) {
            ForEach(Category.allCases, id: \.rawValue) { category in
                HStack(spacing: 5) {
                    ZStack {
                        Image(systemName: "circle")
                            .font(.title3)
                            .foregroundStyle(appTint)
                        
                        if self.category == category {
                            Image(systemName: "circle.fill")
                                .font(.caption)
                                .foregroundStyle(appTint)
                        }
                    }
                    
                    Text(category.rawValue == "Income" ? LocalizedStringKey("Income") : LocalizedStringKey("Expense"))
                        .font(.caption)
                }
                .contentShape(.rect)
                .onTapGesture {
                    self.category = category
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 12)
        .hSpacing(.leading)
        .background(.background, in: .rect(cornerRadius: 10))
    }
    
    /// Number Formatter
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
}

#Preview {
    NavigationStack {
        TransactionView()
            .environment(\.locale, .init(identifier: "pt-BR"))
    }
}
