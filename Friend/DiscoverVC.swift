//
//  DiscoverVC.swift
//  Friend
//
//  Created by 玮 李 on 2017/10/10.
//  Copyright © 2017年 玮 李. All rights reserved.
//

import UIKit
import MJRefresh
class DiscoverVC: UITableViewController {
    
    lazy var friendVc:FriendVC = {
        let vc = FriendVC()
        return vc
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.mj_header = JDHeader(refreshingTarget: self, refreshingAction: #selector(loadNewData))
        
        
    }
    
    
    @objc func loadNewData() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {[weak self] in
            self?.tableView.mj_header.endRefreshing()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "朋友圈"
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(friendVc, animated: true)
    }
    
}
