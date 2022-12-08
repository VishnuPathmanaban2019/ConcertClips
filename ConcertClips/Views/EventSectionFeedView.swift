//
//  EventSectionFeedView.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 12/7/22.
//

import SwiftUI

struct EventSectionFeedView: View {
  @State var eventName: String
  @State var section: String
  
  var body: some View {
    VStack {
      Text("\(eventName): Section \(section)")
      EventSectionFeedViewRepresentable(eventName: eventName, section: section).ignoresSafeArea()
    }
  }
}
