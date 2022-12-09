//
//  LoggedInView.swift
//  ConcertClips
//
//  Created by Vishnu Pathmanaban on 12/7/22.
//

import Foundation
import SwiftUI

struct LoggedInView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @ObservedObject var eventsManagerViewModel = EventsManagerViewModel()
  
    var body: some View {
        Text("Logged In!").onAppear() {
            viewModel.state = .signedInFull
        }
      
        if (eventsManagerViewModel.eventViewModels.count == 0) {
            let SGURL: NSURL = NSURL(string: "https://api.seatgeek.com/2/events?type=music_festival&average_price.gt=300&per_page=10&client_id=Mjk5NTI2NTh8MTY2NjkyMzQ0Mi4xNTcxNjg0")!

            let data = NSData(contentsOf: SGURL as URL)!
            
            let json = try! JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as! [String:AnyObject]
            if let events = json["events"] as? [NSDictionary] {
                ForEach(events, id: \.self) { event in
                    let event = Event(name: event["title"] as! String)
                    let _ = eventsManagerViewModel.add(event)
                }
            }
        }
    }
}
