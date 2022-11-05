//
//  EventViewModel.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 11/4/22.
//

import Foundation
import Combine

class EventViewModel: ObservableObject, Identifiable {

  private let eventRepository = EventRepository()
  @Published var event: Event
  private var cancellables: Set<AnyCancellable> = []
  var id = ""

  init(event: Event) {
    self.event = event
    $event
      .compactMap { $0.id }
      .assign(to: \.id, on: self)
      .store(in: &cancellables)
  }

  func update(event: Event) {
    eventRepository.update(event)
  }

  func remove() {
    eventRepository.remove(event)
  }
}
