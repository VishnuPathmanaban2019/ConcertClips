//
//  ViewController.swift
//  ConcertClips
//
// Citations:
// Adapted from: https://github.com/dks333/Tiktok-Clone

import UIKit
import SwiftUI
import GoogleSignIn
import FirebaseFirestore

struct VideoModel {
    let caption: String
    let videoURL: String
    let event: String
    let section: String
    let detailsButtonTappedCount: Int
    var volumeButtonTappedCount: Int
}

class ViewController: UIViewController {
    
    @ObservedObject var clipsManagerViewModel = ClipsManagerViewModel()
    var usersManagerViewModel = UsersManagerViewModel()
    
    private var collectionView: UICollectionView?
    
    private var data = [VideoModel]()
    
    private var detailsButtonTappedCount = 0
    
    override func viewDidLoad() {
        
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"bg")!)
        
        super.viewDidLoad()
        
        let varTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false)
        {
            (varTimer) in
            let clipViewModels = self.clipsManagerViewModel.clipViewModels.sorted(by: { $0.clip < $1.clip })
            
            clipViewModels.forEach { clipViewModel in
                let model = VideoModel(caption: clipViewModel.clip.name,
                                       videoURL: clipViewModel.clip.downloadURL,
                                       event: clipViewModel.clip.event,
                                       section: clipViewModel.clip.section,
                                       detailsButtonTappedCount: 0,
                                       volumeButtonTappedCount: 0)
                self.data.append(model)
                
                
            }
            
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.itemSize = CGSize(width: self.view.frame.size.width,
                                     height: self.view.frame.size.height)
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            self.collectionView?.register(FeedViewCell.self,
                                          forCellWithReuseIdentifier: FeedViewCell.identifier)
            self.collectionView?.isPagingEnabled = true
            self.collectionView?.dataSource = self
            self.view.addSubview(self.collectionView!)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    var shouldCreateSubviews = true
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = data[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedViewCell.identifier,
                                                      for: indexPath) as! FeedViewCell
        cell.configure(with: model)
        
        
        //  idea for details:
        // IF details enabled (if detailsTappedCount == 1)
        // remove previous details subview
        // add new details subview by manually called didTapDetailsButton
        
        if model.detailsButtonTappedCount == 0 {
            for subview in view.subviews {
                if subview is UILabel {
                    subview.removeFromSuperview()
                }
                
                if subview.backgroundColor == .black {
                    subview.removeFromSuperview()
                }
            }
//            didTapDetailsButton(with: model)
        }
        
        // if details NOT enabled (if detailsTappedCount == 0)
        // do nothing
        
        
        cell.delegate = self
        cell.player?.play()
        return cell
    }
}

extension ViewController: FeedViewCellDelegate {
    
    func didTapLikeButton(with model: VideoModel) {
        let userID = GIDSignIn.sharedInstance.currentUser?.userID ?? "default_user_id"
        let userQuery = usersManagerViewModel.userRepository.store.collection(usersManagerViewModel.userRepository.path).whereField("username", isEqualTo: userID)

        let serialized = model.videoURL + "`" + model.caption + "`" + model.section + "`" + model.event

        
        
        userQuery.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let document = querySnapshot?.documents.first
//                print(document?.data()["myClips"])
                let docData = document?.data()
                let savedClips = docData!["myClips"] as! [String]
//                let likeButtonSelected = docData!["likeButtonSelected"] as! [String]

                print("savedClipsBefore: \(savedClips)")
                
                    
//                if likeButtonSelected == ["false"] {
//                    document?.reference.updateData([ // update likeButtonSelected to be false
//                        "likeButtonSelected": FieldValue.arrayRemove(["false"]),
//                    ])
//
//                    document?.reference.updateData([ // update likeButtonSelected to be false
//                        "likeButtonSelected": FieldValue.arrayUnion(["true"]),
//                    ])
//                }
//                else {
//                    document?.reference.updateData([ // update likeButtonSelected to be false
//                        "likeButtonSelected": FieldValue.arrayRemove(["true"]),
//                    ])
//
//                    document?.reference.updateData([ // update likeButtonSelected to be false
//                        "likeButtonSelected": FieldValue.arrayUnion(["false"]),
//                    ])
//                }

                
                // remove clip if we press like, and clip is already in this user's savedClips
                if savedClips.contains(serialized) {
                    document?.reference.updateData([
                        "myClips": FieldValue.arrayRemove([serialized])
                    ])
                    
                    
                    // update boolean
//                    if likeButtonSelected == ["true"]
//                    {
//                        document?.reference.updateData([
//                            "likeButtonSelected": FieldValue.arrayRemove(["true"]),
//                        ])
//
//                        document?.reference.updateData([
//                            "likeButtonSelected": FieldValue.arrayUnion(["false"]),
//                        ]) // using array for now, will change to boolean once figured out
//                    }
//                    else {
//                        document?.reference.updateData([
//                            "likeButtonSelected": FieldValue.arrayRemove(["false"]),
//                        ])
//
//                        document?.reference.updateData([
//                            "likeButtonSelected": FieldValue.arrayUnion(["true"]),
//                        ]) // using array for now, will change to boolean once figured out
//                    }
                }
                else { // add clip if we press like, and clip is NOT already in this user's savedClips
                    document?.reference.updateData([
                        "myClips": FieldValue.arrayUnion([serialized])
                    ])
                    
                    // update boolean
//                    if likeButtonSelected == ["true"]
//                    {
//                        document?.reference.updateData([
//                            "likeButtonSelected": FieldValue.arrayRemove(["true"]),
//                        ])
//
//                        document?.reference.updateData([
//                            "likeButtonSelected": FieldValue.arrayUnion(["false"]),
//                        ]) // using array for now, will change to boolean once figured out
//                    }
//                    else {
//                        document?.reference.updateData([
//                            "likeButtonSelected": FieldValue.arrayRemove(["false"]),
//                        ])
//
//                        document?.reference.updateData([
//                            "likeButtonSelected": FieldValue.arrayUnion(["true"]),
//                        ]) // using array for now, will change to boolean once figured out
//                    }
                    
                }
                
                print("savedClipsAfter: \(document?.data())")
            }
            
        }
    }
    
    func didTapVolumeButton(with model: VideoModel) {
    }
    
    func didTapDetailsButton(with model: VideoModel) {
        if self.detailsButtonTappedCount == 0 {
            self.detailsButtonTappedCount = 1
            shouldCreateSubviews = true
        }
        else {
            self.detailsButtonTappedCount = 0
            shouldCreateSubviews = false
        }
        
        let size = self.view.frame.size.width/7
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height - 100
        
        let rectangleView = UIView(frame: CGRect(x: 0, y: 650, width: self.view.frame.size.width, height: self.view.frame.size.height - 30))
        rectangleView.backgroundColor = UIColor.black
        
        
        // rram
        let captionLabelHeader = UILabel()
        captionLabelHeader.textAlignment = .left
        captionLabelHeader.textColor = .white
        captionLabelHeader.frame = CGRect(x: 0, y: 670, width: self.view.frame.width, height: 20)
//        sectionLabelHeader.font = UIFont.boldSystemFont(ofSize: 16.0)
        captionLabelHeader.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        captionLabelHeader.text = "       Caption: "
        // rram
        
        let captionLabel = UILabel()
        captionLabel.textAlignment = .left
        captionLabel.textColor = .white
        
        captionLabel.frame = CGRect(x: 0, y: 670, width: self.view.frame.width, height: 20)
        captionLabel.text = "                       " + model.caption
        
        
        // rram
        let eventLabelHeader = UILabel()
        eventLabelHeader.textAlignment = .left
        eventLabelHeader.textColor = .white
        eventLabelHeader.frame = CGRect(x: 0, y: 690, width: self.view.frame.width, height: 20)
//        sectionLabelHeader.font = UIFont.boldSystemFont(ofSize: 16.0)
        eventLabelHeader.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        eventLabelHeader.text = "       Event: "
        // rram
        
        let eventLabel = UILabel()
        eventLabel.textAlignment = .left
        eventLabel.textColor = .white
        
        eventLabel.frame = CGRect(x: 0, y: 690, width: self.view.frame.width, height: 20)
        eventLabel.text = "                       " + model.event

        // rram
        let sectionLabelHeader = UILabel()
        sectionLabelHeader.textAlignment = .left
        sectionLabelHeader.textColor = .white
        sectionLabelHeader.frame = CGRect(x: 0, y: 710, width: self.view.frame.width, height: 20)
//        sectionLabelHeader.font = UIFont.boldSystemFont(ofSize: 16.0)
        sectionLabelHeader.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        sectionLabelHeader.text = "       Section: "
        // rram
        
        let sectionLabel = UILabel()
        sectionLabel.textAlignment = .left
        sectionLabel.textColor = .white
        
        sectionLabel.frame = CGRect(x: 0, y: 710, width: self.view.frame.width, height: 20)
        sectionLabel.text = "                       " + model.section
        
        view.addSubview(rectangleView)
        view.addSubview(captionLabelHeader)
        view.addSubview(captionLabel)
        view.addSubview(eventLabelHeader)
        view.addSubview(eventLabel)
        view.addSubview(sectionLabelHeader)
        view.addSubview(sectionLabel)
        
        if shouldCreateSubviews == false {
            
            for subview in view.subviews {
                if subview is UILabel {
                    subview.removeFromSuperview()
                }
                
                if subview.backgroundColor == .black {
                    subview.removeFromSuperview()
                }
            }
        }
    }
}
