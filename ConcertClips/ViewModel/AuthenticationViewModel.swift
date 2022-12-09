//
//  AuthenticationViewModel.swift
//  ConcertClips
//
//  Created by Vishnu Pathmanaban on 12/4/22.
//

import Foundation
import Firebase
import GoogleSignIn
import FirebaseAuth

class AuthenticationViewModel: ObservableObject {
    
    var usersManagerViewModel = UsersManagerViewModel()
    var eventsManagerViewModel = EventsManagerViewModel()
    
    enum SignInState {
        case signedIn
        case signedOut
        case signedInFull
    }
    
    @Published var state: SignInState = .signedOut
    
    func signIn() {
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                authenticateUser(for: user, with: error)
            }
        } else {
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            
            let configuration = GIDConfiguration(clientID: clientID)
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
            
            GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { [unowned self] user, error in
                authenticateUser(for: user, with: error)
            }
        }
    }
    
    private func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.state = .signedIn
                
                let userID = GIDSignIn.sharedInstance.currentUser?.userID ?? "default_user_id"
                let userQuery = usersManagerViewModel.userRepository.store.collection(usersManagerViewModel.userRepository.path).whereField("username", isEqualTo: userID)
                
                userQuery.getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        if querySnapshot?.count == 0 {
                            let user = User(username: userID) // add user to db
                            usersManagerViewModel.add(user)
                        }
                    }
                }
              
                let eventQuery = eventsManagerViewModel.eventRepository.store.collection(eventsManagerViewModel.eventRepository.path)
                
                eventQuery.getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        if querySnapshot?.count == 0 {
                            let SGURL: NSURL = NSURL(string: "https://api.seatgeek.com/2/events?type=music_festival&per_page=18&client_id=Mjk5NTI2NTh8MTY2NjkyMzQ0Mi4xNTcxNjg0")!
        
                            let data = NSData(contentsOf: SGURL as URL)!
        
                            let json = try! JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as! [String:AnyObject]
                            if let events = json["events"] as? [NSDictionary] {
                                for event in events {
                                    let event = Event(name: event["title"] as! String)
                                    eventsManagerViewModel.add(event)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        do {
            try Auth.auth().signOut()
            state = .signedOut
        } catch {
            print(error.localizedDescription)
        }
    }
}
