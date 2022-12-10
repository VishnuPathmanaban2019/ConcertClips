// Converted by Storyboard to SwiftUI Converter v3.0.10 - https://swiftify.com/converter/storyboard2swiftui

import SwiftUI

struct FeedView: View {
    @State var isPresented = false
    
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
                FeedViewRepresentable() //.ignoresSafeArea()
            }
        )
//            .background(Image("no_clips_yet_v2")
//            .resizable()
////            .aspectRatio(contentMode: .fit)
////            .frame(width: 100, height: 100, alignment: .center)
//            .cornerRadius(8))
    }
}
