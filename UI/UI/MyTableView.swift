//
//  MyTableView.swift
//  UI
//
//  Created by 红鹊豆 on 2018/1/31.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit

class MyTableView: UITableView,UITableViewDataSource,UITableViewDelegate {
    
    var dataList = UIFont.familyNames
    
    var editingStyle: UITableViewCellEditingStyle = .delete
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.isEditing = true
        
        self.delegate = self
        self.dataSource = self
        self.tableFooterView = UIView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = self.dataList[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return self.editingStyle
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataList.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .fade)
            tableView.endUpdates()
        } else if editingStyle == .insert {
            
            let value = "\(arc4random())"
            dataList.insert(value, at: indexPath.row)
            tableView.beginUpdates()
            tableView.insertRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            
        } else {
            print("123")
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        return proposedDestinationIndexPath
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
