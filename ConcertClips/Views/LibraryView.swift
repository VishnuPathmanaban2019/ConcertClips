//
//  LibraryView.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 11/5/22.
//

import SwiftUI

struct LibraryView: View {
  
  // @EnvironmentObject var library: Library
  @ObservedObject var eventsManagerViewModel = EventsManagerViewModel()
  
  var body: some View {
    NavigationView {
      List{
        let eventViewModels = eventsManagerViewModel.eventViewModels.sorted(by: { $0.event < $1.event })
        ForEach(eventViewModels) { eventViewModel in
          VStack {
            Text(eventViewModel.event.name)
              .font(.title)
              .fontWeight(.black)
              .padding([.top], 40)
            Text("Date:  \(eventViewModel.event.date)")
              .font(.title3)
              .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
              .padding(5)
          }
        }
      }.navigationBarTitle("Library")
    }
  }
  
}
