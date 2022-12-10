// Converted by Storyboard to SwiftUI Converter v3.0.10 - https://swiftify.com/converter/storyboard2swiftui

import SwiftUI

struct EventFeedView: View {
    @State var eventName: String
    @ObservedObject var clipsManagerViewModel = ClipsManagerViewModel()
    
    private var concertImageBackground: some View {
        GeometryReader { geometry in
            Image("no_clips_yet_v1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width)
        }
    }
    
    var body: some View {
        concertImageBackground.overlay(
            VStack {
                HStack {
                    Text("\(eventName)").fontWeight(.bold).foregroundColor(.white)
                    Text("|").foregroundColor(.white)
                    NavigationLink {
                      EventSectionView(eventName: eventName, clips: clipsManagerViewModel.clipViewModels.map({ $0.clip }))
                    } label: {
                        Text("Sections")
                        
                    }
                }
                EventFeedViewRepresentable(eventName: eventName).ignoresSafeArea()
            }
        ).background(.black)
    }
}
