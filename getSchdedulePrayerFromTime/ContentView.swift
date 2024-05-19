//
//  ContentView.swift
//  getSchdedulePrayerFromTime
//
//  Created by Rangga Biner on 19/05/24.
//

import SwiftUI

struct ContentView: View {
    @State private var currentTime: String = ""
    @State private var nextPrayerTime: String = "Loading..."
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Current Time: \(currentTime)")
                .font(.largeTitle)
                .padding()
            Text(nextPrayerTime)
                .font(.title)
                .padding()
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    private func startTimer() {
        // Update the time immediately when the view appears
        updateTime()
        // Schedule the timer to update the time every second
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            updateTime()
        }
    }
    
    private func updateTime() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        currentTime = dateFormatter.string(from: Date())
        
        if let prayerTimes = loadPrayerTimes() {
            let currentDate = Date() 
            nextPrayerTime = getNextPrayerTime(currentTime: currentDate, prayerTimes: prayerTimes)
        } else {
            nextPrayerTime = "Error loading prayer times"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
