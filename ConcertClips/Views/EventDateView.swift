//
//  EventDateView.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 12/14/22.
//

import SwiftUI

import SwiftUI

struct EventDateView: View {
    @State var eventName: String
  
    private var concertImageBackground: some View {
        GeometryReader { geometry in
            Image("no_clips_yet_v1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width)
        }
    }
    
    var body: some View {
            VStack {
                    NavigationLink {
                        EventDateFeedView(eventName: eventName).background(.black)
                    } label: {
                        Text("Sort Clips By Date!")
                    }
            }
    }
}
