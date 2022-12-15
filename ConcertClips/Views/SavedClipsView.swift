import SwiftUI

struct SavedClipsView: View {
    
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
                    Text("Saved Clips").padding(.top).fontWeight(.bold).foregroundColor(.white)
                }
                SavedClipsViewRepresentable()
            }
        )
    }
}

