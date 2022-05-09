//
//  VLMatchCoverView.swift
//  Valentino
//
//  Created by Liu John on 2022-04-23.
//

import UIKit
import Lottie

class VLMatchCoverView: UIView {

    private let promptLabel: UILabel = {
        let prompt = UILabel()
        prompt.textColor = .black
        prompt.font = UIFont.init(name: "Roboto-Black", size: 19)
        prompt.text = "Tap the Heart to Start Your Match!"
        return prompt
    }()
    
    private let animationView: AnimationView = {
        let animationV = AnimationView(name: "valentino_heart")
        animationV.loopMode = .loop
        return animationV
    }()
    
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(animationView)
        addSubview(promptLabel)
        animationView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(0.25 * VLConstants.iphone12Height)
            make.left.equalTo(self).offset(0.213 * VLConstants.iphone12Width)
            make.right.equalTo(self).offset(-0.213 * VLConstants.iphone12Width)
            make.width.height.equalTo(175)
            
        }
        
        promptLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(0.544 * VLConstants.iphone12Height)
            make.left.equalTo(self).offset(21)
            make.height.equalTo(30)
        }
        animationView.pause()
        let tapRegisterGesture = UITapGestureRecognizer(target: self, action: #selector(matchUser(tapGestureRecognizer:)))
        animationView.addGestureRecognizer(tapRegisterGesture)
        animationView.isUserInteractionEnabled = true
        
    }
    
    @objc func matchUser(tapGestureRecognizer: UITapGestureRecognizer){
        promptLabel.isHidden = true
        let minimizeTransform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        animationView.transform = minimizeTransform
        
        UIView.animate(withDuration: 2.0, delay: 0.0, options: [.repeat, .autoreverse], animations: {self.animationView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)}, completion: { _ in
        
        })
        self.animationView.play()

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.animationView.layer.removeAllAnimations()
            self.animationView.stop()
            //self.animationView.isHidden = true
            self.promptLabel.isHidden = false
            self.animationView.transform = CGAffineTransform.identity
            NotificationCenter.default.post(name: Notification.Name(rawValue: matchedUserFoundNotificationKey), object: self)
        }
    }
    

}
