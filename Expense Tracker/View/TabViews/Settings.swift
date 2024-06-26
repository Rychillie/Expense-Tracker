//
//  Settings.swift
//  Expense Tracker
//
//  Created by Rychillie Umpierre de Oliveira on 11/05/24.
//

import SwiftUI

struct Settings: View {
    /// User properties
    @AppStorage("userName") private var userName: String = ""
    /// App Lock Properties
    @AppStorage("isAppLockEnabled") private var isAppLockEnabled: Bool = false
    @AppStorage("lockWhenAppGoesBackground") private var lockWhenAppGoesBackground: Bool = false
    @FocusState private var focusUserName: Bool
    
    var body: some View {
        NavigationStack {
            List {
                Section(LocalizedStringKey("User Name")) {
                    TextField("Tim Apple", text: $userName)
                        .onSubmit {focusUserName = false}
                        .focused($focusUserName)
                }
                
//                Section("App Lock") {
//                    Toggle("Enable App Lock", isOn: $isAppLockEnabled)
//                    
//                    if isAppLockEnabled {
//                        Toggle("Lock When App Goes Background", isOn: $lockWhenAppGoesBackground)
//                    }
//                }
            }
            .onTapGesture{
                focusUserName = false
            }
            .navigationTitle(LocalizedStringKey("Settings"))
        }
    }
}

#Preview {
    ContentView()
        .environment(\.locale, .init(identifier: "pt-BR"))
}
