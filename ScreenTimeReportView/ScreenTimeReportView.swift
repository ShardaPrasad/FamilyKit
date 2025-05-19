//
//  ScreenTimeReportView.swift
//  FamilyKit
//
//  Created by Sharda Prasad on 18/05/25.
//

import Foundation
import SwiftUI
import FamilyControls
import DeviceActivity


struct ScreenTimeReportView: View {
    @State private var context: DeviceActivityReport.Context = DeviceActivityReport.Context("Total Activity")
    @State private var selectedDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
    @State private var isAuthorized = false

    var filter: DeviceActivityFilter {
        let startOfDay = Calendar.current.startOfDay(for: selectedDate)
        let endOfDay = Calendar.current.startOfDay(for: Date().addingTimeInterval(60 * 60 * 24))
        let dateInterval = DateInterval(start: startOfDay, end: endOfDay)
        return DeviceActivityFilter(segment: .daily(during: dateInterval), devices: nil)
    }

    let formatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        df.timeZone = .current
        return df
    }()
    
    @State private var authorizationError: String = ""

    public var body: some View {
        VStack {
            Text("Below is the total activity for the past 7 days.")
                .padding(.bottom)

            if !authorizationError.isEmpty {
                    Text("Authorization Error: \(authorizationError)")
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            
            if isAuthorized {
                DeviceActivityReport(
                    context,
                    filter: filter
                )
            } else {
//                Text("No activity data available or permission not granted. Please ensure Screen Time is enabled and access is allowed.")
//                    .foregroundColor(.black)
//                    .multilineTextAlignment(.center)
//                    .padding()
            }
        }
        .padding()
        .navigationTitle("Screen Time Report")
        .onAppear {
            let startOfDay = Calendar.current.startOfDay(for: selectedDate)
            let endOfDay = Calendar.current.startOfDay(for: Date().addingTimeInterval(60 * 60 * 24))

            print("DeviceActivityReport View Appeared")
            print("Context: \(context)")
            print("Selected Date (start of range): \(formatter.string(from: startOfDay))")
            print("End of range: \(formatter.string(from: endOfDay))")
            print("Filter: \(filter)")

            AuthorizationCenter.shared.requestAuthorization { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success():
                        isAuthorized = true
                        authorizationError = ""

                        print("Authorization granted")
                    case .failure(let error):
                        isAuthorized = false
                        print("Authorization failed: \(error.localizedDescription)")
                        authorizationError = error.localizedDescription
                    }
                }
            }
        }
    }
}
