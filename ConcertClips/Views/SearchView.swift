//
//  SearchView.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 12/5/22.
//

import SwiftUI

struct SearchView: View {
  @State private var searchText = ""
  
  @State private var isEditing = false
  
  @ObservedObject var eventsManagerViewModel = EventsManagerViewModel()
  
  var body: some View {
    let events = eventsManagerViewModel.eventViewModels.sorted(by: { $0.event.name < $1.event.name }).map { $0.event }
    VStack{
      HStack {
        TextField("Search for an event...", text: $searchText)
          .padding(7)
          .padding(.horizontal, 25)
          .background(Color(.systemGray6))
          .cornerRadius(8)
          .overlay(
            HStack {
              Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 8)
              
              if searchText.count > 0 {
                Button(action: {
                  self.searchText = ""
                }) {
                  Image(systemName: "multiply.circle.fill")
                    .foregroundColor(.gray)
                    .padding(.trailing, 8)
                }
              }
            }
          )
          .padding(.horizontal, 10)
        
        if searchText.count > 0 {
          Button(action: {
            self.searchText = ""
          }) {
            Text("Cancel")
          }
          .padding(.trailing, 10)
          .transition(.move(edge: .trailing))
          .animation(.default)
        }
      }
      Spacer()
      if searchText.count > 0 {
        List(events.filter({ searchText.isEmpty ? true : $0.name.hasPrefix(searchText) }), id: \.self) { item in
          NavigationLink {
            EventFeedView(eventName: item.name)
          } label: {
            Text(item.name)
          }
        }
      }
    }
  }
}
