import SwiftUI

//struct SavedClipsView: View {
//    var body: some View {
//        SavedClipsViewRepresentable().ignoresSafeArea()
//    }
//}


struct SavedClipsView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Saved Clips").foregroundColor(.white)
            }
            SavedClipsViewRepresentable().ignoresSafeArea()
        }.background(.black)
    }
}

