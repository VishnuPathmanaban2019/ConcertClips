// Converted by Storyboard to SwiftUI Converter v3.0.10 - https://swiftify.com/converter/storyboard2swiftui

import SwiftUI

struct FeedView: View {
    @State var isPresented = false
    
    var body: some View {
        VStack {
            FeedViewRepresentable() //.ignoresSafeArea()
        }.background(Image("no_clips_yet1")
            .resizable()
            .aspectRatio(contentMode: .fit)
//            .frame(width: 100, height: 100, alignment: .center)
            .cornerRadius(8))
    }
}
