//
//  FriendVC.swift
//  Friend
//
//  Created by 玮 李 on 2017/10/10.
//  Copyright © 2017年 玮 李. All rights reserved.
//

import UIKit

class FriendVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let label = SKFFPSLabel()
        label.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: label)
        tableView.mj_header = TMHeader(refreshingTarget: self, refreshingAction: #selector(loadNewData))
       tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell1")
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
        return 50
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        cell.textLabel?.text =  String(indexPath.row)
     
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
