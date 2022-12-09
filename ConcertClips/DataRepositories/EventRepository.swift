//
//  EventRepository.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 11/4/22.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class EventRepository: ObservableObject {
    let path: String = "events"
    let store = Firestore.firestore()
    
    @Published var events: [Event] = []
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        self.get()
    }
    
    func get() {
        store.collection(path)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting events: \(error.localizedDescription)")
                    return
                }
                
                self.events = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: Event.self)
                } ?? []
            }
    }
    
    // MARK: CRUD methods
    func add(_ event: Event) {
        do {
            let newEvent = event
            _ = try store.collection(path).addDocument(from: newEvent)
        } catch {
            fatalError("Unable to add event: \(error.localizedDescription).")
        }
    }
    
    func update(_ event: Event) {
        guard let eventId = event.id else { return }
        
        do {
            try store.collection(path).document(eventId).setData(from: event)
        } catch {
            fatalError("Unable to update event: \(error.localizedDescription).")
        }
    }
    
    func remove(_ event: Event) {
        guard let eventId = event.id else { return }
        
        store.collection(path).document(eventId).delete { error in
            if let error = error {
                print("Unable to remove event: \(error.localizedDescription)")
            }
        }
    }
    
    func getEventFor(_ name: String) -> [Event] {
        return self.events.filter{$0.name == name}
    }
    
}
