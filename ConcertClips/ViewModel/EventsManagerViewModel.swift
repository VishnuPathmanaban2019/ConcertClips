//
//  EventManagerViewModel.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 11/5/22.
//

import Foundation
import Combine

class EventsManagerViewModel: ObservableObject {
    @Published var eventViewModels: [EventViewModel] = []
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var eventRepository = EventRepository()
    @Published var manager: [Event] = []
    
    init() {
        eventRepository.$events.map { events in
            events.map(EventViewModel.init)
        }
        .assign(to: \.eventViewModels, on: self)
        .store(in: &cancellables)
    }
    
    func add(_ event: Event) {
        eventRepository.add(event)
    }
}
