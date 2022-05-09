//
//  VLPendingVerificationViewController.swift
//  Valentino
//
//  Created by Liu John on 2022-02-10.
//

import UIKit

class VLPendingVerificationViewController: UIViewController {
    
    //MARK: properties
    
    let logoImageView : UIImageView = {
        
        let valentinoImage = UIImage(named: "valentinoLanding.png")
        let valentinoImageView = UIImageView(image: valentinoImage)
        return valentinoImageView
    }()
    
    let promptingLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.init(name: "Roboto-Black", size: 30)
        label.text = "Welcome to Valentino!"
        return label
    }()
    
    let detailPromptingLabel : UILabel = {
        let label = UILabel()
        label.textColor = VLConstants.valentinoMainSceneColor
        label.font = UIFont.init(name: "Roboto-Regular", size: 20)
        label.text = "Please verify email address by clicking on the link we sent you..."
        label.numberOfLines = 2
        return label
    }()
    
    let backwardButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "arrow-left.png"), for: .highlighted)
        button.setImage(UIImage(named: "arrow-left.png"), for: .normal)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        setUpUI()
    }
    
    // MARK: set up UI
    
    func setUpUI () {
        view.addSubview(logoImageView)
        view.addSubview(promptingLabel)
        view.addSubview(detailPromptingLabel)
        
        view.addSubview(backwardButton)
        
        backwardButton.addTarget(self, action: #selector(getBackToPrevious), for: .touchUpInside)
        
        backwardButton.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(CGFloat(13/VLConstants.iphone12Width) * view.frame.size.width)
            make.top.equalTo(view).offset(CGFloat(64/VLConstants.iphone12Height) * view.frame.size.height)
            make.height.width.equalTo(24)
        }

        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(CGFloat(122/VLConstants.iphone12Height) * view.frame.size.height)
            make.left.equalTo(view).offset(CGFloat(25/VLConstants.iphone12Width) * view.frame.size.width)
            make.height.width.equalTo(CGFloat(354 / VLConstants.iphone12Width) * view.frame.size.width)
        }
        
        promptingLabel.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp_bottom).offset(CGFloat(57/VLConstants.iphone12Height) * view.frame.size.height)
            make.left.equalTo(view).offset(CGFloat(43/VLConstants.iphone12Width) * view.frame.size.width)
        }
        
        detailPromptingLabel.snp.makeConstraints { (make) in
            make.top.equalTo(promptingLabel.snp_bottom).offset(CGFloat(28/VLConstants.iphone12Height) * view.frame.size.height)
            make.left.equalTo(view).offset(CGFloat(43/VLConstants.iphone12Width) * view.frame.size.width)
            make.right.equalTo(view).offset(CGFloat(-58/VLConstants.iphone12Width) * view.frame.size.width)
        }
        
    }
    
    @objc func getBackToPrevious() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
