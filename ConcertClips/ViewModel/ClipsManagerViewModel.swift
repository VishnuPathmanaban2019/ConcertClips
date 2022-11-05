//
//  ClipsManagerViewModel.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 11/5/22.
//

import Foundation
import Combine

class ClipsManagerViewModel: ObservableObject {
  @Published var clipViewModels: [ClipViewModel] = []
  private var cancellables: Set<AnyCancellable> = []

  @Published var clipRepository = ClipRepository()
  @Published var manager: [Clip] = []
  
  init() {
    clipRepository.$clips.map { clips in
      clips.map(ClipViewModel.init)
    }
    .assign(to: \.clipViewModels, on: self)
    .store(in: &cancellables)
  }

  func add(_ clip: Clip) {
    clipRepository.add(clip)
  }
}
