//
//  NewClipView.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 11/5/22.
//

import SwiftUI

struct NewClipView: View {
    @StateObject var clipsManagerViewModel = ClipsManagerViewModel()
    var downloadURL: String
    @Binding var tabSelection: Int
    @Binding var data: Movie?
    
    @State private var name = ""
    @State private var event = ""
    @State private var section = ""
    @State private var isActive = false
    @State private var popupTagsPresented = false
    @ObservedObject var eventsManagerViewModel = EventsManagerViewModel()
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @State private var date = Date()
    
    var body: some View {
        let events = eventsManagerViewModel.eventViewModels.sorted(by: { $0.event.name < $1.event.name }).map { $0.event }
        VStack {
            Text("New Clip")
                .font(.title)
                .fontWeight(.bold)
            Form {
                TextField("Name", text: $name)
                
                TextField("Section", text: $section)
                
                TextField("Event", text: $event)
                    .onChange(of: event, perform: { newTag in
                        if (event != "") {
                            popupTagsPresented = true
                        }
                        else {
                            popupTagsPresented = false
                        }
                    })
                
                if (popupTagsPresented) {
                    let filteredMatches = events.filter { $0.name.hasPrefix(event) }.map { $0.name }
                    Menu {
                        ForEach(filteredMatches, id: \.self) { suggestion in
                            Button{
                                event = suggestion
                                popupTagsPresented = false
                            } label: {
                                Label(suggestion, systemImage: "someIcon")
                            }
                            .buttonStyle(.borderless)
                        }
                    } label: {
                        Text("Select an Event")
                    }.id(UUID())
                }
                
                DatePicker(
                    "Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                
            }
            if self.isValidClip() && events.map({ $0.name }).contains(event) {
                let clip = Clip(name: name, event: event, section: section, downloadURL: downloadURL)
                NavigationLink {
                    UploadedView(moveToFeedView: false, clip: clip, tabSelection: $tabSelection, data: $data).environmentObject(viewModel).navigationBarBackButtonHidden(true)
                    let _ = clearFields()
                } label: {
                    Text("Add Clip")
                }
            }
        }
    }
    
    
    private func isValidClip() -> Bool {
        if name.isEmpty { return false }
        if event.isEmpty { return false }
        if section.isEmpty { return false }
        return true
    }
    
    private func clearFields() {
        name = ""
        event = ""
        section = ""
    }
    
}
