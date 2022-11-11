// Converted by Storyboard to SwiftUI Converter v3.0.10 - https://swiftify.com/converter/storyboard2swiftui

import SwiftUI

// --------------------------------------------------------------------------------
// UIViewController
// --------------------------------------------------------------------------------
struct FeedView: View {
    var body: some View {
        ZStack(content: {})
            .frame(dynamicWidth: 375, dynamicHeight: 667)
            .background(Color(.white))
            .edgesIgnoringSafeArea(.all)
    }
}

// --------------------------------------------------------------------------------
// Dynamic Size Helper
// --------------------------------------------------------------------------------
struct DynamicSize {
    static private let baseViewWidth: CGFloat = 375.0
    static private let baseViewHeight: CGFloat = 667.0

    static func getHeight(_ height: CGFloat) -> CGFloat {
        return (height / baseViewHeight) * UIScreen.main.bounds.height
    }

    static func getWidth(_ width: CGFloat) -> CGFloat {
        return (width / baseViewWidth) * UIScreen.main.bounds.width
    }

    static func getOffsetX(_ x: CGFloat) -> CGFloat {
        return (x / baseViewWidth) * UIScreen.main.bounds.width
    }

    static func getOffsetY(_ y: CGFloat) -> CGFloat {
        return (y / baseViewHeight) * UIScreen.main.bounds.height
    }
}

// --------------------------------------------------------------------------------
// Frame and Offset Helper
// --------------------------------------------------------------------------------
extension View {
    func frame(dynamicWidth: CGFloat? = nil, dynamicHeight: CGFloat? = nil, alignment: Alignment = .center) -> some View {
        frame(
            width: DynamicSize.getWidth(dynamicWidth ?? 0),
            height: DynamicSize.getHeight(dynamicHeight ?? 0),
            alignment: alignment)
    }

    func offset(dynamicX: CGFloat = 0, dynamicY: CGFloat = 0) -> some View {
        offset(x: DynamicSize.getOffsetX(dynamicX), y: DynamicSize.getOffsetY(dynamicY))
    }
}
