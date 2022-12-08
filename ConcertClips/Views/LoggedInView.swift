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
    var body: some View {
        Text("Logged In!").onAppear() {
            viewModel.state = .signedInFull
        }
    }
}
