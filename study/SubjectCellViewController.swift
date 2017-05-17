//
//  SubjectCellViewController.swift
//  study
//
//  Created by 西林咲音 on 2017/05/04.
//  Copyright © 2017年 西林咲音. All rights reserved.
//

import UIKit

class SubjectCellViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    
    @IBOutlet weak var noneLabel: UILabel!
    let userDefaults = UserDefaults.standard
    var subjectArray:[String] = []
    var colorArray:[UIColor] = []
    var dataArray:[Data] = []
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        self.tableView.register(UINib(nibName: "CustomSubjectCell", bundle: nil), forCellReuseIdentifier: "customCell")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isEditing = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        subjectArray = userDefaults.array(forKey: "Subject") as? [String] ?? []
        dataArray = userDefaults.array(forKey: "Color") as? [Data] ?? []
        print(dataArray)
        for obj in dataArray {
            let color: UIColor = NSKeyedUnarchiver.unarchiveObject(with: obj) as! UIColor
            colorArray.append(color)
        }
        print("しのき\(colorArray)")
        print(subjectArray)
        
        if (userDefaults.object(forKey: "Subject") != nil) {
            noneLabel.isHidden = true
        } else {
            noneLabel.isHidden = false
        }
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let targetTitle = subjectArray[sourceIndexPath.row]
        let targetColor = colorArray[sourceIndexPath.row]
        if let index = subjectArray.index(of: targetTitle) {
            subjectArray.remove(at: index)
            subjectArray.insert(targetTitle, at: destinationIndexPath.row)
            colorArray.remove(at: index)
            colorArray.insert(targetColor, at: destinationIndexPath.row)
        }
        userDefaults.set(subjectArray, forKey: "Subject")
        print(subjectArray)
        userDefaults.set(colorArray, forKey: "Color")
        print(colorArray)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            subjectArray.remove(at: indexPath.row)
            colorArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
    }
    
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomSubjectCell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomSubjectCell
        cell.subjectLabel?.text = subjectArray[indexPath.row]
        cell.colorView?.backgroundColor = colorArray[indexPath.row]
        return cell
    }

    @IBAction func backButton(_ sender: Any) {
        _  = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func plusButton(_ sender: Any) {
        performSegue(withIdentifier: "toNext", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}