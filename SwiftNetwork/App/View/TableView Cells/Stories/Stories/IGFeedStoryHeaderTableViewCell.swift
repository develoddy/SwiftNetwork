//
//  IGFeedStoryHeaderTableViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 21/7/21.
//

import UIKit

protocol IGFeedStoryHeaderTableViewCellDelegate: AnyObject {
    func didTapDismissButton()
}

class IGFeedStoryHeaderTableViewCell: UITableViewCell {
        
    var progressView: SegmentedProgressBar!
    
    var storyViewController : StoryViewController!
    
    static let identifier = "IGFeedStoryHeaderTableViewCell"
    
    public var delegate: IGFeedStoryHeaderTableViewCellDelegate?
    
    private let lineLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBlue
        return label
    }()
    
    /*public let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.trackTintColor = .gray
        progressView.progressTintColor = .systemBlue
        return progressView
    }()*/
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.tintColor = .label
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    public let usernameButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(Constants.Color.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.contentHorizontalAlignment = .left
        let config = UIImage.SymbolConfiguration(pointSize: 12, weight: .semibold)
        button.setImage(UIImage(systemName: "checkmark.seal.fill", withConfiguration: config)?.withRenderingMode(.alwaysOriginal).withTintColor(Constants.Color.black), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "44 min"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = Constants.Color.general
        return label
    }()
    
    private let moreButton: UIButton = {
       let button = UIButton()
        //button.setImage(UIImage(systemName:"xmark"), for: .normal)
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        button.setImage(UIImage(systemName: "xmark", withConfiguration: config)?.withRenderingMode(.alwaysOriginal).withTintColor(Constants.Color.black), for: .normal)
        //button.tintColor = Constants.Color.black
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupView() {
        //addSubview(lineLabel)
        //addSubview(progressView)
        addSubview(userImageView)
        addSubview(usernameButton)
        addSubview(timeLabel)
        addSubview(moreButton)
        moreButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        ///contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedView)))
    }
    
    @objc func handleDismiss() {
        delegate?.didTapDismissButton()
       
        /*for x in 0..<100 {
            DispatchQueue.main.asyncAfter(deadline: .now()+(Double(x)*0.25)) {
                self.progressView.setProgress(Float(x)/100, animated: true)
            }
        }*/
    }
    
    public func start() {
        progressView?.startAnimation()
    }
   
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        /*lineLabel.frame = CGRect(
            x: 0,
            y: 15,
            width: width,
            height: 20)*/
        //progressView.frame = CGRect(x: 10, y: 15, width: frame.size.width-20, height: 20)
        //progressView.setProgress(0, animated: false)
        
        progressView = SegmentedProgressBar(numberOfSegments: 3, duration: 5)
        progressView.frame = CGRect(x: 10, y: 15, width: frame.width - 20, height: 4)
        progressView.topColor = Constants.Color.whiteLight
        progressView.padding = 2
        addSubview(progressView)
        
        userImageView.backgroundColor = .systemPink
        userImageView.frame = CGRect(
            x: 5,
            y: progressView.bottom+10,
            width: contentView.height/2,
            height: contentView.height/2)
        userImageView.layer.cornerRadius = userImageView.height/2
        
        let size = contentView.height
        let labelHeight = contentView.height/3
        usernameButton.frame = CGRect(
            x: userImageView.right+10,
            y: progressView.bottom+10,
            width: contentView.width-(size*2)-15,
            height: labelHeight)
        
        let timeLabelSize = timeLabel.sizeThatFits(frame.size)
        timeLabel.frame = CGRect(
            x: userImageView.right+10,
            y: usernameButton.bottom-2,
            width: contentView.width-(size*2)-15,
            height: timeLabelSize.height).integral
        
        let moreButtonlSize = moreButton.sizeThatFits(frame.size)
        moreButton.frame = CGRect(
            x: contentView.width-size,
            y: progressView.bottom+10,
            width: size,
            height: moreButtonlSize.height).integral
    }
    
    public func configure(with model: CollectionTableCellModel) {
        usernameButton.setTitle(model.title, for: .normal)
    }
}
