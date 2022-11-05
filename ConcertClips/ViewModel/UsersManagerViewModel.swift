//
//  UsersManagerViewModel.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 11/5/22.
//

import Foundation
import Combine

class UsersManagerViewModel: ObservableObject {
  @Published var userViewModels: [UserViewModel] = []
  private var cancellables: Set<AnyCancellable> = []

  @Published var userRepository = UserRepository()
  @Published var manager: [User] = []
  
  init() {
    userRepository.$users.map { users in
      users.map(UserViewModel.init)
    }
    .assign(to: \.userViewModels, on: self)
    .store(in: &cancellables)
  }

  func add(_ user: User) {
    userRepository.add(user)
  }
}
