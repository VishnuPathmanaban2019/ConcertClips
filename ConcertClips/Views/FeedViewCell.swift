//
//  FeedViewCell.swift
//  ConcertClips
//

import UIKit
import AVFoundation

protocol FeedViewCellDelegate: AnyObject {
    func didTapLikeButton(with model: VideoModel)
    
    func didTapDetailsButton(with model: VideoModel)
    
    func didTapVolumeButton(with model: VideoModel)
}

class FeedViewCell: UICollectionViewCell {

    static let identifier = "FeedViewCell"

    private let captionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
  
    private let eventLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private let sectionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
  private let audioLabel: UILabel = {
      let label = UILabel()
      label.textAlignment = .left
      label.textColor = .white
      return label
  }()

    private let likeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        return button
    }()
    
    private let detailsButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "list.bullet"), for: .normal)
        return button
    }()
    
    private let volumeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "speaker"), for: .normal)
        return button
    }()

    private let videoContainer = UIView()

    // Delegate
    weak var delegate: FeedViewCellDelegate?

    // Subviews
//    var player: AVPlayer?
    var player: AVPlayer?
    var playerView: AVPlayerLayer?

    var model: VideoModel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .black
        contentView.clipsToBounds = true
        addSubviews()
    }

    private func addSubviews() {
        contentView.addSubview(videoContainer)
        contentView.addSubview(likeButton)
        contentView.addSubview(detailsButton)
        contentView.addSubview(volumeButton)
        

        // Add actions
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchDown)
        detailsButton.addTarget(self, action: #selector(didTapDetailsButton), for: .touchDown)
        volumeButton.addTarget(self, action: #selector(didTapVolumeButton), for: .touchDown)

        videoContainer.clipsToBounds = true

        contentView.sendSubviewToBack(videoContainer)
    }

    @objc private func didTapLikeButton() {
        guard let model = model else { return }
        delegate?.didTapLikeButton(with: model)
    }
    
    @objc private func didTapDetailsButton() {
        guard let model = model else { return }
        delegate?.didTapDetailsButton(with: model)
    }
    
    // all videos will be playing initially
    // sound on all videos will be off initially
    
    // IDEA:
    // create a hitbox in the middle of the screen
    // to be able to turn volume off w hen users swipe up
    
    // also be able to get rid of details with this swiping 😈
    @objc private func didTapVolumeButton() {
        if model?.volumeButtonTappedCount == 0 {
            player?.volume = 5
            model?.volumeButtonTappedCount = 1
        }
        else {
            model?.volumeButtonTappedCount = 0
            player?.volume = 0
        }
        guard let model = model else { return }
        delegate?.didTapVolumeButton(with: model)
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        videoContainer.frame = contentView.bounds

        let size = contentView.frame.size.width/7
        let width = contentView.frame.size.width
        let height = contentView.frame.size.height - 100

        // Buttons
        likeButton.frame = CGRect(x: width-size, y: height-(size*5.5)-10, width: size, height: size)
        
        detailsButton.frame = CGRect(x: width-size, y: height-(size*4)-10, width: size, height: size)

        volumeButton.frame = CGRect(x: width-size, y: height-(size*7)-10, width: size, height: size)
        // Labels
        captionLabel.frame = CGRect(x: 5, y: height-30, width: width-size-10, height: 50)
        eventLabel.frame = CGRect(x: 5, y: height-80, width: width-size-10, height: 50)
        
        sectionLabel.frame = CGRect(x: 5, y: height-150, width: width-size-10, height: 50)
        audioLabel.frame = CGRect(x: 5, y: height-170, width: width-size-10, height: 50)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        captionLabel.text = nil
        audioLabel.text = nil
        sectionLabel.text = nil
        eventLabel.text = nil
        playerView?.removeFromSuperlayer()
    }

//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        (cell as? FeedViewCell)?.player?.play()
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        (cell as? FeedViewCell)?.player?.pause()
//    }
    
    public func configure(with model: VideoModel) {
        self.model = model
        configureVideo()

        // labels
        captionLabel.text = model.caption
        sectionLabel.text = model.section
        eventLabel.text = model.event
    }

    private func configureVideo() {
        guard let model = model else {
            return
        }
//        guard let path = Bundle.main.path(forResource: model.videoFileName,
//                                          ofType: model.videoFileFormat) else {
//                                            print("Failed to find video")
//                                            return
//        }

        
        let videoURL = NSURL(string: model.videoURL)!
//
        player = AVPlayer(url: videoURL as URL)
//        player = AVPlayer(url: URL(string: model.videoURL)!)

        let playerView = AVPlayerLayer()
        playerView.player = player
        playerView.frame = contentView.bounds
        playerView.videoGravity = .resizeAspectFill
        videoContainer.layer.addSublayer(playerView)
        player?.volume = 0
        player?.play()
        loopVideo(player!)
    }
    
    func loopVideo(_ videoPlayer: AVPlayer) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { notification in
            videoPlayer.seek(to: CMTime.zero)
                videoPlayer.play()
                videoPlayer.volume = 0 // set volume to 0 once video loops
                self.model?.volumeButtonTappedCount = 0
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


