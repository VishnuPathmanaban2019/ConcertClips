//
//  SavedClipsViewModel.swift
//  ConcertClips
//
//  Created by Vishnu Pathmanaban on 12/7/22.
//

import UIKit
import SwiftUI
import GoogleSignIn
import FirebaseFirestore

class SavedViewController: UIViewController {

    @ObservedObject var clipsManagerViewModel = ClipsManagerViewModel()
    var usersManagerViewModel = UsersManagerViewModel()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    // This is also necessary when extending the superclass.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var collectionView: UICollectionView?

    private var data = [VideoModel]()

    private var detailsButtonTappedCount = 0


// rram -- UI follow up & work on bookmark persistence Issue:
//- First click seems to not do anything to the bookmark UI
//- Unbookmarked clip in savedClips does not go away (even after moving away and coming back to tab)
//    - leads:
//        - How often is viewDidLoad called?
//            - Will I need to remove from self.data?
//        - Is querySnapshot saved? How often is it refreshed?
//            - Can I use snapshotListener instead? To get realtime data?
//                - https://firebase.google.com/docs/firestore/query-data/listen
//
//

    override func viewDidLoad() {

        super.viewDidLoad()

        let userID = GIDSignIn.sharedInstance.currentUser?.userID ?? "default_user_id"
        let userQuery = self.usersManagerViewModel.userRepository.store.collection(self.usersManagerViewModel.userRepository.path).whereField("username", isEqualTo: userID)

        userQuery.addSnapshotListener(includeMetadataChanges: true) { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let document = querySnapshot?.documents.first
                let docData = document?.data()
                let savedClips = docData!["myClips"] as! [String]
//                print(savedClips)
                savedClips.forEach { savedClip in
                    let fields = savedClip.components(separatedBy: "`")
                    let model = VideoModel(caption: fields[1],
                                           videoURL: fields[0],
                                           event: fields[3],
                                           section: fields[2],
                                           detailsButtonTappedCount: 0,
                                           volumeButtonTappedCount: 0)
                    self.data.append(model)
                }
            }
        }

        let varTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false)
        {
            (varTimer) in

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

extension SavedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = data[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedViewCell.identifier,
                                                      for: indexPath) as! FeedViewCell
        cell.configure(with: model)
        cell.delegate = self
        cell.player?.play()
        return cell
    }
}

extension SavedViewController: FeedViewCellDelegate {

    func didTapLikeButton(with model: VideoModel) {
        let userID = GIDSignIn.sharedInstance.currentUser?.userID ?? "default_user_id"
        let userQuery = usersManagerViewModel.userRepository.store.collection(usersManagerViewModel.userRepository.path).whereField("username", isEqualTo: userID)

        let serialized = model.videoURL + "`" + model.caption + "`" + model.section + "`" + model.event

        userQuery.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let document = querySnapshot?.documents.first
                let docData = document?.data()
                let savedClips = docData!["myClips"] as! [String]
//                let likeButtonSelected = docData!["likeButtonSelected"] as! [String]

                print("savedClips (from scvm): \(savedClips)")


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

        let rectangleView = UIView(frame: CGRect(x: 0, y: 520, width: self.view.frame.size.width, height: self.view.frame.size.height - 30))
        rectangleView.backgroundColor = UIColor.black
        
        // rram
        let captionLabelHeader = UILabel()
        captionLabelHeader.textAlignment = .left
        captionLabelHeader.textColor = .white
        captionLabelHeader.frame = CGRect(x: 0, y: 540, width: self.view.frame.width, height: 20)
//        sectionLabelHeader.font = UIFont.boldSystemFont(ofSize: 16.0)
        captionLabelHeader.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        captionLabelHeader.text = "      Caption: "
        // rram

        let captionLabel = UILabel()
        captionLabel.textAlignment = .left
        captionLabel.textColor = .white

        captionLabel.frame = CGRect(x: 0, y: 540, width: self.view.frame.width, height: 20)
        captionLabel.text = "                      " + model.caption
        
        // rram
        let eventLabelHeader = UILabel()
        eventLabelHeader.textAlignment = .left
        eventLabelHeader.textColor = .white
        eventLabelHeader.frame = CGRect(x: 0, y: 560, width: self.view.frame.width, height: 20)
//        sectionLabelHeader.font = UIFont.boldSystemFont(ofSize: 16.0)
        eventLabelHeader.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        eventLabelHeader.text = "      Event: "
        // rram

        let eventLabel = UILabel()
        eventLabel.textAlignment = .left
        eventLabel.textColor = .white

        eventLabel.frame = CGRect(x: 0, y: 560, width: self.view.frame.width, height: 20)
        eventLabel.text = "                      " + model.event
        
        
        // rram
        let sectionLabelHeader = UILabel()
        sectionLabelHeader.textAlignment = .left
        sectionLabelHeader.textColor = .white
        sectionLabelHeader.frame = CGRect(x: 0, y: 580, width: self.view.frame.width, height: 20)
//        sectionLabelHeader.font = UIFont.boldSystemFont(ofSize: 16.0)
        sectionLabelHeader.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        sectionLabelHeader.text = "      Section: "
        // rram

        let sectionLabel = UILabel()
        sectionLabel.textAlignment = .left
        sectionLabel.textColor = .white

        sectionLabel.frame = CGRect(x: 0, y: 580, width: self.view.frame.width, height: 20)
        sectionLabel.text = "                      " + model.section

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

