//
//  VLFeedPostTableViewCell.swift
//  Valentino
//
//  Created by Liu John on 2022-03-16.
//

import UIKit
import SDWebImage

final class VLFeedPostTableViewCell: UITableViewCell {
    
    static let identifier = "VLFeedPostTableViewCell"
    
    private let avatarImageView: UIImageView = {
        let aImageView = UIImageView()
        aImageView.layer.cornerRadius = 24
        aImageView.image = UIImage(named: "testSubject.png")
        aImageView.clipsToBounds = true
        return aImageView
    }()
    
    private let maskDescriptionView: UIView = {
        let maskView = UIView()
        maskView.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.9)
        maskView.layer.cornerRadius = 15
        maskView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        return maskView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 32
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1)
        button.setImage(UIImage(named: "Vectorheart.png"), for: .normal)
        button.setImage(UIImage(named: "Vectorheart.png"), for: .highlighted)
        return button
    }()
    
    private let dislikeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 32
        button.layer.masksToBounds = true

        button.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1)
        button.setImage(UIImage(named: "Vectordislike.png"), for: .normal)
        button.setImage(UIImage(named: "Vectordislike.png"), for: .highlighted)
        return button
    }()
    
    private var model: FeedCellModel?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(likeButton)
        contentView.addSubview(dislikeButton)
        avatarImageView.addSubview(maskDescriptionView)
        avatarImageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView)
            make.left.right.equalTo(contentView)
            make.height.equalTo(585)
            make.width.equalTo(340)
        }
        likeButton.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImageView.snp_bottom).offset(33)
            make.right.equalTo(contentView).offset(-71)
            make.height.width.equalTo(64)
        }
        dislikeButton.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImageView.snp_bottom).offset(33)
            make.left.equalTo(contentView).offset(71)
            make.height.width.equalTo(64)
        }
        
        maskDescriptionView.snp.makeConstraints { (make) in
            make.bottom.equalTo(avatarImageView.snp_bottom).offset(-52)
            make.right.equalTo(avatarImageView.snp_right)
            make.height.equalTo(77)
            make.width.equalTo(282)
            
        }
        
        likeButton.addTarget(self, action: #selector(likeUser), for: .touchUpInside)
        dislikeButton.addTarget(self, action: #selector(dislikeUser), for: .touchUpInside)

       
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model:FeedCellModel) {
        // configure the cell
        self.model = model
        self.avatarImageView.sd_imageIndicator?.startAnimatingIndicator()
        self.avatarImageView.sd_setImage(with: self.model!.userPhotoURL, completed: { (image, err, type, url) in
            if err != nil {
                self.sd_imageIndicator?.stopAnimatingIndicator()
                print("Failed to download image")
            }
            self.sd_imageIndicator?.stopAnimatingIndicator()
        })
        
    }
    
    @objc func likeUser() {
        UIView.animate(withDuration: 0.2,
            animations: {
                self.likeButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.2) {
                    self.likeButton.transform = CGAffineTransform.identity
                    
                }
            })
    }
    @objc func dislikeUser() {
        UIView.animate(withDuration: 0.2,
            animations: {
                self.dislikeButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.2) {
                    self.dislikeButton.transform = CGAffineTransform.identity
                    
                }
                NotificationCenter.default.post(name: Notification.Name(rawValue: matchedUserDislikeNotificationKey), object: self)
                
            })
    }

}
