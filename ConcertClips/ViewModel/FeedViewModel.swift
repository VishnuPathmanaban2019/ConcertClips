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
    let date: Date
    let detailsButtonTappedCount: Int
    var volumeButtonTappedCount: Int
    var likeButtonTappedCount: Int
}

class ViewController: UIViewController {
    
    @ObservedObject var clipsManagerViewModel = ClipsManagerViewModel()
    var usersManagerViewModel = UsersManagerViewModel()
    
    private var collectionView: UICollectionView?
    
    private var data = [VideoModel]()
    
    private var detailsButtonTappedCount = 0
    
    private var trueWidth = 800.0
    private var trueHeight = 800.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.trueWidth = self.view.frame.size.width
        self.trueHeight = self.view.frame.size.height
        
        let varTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false)
        {
            (varTimer) in
            let clipViewModels = self.clipsManagerViewModel.clipViewModels.sorted(by: { $0.clip < $1.clip })
            
            clipViewModels.forEach { clipViewModel in
                let model = VideoModel(caption: clipViewModel.clip.name,
                                       videoURL: clipViewModel.clip.downloadURL,
                                       event: clipViewModel.clip.event,
                                       section: clipViewModel.clip.section,
                                       date: clipViewModel.clip.date,
                                       detailsButtonTappedCount: 0,
                                       volumeButtonTappedCount: 0,
                                       likeButtonTappedCount: 0)
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
        
        // display likeButtonSelection
        let userID = GIDSignIn.sharedInstance.currentUser?.userID ?? "default_user_id"
        let userQuery = usersManagerViewModel.userRepository.store.collection(usersManagerViewModel.userRepository.path).whereField("username", isEqualTo: userID)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        let serialized = model.videoURL + "`" + model.caption + "`" + model.section + "`" + model.event + "`" + dateFormatter.string(from: model.date)
        
        userQuery.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let document = querySnapshot?.documents.first
                let docData = document?.data()
                let savedClips = docData!["myClips"] as! [String]
                
                // remove clip if we press like, and clip is already in this user's savedClips
                if savedClips.contains(serialized) {
                    cell.likeButton.isSelected = true
                }
                else { // add clip if we press like, and clip is NOT already in this user's savedClips
                    cell.likeButton.isSelected = false
                }
            }
        }
        
        cell.delegate = self
        cell.player?.play()
        return cell
    }
}

extension ViewController: FeedViewCellDelegate {
    
    func didTapLikeButton(with model: VideoModel) {
        let userID = GIDSignIn.sharedInstance.currentUser?.userID ?? "default_user_id"
        let userQuery = usersManagerViewModel.userRepository.store.collection(usersManagerViewModel.userRepository.path).whereField("username", isEqualTo: userID)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        let serialized = model.videoURL + "`" + model.caption + "`" + model.section + "`" + model.event + "`" + dateFormatter.string(from: model.date)
        
        
        userQuery.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let document = querySnapshot?.documents.first
                let docData = document?.data()
                let savedClips = docData!["myClips"] as! [String]
                
                // remove clip if we press like, and clip is already in this user's savedClips
                if savedClips.contains(serialized) {
                    document?.reference.updateData([
                        "myClips": FieldValue.arrayRemove([serialized])
                    ])
                }
                else { // add clip if we press like, and clip is NOT already in this user's savedClips
                    document?.reference.updateData([
                        "myClips": FieldValue.arrayUnion([serialized])
                    ])
                }
            }
        }
    }
    
    func didTapVolumeButton(with model: VideoModel) {
    }
    
    func didTapDetailsButton(with model: VideoModel) {
        if self.detailsButtonTappedCount == 0 {
            self.detailsButtonTappedCount = 1
            shouldCreateSubviews = true
            let trueSize = self.trueWidth/7
            let swipeableView: UIView = {
                // Initialize View
                let view = UIView(frame: CGRect(origin: .zero,
                                                size: CGSize(width: self.trueWidth - trueSize,
                                                             height: self.trueHeight)))
                
                // Configure View
                view.backgroundColor = .clear
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()
            self.view.addSubview(swipeableView)
        }
        else {
            self.detailsButtonTappedCount = 0
            shouldCreateSubviews = false
            
            // REMOVE SWIPEABLEVIEW HERE
            for subview in view.subviews {
                if subview.backgroundColor == .clear {
                    subview.removeFromSuperview()
                }
            }
        }
        
        let size = self.view.frame.size.width/7
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height - 100
        
        let rectangleView = UIView(frame: CGRect(x: 0, y: 650, width: self.view.frame.size.width, height: self.view.frame.size.height - 30))
        rectangleView.backgroundColor = UIColor.black
        
        
        
        let captionLabelHeader = UILabel()
        captionLabelHeader.textAlignment = .left
        captionLabelHeader.textColor = .white
        captionLabelHeader.frame = CGRect(x: 0, y: 670, width: self.view.frame.width, height: 20)
        //        sectionLabelHeader.font = UIFont.boldSystemFont(ofSize: 16.0)
        captionLabelHeader.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        captionLabelHeader.text = "       Caption: "
        
        let captionLabel = UILabel()
        captionLabel.textAlignment = .left
        captionLabel.textColor = .white
        
        captionLabel.frame = CGRect(x: 0, y: 670, width: self.view.frame.width, height: 20)
        captionLabel.text = "                       " + model.caption
        
        let eventLabelHeader = UILabel()
        eventLabelHeader.textAlignment = .left
        eventLabelHeader.textColor = .white
        eventLabelHeader.frame = CGRect(x: 0, y: 690, width: self.view.frame.width, height: 20)
        eventLabelHeader.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        eventLabelHeader.text = "       Event: "
        
        let eventLabel = UILabel()
        eventLabel.textAlignment = .left
        eventLabel.textColor = .white
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        eventLabel.frame = CGRect(x: 0, y: 690, width: self.view.frame.width, height: 20)
        eventLabel.text = "                       " + model.event + " (" + dateFormatter.string(from: model.date) + ")"
        
        let sectionLabelHeader = UILabel()
        sectionLabelHeader.textAlignment = .left
        sectionLabelHeader.textColor = .white
        sectionLabelHeader.frame = CGRect(x: 0, y: 710, width: self.view.frame.width, height: 20)
        sectionLabelHeader.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        sectionLabelHeader.text = "       Section: "
        
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
