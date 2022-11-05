//
//  UserViewModel.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 11/5/22.
//

import Foundation
import Combine

class UserViewModel: ObservableObject, Identifiable {

  private let userRepository = UserRepository()
  @Published var user: User
  private var cancellables: Set<AnyCancellable> = []
  var id = ""

  init(user: User) {
    self.user = user
    $user
      .compactMap { $0.id }
      .assign(to: \.id, on: self)
      .store(in: &cancellables)
  }

  func update(user: User) {
    userRepository.update(user)
  }

  func remove() {
    userRepository.remove(user)
  }
}

