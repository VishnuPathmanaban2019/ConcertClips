//
//  NewUserView.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 11/5/22.
//

import SwiftUI

struct NewUserView: View {
    @ObservedObject var usersManagerViewModel = UsersManagerViewModel()
    
    @State private var username = ""
    @State private var myClips: [String] = []
    
    var body: some View {
        VStack {
            Text("New User")
                .font(.title)
                .fontWeight(.bold)
            Form {
                TextField("User", text: $username)
                
                if self.isValidUser() {
                    Button("Add User") {
                        addUser()
                        clearFields()
                    }
                }
            }
        }
    }
    
    private func isValidUser() -> Bool {
        if username.isEmpty { return false }
        return true
    }
    
    private func clearFields() {
        username = ""
    }
    
    private func addUser() {
        let user = User(username: username, myClips: myClips)
        usersManagerViewModel.add(user)
    }
}

