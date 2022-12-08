// Converted by Storyboard to SwiftUI Converter v3.0.10 - https://swiftify.com/converter/storyboard2swiftui

import SwiftUI

struct EventFeedView: View {
  @State var eventName: String
  
  var body: some View {
    VStack {
      Text(eventName)
      EventFeedViewRepresentable(eventName: eventName).ignoresSafeArea()
    }
  }
}
