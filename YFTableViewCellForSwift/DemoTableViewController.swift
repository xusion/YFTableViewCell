//
//  DemoTableViewController.swift
//  YFTableViewCellForSwift
//
//  Created by Dandre on 2017/10/29.
//  Copyright © 2017年 Dandre. All rights reserved.
//

import UIKit

class DemoTableViewController: UITableViewController, YFTableViewCellDelegate {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! DemoTableViewCell
        
        cell.textLabel?.text = "测试数据 - \(indexPath.row)"
        // TODO: 核心代码 1.设置代理    2.设置按钮
        cell.delegate = self
        cell.editButtonArray = [UIButton(title:"置顶", backgroundColor:kYFCellEditButtonMore),
                                UIButton(title:"已读", backgroundColor:kYFCellEditButtonIsRead),
                                UIButton(title:"删除")]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("点击了cell -- \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, didClickedEditButtonAt buttonIndex: Int, At IndexPath: IndexPath) {
        print(#function)
        print("tableview:\(tableView)\nbuttonIndex:\(buttonIndex)\nIndexPath:\(IndexPath)")
    }

}
