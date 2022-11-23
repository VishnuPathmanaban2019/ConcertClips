//
//  FeedViewCell.swift
//  ConcertClips
//

import UIKit
import AVFoundation

protocol FeedViewCellDelegate: AnyObject {
    func didTapLikeButton(with model: VideoModel)
    
    func didTapDetailsButton(with model: VideoModel)
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

    private let videoContainer = UIView()

    // Delegate
    weak var delegate: FeedViewCellDelegate?

    // Subviews
    var player: AVPlayer?

    private var model: VideoModel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .red
        contentView.clipsToBounds = true
        addSubviews()
    }

    private func addSubviews() {
        contentView.addSubview(videoContainer)
        contentView.addSubview(likeButton)
        contentView.addSubview(detailsButton)
        

        // Add actions
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchDown)
        detailsButton.addTarget(self, action: #selector(didTapDetailsButton), for: .touchDown)

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

    override func layoutSubviews() {
        super.layoutSubviews()

        videoContainer.frame = contentView.bounds

        let size = contentView.frame.size.width/7
        let width = contentView.frame.size.width
        let height = contentView.frame.size.height - 100

        // Buttons
        likeButton.frame = CGRect(x: width-size, y: height-(size*5.5)-10, width: size, height: size)
        
        detailsButton.frame = CGRect(x: width-size, y: height-(size*4)-10, width: size, height: size)

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
    }

    public func configure(with model: VideoModel) {
        self.model = model
        configureVideo()

        // labels
        captionLabel.text = model.caption
        audioLabel.text = model.audioTrackName
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
        //        player = AVPlayer(url: URL(string: model.videoURL)!) // OLD old
        
        
        // old working code
//        player = AVPlayer(url: videoURL as URL)
//        let playerView = AVPlayerLayer()
//        playerView.player = player
//        playerView.frame = contentView.bounds
//        playerView.videoGravity = .resizeAspectFill
//        videoContainer.layer.addSublayer(playerView)
//        player?.volume = 0
        // end old working code
        
        
        // new code rram to fix replay issue v2
        
        let playerItem = AVPlayerItem(url: videoURL as URL)
        let player = AVQueuePlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: player)

        let playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)

        playerLayer.frame = contentView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        videoContainer.layer.addSublayer(playerLayer)

        // Add the playerLayer to a UIView.layer

        player.play()
        // end
        
        // new code rram to fix replay issue
//        player = AVQueuePlayer()
//        let playerLayer = AVPlayerLayer(player: player)
//
//        playerLayer.player = player
//        playerLayer.frame = contentView.bounds
//        playerLayer.videoGravity = .resizeAspectFill
//        videoContainer.layer.addSublayer(playerLayer)
//        player?.volume = 0
//
//        let playerItem = AVPlayerItem(url: videoURL as URL)
//        let playerLooper = AVPlayerLooper(player: player as! AVQueuePlayer, templateItem: playerItem)
//        player?.play()
        // new code rram to fix replay issue
        
//        player?.play()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


