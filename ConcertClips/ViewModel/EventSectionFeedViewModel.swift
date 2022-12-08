//
//  EventSectionFeedViewModel.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 12/7/22.
//

import UIKit
import SwiftUI



class EventSectionViewController: UIViewController {
  
  @ObservedObject var clipsManagerViewModel = ClipsManagerViewModel()
  
  @State var eventName: String
  @State var section: String
  
//  convenience init() {
//      self.init(nibName:nil, bundle:nil)
//  }

  init(eventName: String, section: String) {
    self.eventName = eventName
    self.section = section
    super.init(nibName: nil, bundle: nil)
  }

  // This is also necessary when extending the superclass.
  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented") // or see Roman Sausarnes's answer
  }
  
    // sarun
    private var sarunLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.text = "hello, roshan!"
        label.textAlignment = .center
        
        return label
    }()
    // sarun
  
    private var collectionView: UICollectionView?

    private var data = [VideoModel]()
    
    private var detailsButtonTappedCount = 0

    override func viewDidLoad() {
      
        super.viewDidLoad()
        
        // old (good) code below
//        let clipViewModels = clipsManagerViewModel.clipViewModels.sorted(by: { $0.clip < $1.clip })

        
        let varTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false)
        {
            (varTimer) in
            let clipViewModels = self.clipsManagerViewModel.clipViewModels.sorted(by: { $0.clip < $1.clip })
//            print("viewdidLoad (feedViewModel): \(clipViewModels)")
            
            
            //        for clipViewModel in clipViewModels {
          print("eventName in vm \(self.eventName)")
          clipViewModels.forEach { clipViewModel in
            if (clipViewModel.clip.event == self.eventName && clipViewModel.clip.section == self.section) {
              let model = VideoModel(caption: clipViewModel.clip.name,
                                     videoURL: clipViewModel.clip.downloadURL,
                                     event: clipViewModel.clip.event,
                                     section: clipViewModel.clip.section,
                                     detailsButtonTappedCount: 0,
                                     volumeButtonTappedCount: 0)
              //                print("viewmodel \(model.videoURL)")
              self.data.append(model)
            }
          }

                    let layout = UICollectionViewFlowLayout() // possible issue
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

extension EventSectionViewController: UICollectionViewDataSource {
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
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        (cell as? FeedViewCell)?.player?.play()
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        (cell as? FeedViewCell)?.player?.pause()
//    }
}

extension EventSectionViewController: FeedViewCellDelegate {
    
    func didTapLikeButton(with model: VideoModel) {
        print("like button tapped")
    }
    
    func didTapVolumeButton(with model: VideoModel) {
        print("volume button tapped")
    }
    
    func didTapDetailsButton(with model: VideoModel) {
        print("details button tapped")
        
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
        
        let rectangleView = UIView(frame: CGRect(x: 0, y: 600, width: self.view.frame.size.width, height: self.view.frame.size.height - 30))
        rectangleView.backgroundColor = UIColor.black
        
        let captionLabel = UILabel()
        captionLabel.textAlignment = .left
        captionLabel.textColor = .white
        
        captionLabel.frame = CGRect(x: 0, y: 620, width: self.view.frame.width, height: 20)
        captionLabel.text = model.caption
      
        let eventLabel = UILabel()
        eventLabel.textAlignment = .left
        eventLabel.textColor = .white
        
        eventLabel.frame = CGRect(x: 0, y: 640, width: self.view.frame.width, height: 20)
        eventLabel.text = model.event
        
        let sectionLabel = UILabel()
        sectionLabel.textAlignment = .left
        sectionLabel.textColor = .white
        
        sectionLabel.frame = CGRect(x: 0, y: 660, width: self.view.frame.width, height: 20)
        sectionLabel.text = model.section
        
        view.addSubview(rectangleView)
        view.addSubview(captionLabel)
        view.addSubview(eventLabel)
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
