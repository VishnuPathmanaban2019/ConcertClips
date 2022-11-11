//
//  ViewController.swift
//  ConcertClips
//

// Citations:
// Adapted from: https://github.com/dks333/Tiktok-Clone

import UIKit

struct VideoModel {
    let caption: String
   
    let videoURL: String
    
    let event: String
    let section: String
    let audioTrackName: String
      
    let detailsButtonTappedCount: Int
}

class ViewController: UIViewController {
  
    var clipsManagerViewModel = ClipsManagerViewModel()

    private var collectionView: UICollectionView?

    private var data = [VideoModel]()
    
    private var detailsButtonTappedCount = 0

    override func viewDidLoad() {
      
        super.viewDidLoad()
      
        let clipViewModels = clipsManagerViewModel.clipViewModels.sorted(by: { $0.clip < $1.clip })
        for clipViewModel in clipViewModels {
          let model = VideoModel(caption: clipViewModel.clip.name,
                                 videoURL: clipViewModel.clip.downloadURL,
                                 event: clipViewModel.clip.event,
                                 section: clipViewModel.clip.section,
                                 audioTrackName: clipViewModel.clip.song,
                                 detailsButtonTappedCount: 0)
          data.append(model)
        }

//        let model = VideoModel(caption: "Caption: You just cannot tell me nothing!",
//                               audioTrackName: "Song: Can't Tell Me Nothing",
//                               videoFileName: "kanye_video1",
//                               videoFileFormat: "mp4",
//                               artist: "Artist: Kanye West",
//                               section: "Section: 4",
//                               event: "Event: Rolling Loud LA 2021",
//                               detailsButtonTappedCount: 0)
//        data.append(model)

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width,
                                 height: view.frame.size.height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(FeedViewCell.self,
                                 forCellWithReuseIdentifier: FeedViewCell.identifier)
        collectionView?.isPagingEnabled = true
        collectionView?.dataSource = self
        view.addSubview(collectionView!)
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
        cell.delegate = self
        return cell
    }
}

extension ViewController: FeedViewCellDelegate {
    
    func didTapLikeButton(with model: VideoModel) {
        print("like button tapped")
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
        
        let audioLabel = UILabel()
        audioLabel.textAlignment = .left
        audioLabel.textColor = .white
        
        audioLabel.frame = CGRect(x: 0, y: 680, width: self.view.frame.width, height: 20)
        audioLabel.text = model.audioTrackName
        
        view.addSubview(rectangleView)
        view.addSubview(captionLabel)
        view.addSubview(eventLabel)
        view.addSubview(sectionLabel)
        view.addSubview(audioLabel)

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
