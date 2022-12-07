//
//  AuthenticationViewModel.swift
//  ConcertClips
//
//  Created by Roshan Ram on 12/4/22.
//

import Foundation
import Firebase
import GoogleSignIn


class AuthenticationViewModel: ObservableObject {

  var usersManagerViewModel = UsersManagerViewModel()
    
  enum SignInState {
    case signedIn
    case signedOut
    case signedInFull
  }

  @Published var state: SignInState = .signedOut
    
    
    func signIn() {
      // 1
      if GIDSignIn.sharedInstance.hasPreviousSignIn() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
            authenticateUser(for: user, with: error)
        }
      } else {
        // 2
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // 3
        let configuration = GIDConfiguration(clientID: clientID)
        
        // 4
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
        
        // 5
        GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { [unowned self] user, error in
          authenticateUser(for: user, with: error)
        }
      }
    }
    
    private func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
      // 1
      if let error = error {
        print(error.localizedDescription)
        return
      }
      
      // 2
      guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }
      
      let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
      
      // 3
      Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
        if let error = error {
          print(error.localizedDescription)
        } else {
          self.state = .signedIn
//          addUser()

              let userID = GIDSignIn.sharedInstance.currentUser?.userID ?? "default_user_id"
            
            print(usersManagerViewModel.userRepository.path)
            let userQuery = usersManagerViewModel.userRepository.store.collection(usersManagerViewModel.userRepository.path).whereField("username", isEqualTo: userID)
  
//            print(userQuery.size)
            
            
            print("start")
            
                userQuery.getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        print(querySnapshot?.count)
                        if querySnapshot?.count == 0 {
                            let user = User(username: userID) // rram add user to db
                            usersManagerViewModel.add(user)
                        }
//                        print("made it")
//                        for document in querySnapshot!.documents {
//                            print("\(document.documentID) => \(document.data())")
//                        }
                    }
            }
            
            print("end")
            
//            userQuery.get().addSnapshotListener { querySnapshot, error in
//                if let error = error {
//                  print("Error getting events: \(error.localizedDescription)")
//                  return
//                }

//            if querySnapshot.size != 0 {
//                        let user = User(username: username) // rram add user to db
//                        usersManagerViewModel.add(user)
//                    }
//
//                  })
            
//            if (userQuery.count == (any BinaryInteger)(0) as! NSObject) {
//                let user = User(username: userID) // rram add user to db
//                usersManagerViewModel.add(user)
//            }
            
            
        }
      }
    }
    
    
//    func addUser() {
//      let user = User(username: username)
//      usersManagerViewModel.add(user)
//    }
    
    func signOut() {
      // 1
      GIDSignIn.sharedInstance.signOut()
      
      do {
        // 2
        try Auth.auth().signOut()
        
        state = .signedOut
      } catch {
        print(error.localizedDescription)
      }
    }
}
