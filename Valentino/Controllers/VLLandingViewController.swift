//
//  VLLandingViewController.swift
//  Valentino
//
//  Created by Liu John on 2022-02-06.
//3

import UIKit
import SnapKit

class VLLandingViewController: UIViewController {
    
    var welcomeLabel : UILabel?
    var nextPageButton : UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationController?.isNavigationBarHidden = true
        
        view.backgroundColor = .white
        addImageView()
        addWelcomeLabel()
        addButton()
        
    }
    
    func addImageView() {
        let valentinoImage = UIImage(named: "valentinoLanding.png")
        let valentinoImageView = UIImageView(image: valentinoImage)
        
        view.addSubview(valentinoImageView)
        
        valentinoImageView.snp.makeConstraints ({ (make) in
            make.top.equalTo(view).offset(0.17 * view.frame.size.height)
            make.right.equalTo(view).offset(-0.046 * view.frame.size.width)
            make.left.equalTo(view).offset(0.046 * view.frame.size.width)
        })
    }
    
    func addWelcomeLabel() {
        welcomeLabel = UILabel.init()
        welcomeLabel?.textColor = .black
        
        welcomeLabel!.font = UIFont.init(name: "Roboto-Black", size: 28)
        
        welcomeLabel!.text = "Find the Perfect Match For you"
        welcomeLabel!.numberOfLines = 2
        
        view.addSubview(welcomeLabel!)
        welcomeLabel!.snp.makeConstraints ({ (make) in
            make.top.equalTo(view).offset(0.647 * view.frame.size.height)
            make.right.equalTo(view).offset(-0.128 * view.frame.size.width)
            make.left.equalTo(view).offset(0.128 * view.frame.size.width)
        })
    }
    
    func addButton() {
        nextPageButton = UIButton.init(type: .custom)
        nextPageButton?.setImage(UIImage(named: "VectorrightVector.png"), for: .normal)
        nextPageButton?.setImage(UIImage(named: "VectorrightVector.png"), for: .highlighted)

        nextPageButton?.backgroundColor = UIColor(red: 240/255.0, green: 150/255.0, blue: 129/255.0, alpha: 1)
        
        nextPageButton?.layer.cornerRadius = 32
        
        view.addSubview(nextPageButton!)
        nextPageButton!.snp.makeConstraints ({ (make) in
            make.top.equalTo(view).offset(0.853 * view.frame.size.height)
            make.left.equalTo(view).offset(0.687 * view.frame.size.width)
            make.height.width.equalTo(64)
        })
        
        nextPageButton!.addTarget(self, action: #selector(proceedToNextPage), for: .touchUpInside)
    }
    
    @objc func proceedToNextPage() {
        UIView.animate(withDuration: 0.2,
            animations: {
                self.nextPageButton?.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.2) {
                    self.nextPageButton?.transform = CGAffineTransform.identity
                    
                    let loginVC = VLLoginViewController.init()
                    self.navigationController?.pushViewController(loginVC, animated: true)
                    
                }
            })
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
