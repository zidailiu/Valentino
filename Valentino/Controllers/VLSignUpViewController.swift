//
//  VLSignUpViewController.swift
//  Valentino
//
//  Created by Liu John on 2022-02-09.
//

import UIKit
import Firebase
import FirebaseAuth



class VLSignUpViewController: UIViewController {
    // MARK: class proporties
    let welcomeLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.init(name: "Roboto-Medium", size: 30)
        label.text = "Create a New Account"
        return label
    }()
    let welcomeWordLabel : UILabel = {
        let label = UILabel()
        label.textColor = VLConstants.valentinoMainSceneColor
        label.font = UIFont.init(name: "Roboto-Regular", size: 18)
        label.text = "Becoming a Valentino by Creating an Account"
        label.numberOfLines = 2
        return label
    }()
    
    let emailTextField: UITextField = {
       let tf = UITextField()
        tf.layer.cornerRadius = 15
        tf.attributedPlaceholder = NSAttributedString(
            string: "School Email", attributes: [
                NSAttributedString.Key.foregroundColor : UIColor.white,
                NSAttributedString.Key.font : UIFont.init(name: "Roboto-Regular", size: 18)!]
        )
        tf.backgroundColor = VLConstants.valentinoFieldSceneColor
        tf.setLeftPaddingPoints(24)
        return tf
    }()
    
    let userNameTextField: UITextField = {
        let tf = UITextField()
        tf.layer.cornerRadius = 15
        tf.attributedPlaceholder = NSAttributedString(
            string: "Valentino Name", attributes: [
                NSAttributedString.Key.foregroundColor : UIColor.white,
                NSAttributedString.Key.font : UIFont.init(name: "Roboto-Regular", size: 18)!]
        )
        tf.backgroundColor = VLConstants.valentinoFieldSceneColor
        tf.setLeftPaddingPoints(24)
        
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.layer.cornerRadius = 15
        tf.attributedPlaceholder = NSAttributedString(
            string: "Password", attributes: [
                NSAttributedString.Key.foregroundColor : UIColor.white,
                NSAttributedString.Key.font : UIFont.init(name: "Roboto-Regular", size: 18)!]
        )
        tf.backgroundColor = UIColor(red: 196/255.0, green: 196/255.0, blue: 196/255.0, alpha: 0.5)
        tf.setLeftPaddingPoints(24)

        
        return tf
    }()
    
    let signUpButton: UIButton = {
            let button = UIButton(type: .custom)
            button.setTitle("Create Account", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.init(name: "Roboto-Regular", size: 18)
            button.layer.cornerRadius = 15
            button.backgroundColor = UIColor(red: 240/255.0, green: 150/255.0, blue: 129/255.0, alpha: 1)
            return button
        }()
    
    let backwardButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "arrow-left.png"), for: .highlighted)
        button.setImage(UIImage(named: "arrow-left.png"), for: .normal)
        
        return button
    }()
    
    // MARK: view methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        setUpUI()
    }
    
    
    // MARK: UISetup
    
    func setUpUI() {
        view.addSubview(welcomeLabel)
        view.addSubview(welcomeWordLabel)
        view.addSubview(emailTextField)
        view.addSubview(userNameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signUpButton)
        view.addSubview(backwardButton)
        
        signUpButton.addTarget(self, action: #selector(signUpAccount), for: .touchUpInside)
        backwardButton.addTarget(self, action: #selector(getBackToPrevious), for: .touchUpInside)
        
        
        welcomeLabel.snp.makeConstraints ({ (make) in
            make.top.equalTo(view).offset(CGFloat(107 / VLConstants.iphone12Height) * view.frame.size.height)
            make.left.equalTo(view).offset(CGFloat(37 / VLConstants.iphone12Width) * view.frame.size.width)
        })
        welcomeWordLabel.snp.makeConstraints ({ (make) in
            make.top.equalTo(welcomeLabel.snp_bottom).offset(13)
            make.left.equalTo(view).offset(CGFloat(37 / VLConstants.iphone12Width) * view.frame.size.width)
            make.right.equalTo(view).offset(CGFloat(-38 / VLConstants.iphone12Width) * view.frame.size.width)
        })
        
        userNameTextField.snp.makeConstraints ({ (make) in
            make.top.equalTo(view).offset(CGFloat(260 / VLConstants.iphone12Height) * view.frame.size.height)
            make.left.equalTo(view).offset(CGFloat(37 / VLConstants.iphone12Width) * view.frame.size.width)
            make.height.equalTo(52)
            make.width.equalTo(313)
            
        })
        
        
        emailTextField.snp.makeConstraints ({ (make) in
            make.top.equalTo(userNameTextField.snp_bottom).offset(30)
            make.left.equalTo(view).offset(CGFloat(37 / VLConstants.iphone12Width) * view.frame.size.width)
            make.height.equalTo(52)
            make.width.equalTo(313)
        })
        
        passwordTextField.snp.makeConstraints ({ (make) in
            make.top.equalTo(emailTextField.snp_bottom).offset(30)
            make.left.equalTo(view).offset(CGFloat(37 / VLConstants.iphone12Width) * view.frame.size.width)
            make.height.equalTo(52)
            make.width.equalTo(313)
        })
        
        signUpButton.snp.makeConstraints ({ (make) in
            make.top.equalTo(passwordTextField.snp_bottom).offset(98)
            make.left.equalTo(view).offset(CGFloat(41 / VLConstants.iphone12Width) * view.frame.size.width)
            make.height.equalTo(57)
            make.width.equalTo(305)
        })
        
        backwardButton.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(CGFloat(13/VLConstants.iphone12Width) * view.frame.size.width)
            make.top.equalTo(view).offset(CGFloat(64/VLConstants.iphone12Height) * view.frame.size.height)
            make.height.width.equalTo(24)
        }
    }
    
    @objc func getBackToPrevious() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: sign up request
    
    @objc private func signUpAccount() {
        UIView.animate(withDuration: 0.2,
                       animations: {
                            self.signUpButton.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                       },
                       completion: { _ in
                            UIView.animate(withDuration: 0.2, animations: {
                                self.signUpButton.transform = CGAffineTransform.identity
                            })
                        
                        //check password
                        
                        guard let email = self.emailTextField.text, !email.isEmpty, let password = self.passwordTextField.text, !password.isEmpty, let username = self.userNameTextField.text, !username.isEmpty else {
                            print("Missing field data")
                            return
                        }
                        
                        
                        //let settingSetupVC = VLSettingsSetupViewController(email: email, password: password)
                        // self.navigationController!.pushViewController(settingSetupVC, animated: true)
                                                
                        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { registered in
                            DispatchQueue.main.async {
                                if registered {
                                    print ("Account creation successful")
                                    let verificationVC = VLPendingVerificationViewController()
                                    self.navigationController!.pushViewController(verificationVC, animated: true)
                                } else {
                                    
                                }
                            }
                            
                        }
                        
                        /*
                        
                        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {(result, error) in
                            
                            guard error == nil else{
                                print(error!.localizedDescription)
                                return
                            }
                            
                            let db = Firestore.firestore()
                            db.collection("users").addDocument(data: ["firstname" : "Bobby", "uid": result!.user.uid]) { (error) in
                                
                            }
                            /*
                            Auth.auth().currentUser?.sendEmailVerification { error in
                              // ...
                            }
                            print ("Account creation successful")*/
                            
                        })*/
                        
            
        })
    }

}
