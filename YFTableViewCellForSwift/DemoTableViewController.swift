//
//  DemoTableViewController.swift
//  YFTableViewCellForSwift
//
//  Created by Dandre on 2017/10/29.
//  Copyright © 2017年 Dandre. All rights reserved.
//

import UIKit


/// 示例代码
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
        
         // TODO: 新增代码 xusion
        //开启【删除】按钮点击后提示【确认删除】按钮：cell.confirmButton = UIButton(title:"确认删除")
        cell.confirmButton = UIButton(title:"确认删除", backgroundColor:kYFCellEditButtonDelele)
        //设置点击哪个按钮才会提示【确认删除】按钮：cell.confirmButtonIndex = 0 (index为上面editButtonArray索引值)
        cell.confirmButtonIndex = 2

        return cell
    }
    
    // MARK: YFTableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("点击了cell -- \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, didClickedEditButtonAt buttonIndex: Int, At IndexPath: IndexPath) {
        print(#function)
        print("tableview:\(tableView)\nbuttonIndex:\(buttonIndex)\nIndexPath:\(IndexPath)")
    }

}
