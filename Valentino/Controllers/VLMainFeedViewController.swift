//
//  VLMainFeedViewController.swift
//  Valentino
//
//  Created by Liu John on 2022-02-10.
//

import UIKit


let matchedUserFoundNotificationKey = "matchedUserFoundNotificationKey"
let matchedUserDislikeNotificationKey = "matchedUserDislikeNotificationKey"

class VLMainFeedViewController: UIViewController {
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.register(VLFeedPostTableViewCell.self, forCellReuseIdentifier:VLFeedPostTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
       return tableView
    }()
    
    let settingEntrance: UIImageView = {
        let settingImageView = UIImageView(image: UIImage(systemName: "person.fill"))
        settingImageView.tintColor = .black
        
        return settingImageView
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
    
    let matchCoverView = VLMatchCoverView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        configureUISetup()
        NotificationCenter.default.addObserver(self, selector: #selector(matchUserFound(_:)), name: NSNotification.Name(rawValue: matchedUserFoundNotificationKey), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(matchUserDislike(_:)), name: NSNotification.Name(rawValue: matchedUserDislikeNotificationKey), object: nil)
    }
    

    private func configureUISetup() {
        view.addSubview(settingEntrance)
        settingEntrance.snp.makeConstraints ({ (make) in
            make.top.equalTo(view).offset(0.068 * view.frame.size.height)
            make.left.equalTo(view).offset(0.058 * view.frame.size.width)
            make.height.width.equalTo(24)
        })
        let tapSettingGesture = UITapGestureRecognizer(target: self, action: #selector(tappedSetting(tapGestureRecognizer:)))
        
        settingEntrance.isUserInteractionEnabled = true

        settingEntrance.addGestureRecognizer(tapSettingGesture)
        
        view.addSubview(tableView)
        view.addSubview(matchCoverView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(settingEntrance.snp_bottom).offset(38)
            make.height.equalTo(0.808 * view.frame.size.height)
            make.left.equalTo(0.058 * view.frame.size.width)
            make.right.equalTo(-0.058 * view.frame.size.width)
            make.width.equalTo(view.frame.size.width)
        }
        tableView.isHidden = true
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        matchCoverView.snp.makeConstraints { (make) in
            make.top.equalTo(settingEntrance.snp_bottom).offset(38)
            make.height.equalTo(0.808 * view.frame.size.height)
            make.left.equalTo(0.058 * view.frame.size.width)
            make.right.equalTo(-0.058 * view.frame.size.width)
            make.width.equalTo(view.frame.size.width)
        }
    }
    
    @objc func tappedSetting(tapGestureRecognizer: UITapGestureRecognizer) {
        let vc = VLMainSettingsViewController()
        vc.title = "Settings"
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func matchUserFound(_ notification: NSNotification) {
        matchCoverView.isHidden = true
        tableView.isHidden = false
        
    }
    
    @objc func matchUserDislike(_ notification: NSNotification) {
        matchCoverView.isHidden = false
        tableView.isHidden = true
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

extension VLMainFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0.808 * view.frame.size.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VLFeedPostTableViewCell.identifier, for: indexPath) as! VLFeedPostTableViewCell
        
        return cell
    }
    
    
}
