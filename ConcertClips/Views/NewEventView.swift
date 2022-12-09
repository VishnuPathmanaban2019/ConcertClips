//
//  NewEventView.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 11/5/22.
//

import SwiftUI

struct NewEventView: View {
    @ObservedObject var eventsManagerViewModel = EventsManagerViewModel()
    
    @State private var name = ""
    
    var body: some View {
        VStack {
            Text("New Event")
                .font(.title)
                .fontWeight(.bold)
            Form {
                TextField("Name", text: $name)
                
                if self.isValidEvent() {
                    Button("Add Event") {
                        addEvent()
                        clearFields()
                    }
                }
            }
        }
    }
    
    private func isValidEvent() -> Bool {
        if name.isEmpty { return false }
        return true
    }
    
    private func clearFields() {
        name = ""
    }
    
    private func addEvent() {
        let event = Event(name: name)
        eventsManagerViewModel.add(event)
    }
}
