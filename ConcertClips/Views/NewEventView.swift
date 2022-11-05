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
  @State private var date = ""

  var body: some View {
    VStack {
      Text("New Event")
        .font(.title)
        .fontWeight(.bold)
      Form {
        TextField("Name", text: $name)
        TextField("Date", text: $date)

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
    if date.isEmpty { return false }
    return true
  }

  private func clearFields() {
    name = ""
    date = ""
  }
  
  private func addEvent() {
    let event = Event(name: name, date: date)
    eventsManagerViewModel.add(event)
  }
}
