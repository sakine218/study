//
//  SettingViewController.swift
//  study
//
//  Created by 西林咲音 on 2017/05/03.
//  Copyright © 2017年 西林咲音. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    let cellArray:[String] = ["教科","バージョン"]
    
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray.count
    }
   
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = cellArray[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    func tableView(_ table: UITableView, didSelectRowAt indexPath:IndexPath) {
        print(cellArray[indexPath.row])
       if indexPath.row == 0 {
        performSegue(withIdentifier: "nextVC", sender: nil)
      }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
