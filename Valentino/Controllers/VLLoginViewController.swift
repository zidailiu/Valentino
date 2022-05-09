//
//  VLLoginViewController.swift
//  Valentino
//
//  Created by Liu John on 2022-02-07.
//

import UIKit
import SnapKit
import FirebaseAuth


struct VLConstants {
    static let iphone12Width = 390.0
    static let iphone12Height = 844.0
    static let valentinoMainSceneColor = UIColor(red: 240/255.0, green: 150/255.0, blue: 129/255.0, alpha: 1)
    static let valentinoFieldSceneColor = UIColor(red: 196/255.0, green: 196/255.0, blue: 196/255.0, alpha: 0.5)
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width:amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}


class VLLoginViewController: UIViewController {
    
    // MARK: Class properties
    var welcomeLabel : UILabel?
    var welcomeWordLabel : UILabel?
    
    let userNameTextField: UITextField = {
        let tf = UITextField()
        tf.layer.cornerRadius = 15
        tf.attributedPlaceholder = NSAttributedString(
            string: "Email", attributes: [
                NSAttributedString.Key.foregroundColor : UIColor.white,
                NSAttributedString.Key.font : UIFont.init(name: "Roboto-Regular", size: 18)!]
        )
        tf.backgroundColor = UIColor(red: 196/255.0, green: 196/255.0, blue: 196/255.0, alpha: 0.5)
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
            button.setTitle("Log in", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.init(name: "Roboto-Regular", size: 18)
            button.layer.cornerRadius = 15
            button.backgroundColor = UIColor(red: 240/255.0, green: 150/255.0, blue: 129/255.0, alpha: 1)
            return button
        }()
    
    let forgotPassword: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.init(name: "Roboto-Regular", size: 15)
        label.text = "Forgot password?"
        return label
    }()
    
    let dontHaveAccountPrompt: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.init(name: "Roboto-Regular", size: 15)
        label.text = "Don't have account?"
        return label
    }()
    
    let registerNow: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.init(name: "Roboto-Black", size: 15)
        label.text = "Register now"
        return label
    }()
    
    // MARK: view Method

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        addWelcomeLabel()
        addWelcomeWordLabel()
        setupLoginFields()
        
    }
    
    // MARK: UISetup
    
    
    func addWelcomeLabel() {
        welcomeLabel = UILabel.init()
        welcomeLabel?.textColor = .black
        
        welcomeLabel!.font = UIFont.init(name: "Roboto-Black", size: 36)
        
        welcomeLabel!.text = "Welcome"
        welcomeLabel!.numberOfLines = 1
        
        view.addSubview(welcomeLabel!)
        welcomeLabel!.snp.makeConstraints ({ (make) in
            make.top.equalTo(view).offset(0.142 * view.frame.size.height)
            make.left.equalTo(view).offset(0.1076 * view.frame.size.width)
        })
    }
    
    func addWelcomeWordLabel() {
        welcomeWordLabel = UILabel.init()
        welcomeWordLabel?.textColor = .black
        
        welcomeWordLabel!.font = UIFont.init(name: "Roboto", size: 24)
        
        welcomeWordLabel?.text = "to Valentino"
        
        view.addSubview(welcomeWordLabel!)
        welcomeWordLabel!.snp.makeConstraints ({ (make) in
            make.top.equalTo(view).offset(0.192 * view.frame.size.height)
            make.left.equalTo(view).offset(0.1076 * view.frame.size.width)
            
        })
    }
    
    func setupLoginFields() {
        
        view.addSubview(userNameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signUpButton)
        view.addSubview(forgotPassword)
        view.addSubview(dontHaveAccountPrompt)
        view.addSubview(registerNow)
        
        signUpButton.addTarget(self, action: #selector(loginInAccount), for: .touchUpInside)
        
        let tapRegisterGesture = UITapGestureRecognizer(target: self, action: #selector(tappedRegister(tapGestureRecognizer:)))
        registerNow.addGestureRecognizer(tapRegisterGesture)
        registerNow.isUserInteractionEnabled = true
        
        userNameTextField.snp.makeConstraints ({ (make) in
            make.top.equalTo(view).offset(CGFloat(338 / VLConstants.iphone12Height) * view.frame.size.height)
            make.left.equalTo(view).offset(CGFloat(42 / VLConstants.iphone12Width) * view.frame.size.width)
            make.height.equalTo(57)
            make.width.equalTo(305)
        })
        
        passwordTextField.snp.makeConstraints ({ (make) in
            make.top.equalTo(view).offset(CGFloat(422.0/VLConstants.iphone12Height) * view.frame.size.height)
            make.left.equalTo(view).offset(CGFloat(42.0/VLConstants.iphone12Width) * view.frame.size.width)
            make.height.equalTo(57)
            make.width.equalTo(305)
        })

        signUpButton.snp.makeConstraints ({ (make) in
            make.top.equalTo(view).offset(CGFloat(534.0/VLConstants.iphone12Height) * view.frame.size.height)
            make.left.equalTo(view).offset(CGFloat(42.0/VLConstants.iphone12Width) * view.frame.size.width)
            make.height.equalTo(57)
            make.width.equalTo(305)
        })
        
        forgotPassword.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(CGFloat(491 / VLConstants.iphone12Height) * view.frame.size.height)
            make.left.equalTo(view).offset(CGFloat(227 / VLConstants.iphone12Width) * view.frame.size.width)
        }
        
        dontHaveAccountPrompt.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(CGFloat(617 / VLConstants.iphone12Height) * view.frame.size.height)
            make.left.equalTo(view).offset(CGFloat(86 / VLConstants.iphone12Width) * view.frame.size.width)
        }
        
        registerNow.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(CGFloat(617 / VLConstants.iphone12Height) * view.frame.size.height)
            make.left.equalTo(dontHaveAccountPrompt.snp_right).offset(5)
        }


    }
    
    // MARK: action events
    
    @objc func tappedRegister(tapGestureRecognizer: UITapGestureRecognizer) {
        let signupVC = VLSignUpViewController()
        self.navigationController?.pushViewController(signupVC, animated: true)
    }
    
    @objc func loginInAccount() {
        UIView.animate(withDuration: 0.2,
                       animations: {
                            self.signUpButton.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                       },
                       completion: { _ in
                            UIView.animate(withDuration: 0.2, animations: {
                                self.signUpButton.transform = CGAffineTransform.identity
                            })
                        
                        //check password
                        
                        guard let email = self.userNameTextField.text, !email.isEmpty, let password = self.passwordTextField.text, !password.isEmpty else {
                            print("Missing field data")
                            return
                        }
                        
                        AuthManager.shared.loginUser(email: email, password: password) {success in
                            DispatchQueue.main.async {
                                if success {
                                    self.isEmailVerified()
                                } else {
                                    let alert = UIAlertController (title: "Sign in Failed", message: "we were unable to log you in", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                                    self.present(alert, animated: true, completion: nil)
                                }
                            }
                            
                        }
                        
            
        })
    }
    
    func isEmailVerified() {
        let user = Auth.auth().currentUser
        user?.reload(completion: { (error) in
            if error == nil {
                if user!.isEmailVerified != true {
                    let pendingVC = VLPendingVerificationViewController()
                    self.navigationController!.pushViewController(pendingVC, animated: true)
                    
                    
                } else {
                    let mainVC = VLMainFeedViewController()
                    self.navigationController!.pushViewController(mainVC, animated: true)
                    
                }
                
            }
        })
    }
    
    
    
}
