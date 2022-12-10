// Converted by Storyboard to SwiftUI Converter v3.0.10 - https://swiftify.com/converter/storyboard2swiftui

import SwiftUI

struct EventFeedView: View {
    @State var eventName: String
    @ObservedObject var clipsManagerViewModel = ClipsManagerViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("\(eventName)").foregroundColor(.white)
                Text("|").foregroundColor(.white)
                NavigationLink {
                  EventSectionView(eventName: eventName, clips: clipsManagerViewModel.clipViewModels.map({ $0.clip }))
                } label: {
                    Text("Sections")
                    
                }
            }
            EventFeedViewRepresentable(eventName: eventName).ignoresSafeArea()
        }.background(.black)
    }
}
