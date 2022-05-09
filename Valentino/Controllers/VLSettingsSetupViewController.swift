//
//  VLSettingsSetupViewController.swift
//  Valentino
//
//  Created by Liu John on 2022-02-10.
//

import UIKit
import PhotosUI
import Firebase
import FirebaseStorage
import FirebaseAuth

struct EditProfileFormModel {
    let label: String
    let placeholder: String
    var value: String?
}

final class VLSettingsSetupViewController: UIViewController, PHPickerViewControllerDelegate, UITableViewDataSource {
    
    // MARK: properties
    let email : String
    let password : String
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.register(VLFormTableViewCell.self, forCellReuseIdentifier: VLFormTableViewCell.identifier)
        return tableView
    }()
    
    private var models = [[EditProfileFormModel]]()
    
    
    let promptLabel : UILabel = {
        let label = UILabel()
        label.text = "Set Up Your Profile"
        label.textColor = .black
        label.font = UIFont.init(name: "Roboto-Black", size: 30)
        return label
    }()
    
    let proceedButton: UIButton = {
        let button = UIButton()
        button.setTitle("Proceed", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Roboto-Regular", size: 18)
        button.layer.cornerRadius = 15
        button.backgroundColor = VLConstants.valentinoMainSceneColor
        return button
    }()
    
    let datePicker: UIDatePicker = {
        let dP = UIDatePicker()
        dP.timeZone = NSTimeZone.local
        dP.datePickerMode = .date
        dP.backgroundColor = .white
        return dP
    }()
    
    let dateFormatter: DateFormatter = {
        let dF = DateFormatter()
        dF.dateFormat = "MM/dd/yyyy"
        return dF
    }()
    
    
    let backwardButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "arrow-left.png"), for: .highlighted)
        button.setImage(UIImage(named: "arrow-left.png"), for: .normal)
        
        return button
    }()
    
    
    
    var avatarImageView: UIImageView = {
        let image = UIImage(named: "circleavatar.png")
        let imageView = UIImageView(image: image)
        
        return imageView
    }()
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        tableView.dataSource = self
        view.addSubview(tableView)

        tableView.tableHeaderView = createTableHeaderView()
        configureModels()

        tableView.addSubview(backwardButton)
        backwardButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        
        backwardButton.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(CGFloat(13/VLConstants.iphone12Width) * view.frame.size.width)
            make.top.equalTo(view).offset(CGFloat(64/VLConstants.iphone12Height) * view.frame.size.height)
            make.height.width.equalTo(24)
        }
        
        //setupUI()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        // name, username, website, bio
        let section1Labels = ["Name", "Username", "Bio"]
        var section1 = [EditProfileFormModel]()
        for label in section1Labels {
            let model = EditProfileFormModel(label: label,
                                             placeholder: "Enter \(label)...",
                                             value: nil)
            section1.append(model)
        }
        models.append(section1)
        
        // email, phone, gender
        let section2Labels = ["email", "phone", "gender"]
        var section2 = [EditProfileFormModel]()
        for label in section2Labels {
            let model = EditProfileFormModel(label: label,
                                             placeholder: "Enter \(label)...",
                                             value: nil)
            section2.append(model)
        }
        models.append(section2)
        
    }
    
    func setupUI() {
        view.addSubview(proceedButton)
        view.addSubview(promptLabel)
        view.addSubview(avatarImageView)
        view.addSubview(datePicker)
        
        let tapAvatarGesture = UITapGestureRecognizer(target: self, action: #selector(tappedAvatar(tapGestureRecognizer:)))
        
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tapAvatarGesture)
        
        proceedButton.addTarget(self, action: #selector(proceedToNext), for: .touchUpInside)
        
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        promptLabel.snp.makeConstraints ({ (make) in
            make.top.equalTo(view).offset(CGFloat(106 / VLConstants.iphone12Height) * view.frame.size.height)
            make.left.equalTo(view).offset(CGFloat(32 / VLConstants.iphone12Width) * view.frame.size.width)
        })
        
        
        proceedButton.snp.makeConstraints ({ (make) in
            make.top.equalTo(view).offset(CGFloat(737 / VLConstants.iphone12Height) * view.frame.size.height)
            make.left.equalTo(view).offset(CGFloat(36 / VLConstants.iphone12Width) * view.frame.size.width)
            make.height.equalTo(57)
            make.width.equalTo(305)
        })
        
        avatarImageView.snp.makeConstraints ({ (make) in
            make.top.equalTo(view).offset(CGFloat(164 / VLConstants.iphone12Height) * view.frame.size.height)
            make.left.equalTo(view).offset(CGFloat(82 / VLConstants.iphone12Width) * view.frame.size.width)
            make.height.width.equalTo(227)
        })
    }
    
    // MARK: action events
    
    @objc func tappedAvatar(tapGestureRecognizer: UITapGestureRecognizer) {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.preferredAssetRepresentationMode = .automatic
        configuration.filter = .images
        
        let myPickerController = PHPickerViewController(configuration: configuration)
        myPickerController.delegate = self
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        
    }
    
    @objc func proceedToNext() {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {(result, error) in
            guard error == nil else{
                print(error!.localizedDescription)
                self.navigationController?.popViewController(animated: true)
                return
            }
            
            let currentID = Auth.auth().currentUser?.uid
            
            let storageRef = Storage.storage().reference().child("users/" + currentID! + "/avatar.png")
            let uploadData = self.avatarImageView.image?.pngData()
            storageRef.putData(uploadData!, metadata: nil) { (meta, error) in
                    if (error != nil) {
                        print(error ?? "Error in uploading Image")
                        return
                    } else {
                        print(meta!)
                        print("Success")
                        return
                    }
                }
            
            let db = Firestore.firestore()
            db.collection("users").document(currentID!).setData(["firstname" : "Bobby"])
            
            Auth.auth().currentUser?.sendEmailVerification { error in
              // ...
                print ("Account creation successful")
                let verificationVC = VLPendingVerificationViewController()
                self.navigationController!.pushViewController(verificationVC, animated: true)
            }
            
        })
        
    }
    
    // MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: VLFormTableViewCell.identifier, for: indexPath) as! VLFormTableViewCell
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
    
    private func createTableHeaderView() -> UIView {
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: (view.frame.size.height / 3)).integral)
        
        
        
        let tapAvatarGesture = UITapGestureRecognizer(target: self, action: #selector(tappedAvatar(tapGestureRecognizer:)))
        
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tapAvatarGesture)
                
        header.addSubview(avatarImageView)
        
        let size = CGFloat(200)
        
        avatarImageView.snp.makeConstraints ({ (make) in
            make.top.equalTo(header).offset(CGFloat(100 / VLConstants.iphone12Height) * view.frame.size.height)
            make.left.equalTo(header).offset(CGFloat(82 / VLConstants.iphone12Height) * view.frame.size.width)
            make.height.width.equalTo(size)

        })
        
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = size / 2.0
        
        avatarImageView.layer.borderWidth = 1
        
        avatarImageView.layer.borderColor = UIColor.secondarySystemBackground.cgColor

        return header
    }
    
    
    // MARK: - Action
    
    @objc private func didTapSave() {
        // Save info to database
        self.navigationController?.popViewController(animated: true)

    }
    
    @objc private func didTapCancel() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapChangeProfilePicture() {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Change profile picture", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { _ in
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        
        present(actionSheet, animated: true)
        
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true, completion: nil)
        
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (object, error) in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        print("Selected image: \(image)")
                        self.avatarImageView.image = image
                    }
                }
            })
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

}

extension VLSettingsSetupViewController: VLFormTableViewCellDelegate {
    func formTableViewCell(_ cell: VLFormTableViewCell, didUpdateField updatedModel: EditProfileFormModel) {
        // update the model
        print(updatedModel.value)
    }
    
    
}
