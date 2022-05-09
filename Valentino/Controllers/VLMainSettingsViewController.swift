//
//  VLMainSettingsViewController.swift
//  Valentino
//
//  Created by Liu John on 2022-03-15.
//

import SafariServices
import UIKit

struct SettingCellModel {
    let title: String
    let handler: (() -> Void)
}

// View Controller to show user settings
final class VLMainSettingsViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero,
                                    style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var data = [[SettingCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        let section = [
            SettingCellModel(title: "Log out") { [weak self] in
                self?.didTapLogOut()
            }
        ]
        data.append([
                SettingCellModel(title: "Edit Profile"){ [weak self] in
                    self?.didTapEditProfile()
            
            }, SettingCellModel(title: "Terms of Service"){ [weak self] in
                self?.openURL(type: .terms)
            }, SettingCellModel(title: "Privacy Policy"){ [weak self] in
                self?.openURL(type: .privacy)
            }, SettingCellModel(title: "Help / Feedback"){ [weak self] in
                self?.openURL(type: .help)
            }, SettingCellModel(title: "Invite Friends"){ [weak self] in
                self?.didTapInviteFriends()
            }
        ])
        
        data.append(section)
    }
    
    private func didTapEditProfile() {
        let vc = VLSettingsSetupViewController(email: "", password: "")
        vc.title = "Edit Profile"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    private func didTapInviteFriends() {
        // Show share sheet to invite friends
    }
    
    enum SettingsURLType {
        case terms, privacy, help
    }
    
    private func openURL(type: SettingsURLType) {
        let urlString: String
        switch type {
        case .terms: urlString = "https://help.instagram.com/581066165581870/?helpref=uf_share"
        case .privacy: urlString = "https://help.instagram.com/519522125107875/?helpref=uf_share"
        case .help: urlString = ""
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let vc = SFSafariViewController(url:url)
        present(vc, animated: true)
        
        
        
    }

    
    private func didTapLogOut() {
        
        
        AuthManager.shared.logOut { (success) in
            DispatchQueue.main.async {
                if success {
                    self.navigationController?.popToRootViewController(animated: false)
                } else {
                    
                }
            }
            
        }
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

extension VLMainSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
    
    
    
}
