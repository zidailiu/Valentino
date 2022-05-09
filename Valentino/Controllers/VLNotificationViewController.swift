//
//  VLNotificationViewController.swift
//  Valentino
//
//  Created by Liu John on 2022-03-15.
//

import UIKit

class VLNotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    private let tableView: UITableView = {
       let tableView = UITableView()
       tableView.register(UITableView.self, forCellReuseIdentifier: "cell")
       return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notification"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
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
