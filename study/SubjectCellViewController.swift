//
//  SubjectCellViewController.swift
//  study
//
//  Created by 西林咲音 on 2017/05/04.
//  Copyright © 2017年 西林咲音. All rights reserved.
//

import UIKit

class SubjectCellViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate  {
    
    
    @IBOutlet weak var noneLabel: UILabel!
    let userDefaults = UserDefaults.standard
    var subjectArray:[String] = []
    var colorArray:[UIColor] = []
    var dataArray:[Data] = []
    var pushNumber: Int = 0
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        self.tableView.register(UINib(nibName: "CustomSubjectCell", bundle: nil), forCellReuseIdentifier: "customCell")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isEditing = true
        // UILongPressGestureRecognizer宣言
        let longPressRecognizer = UILongPressGestureRecognizer()
        longPressRecognizer.addTarget(self, action: #selector(SubjectCellViewController.cellLongPressed(recognizer:)))
        // UIGestureRecognizerDelegateを設定するのをお忘れなく
        longPressRecognizer.delegate = self
        //tableViewにrecognizerを設定
        tableView.addGestureRecognizer(longPressRecognizer)
        }
    
    override func viewWillAppear(_ animated: Bool) {
        colorArray = []
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
    
    func cellLongPressed(recognizer: UILongPressGestureRecognizer) {
        // 押された位置でcellのPathを取得
        let point = recognizer.location(in: tableView)
        let indexPath = tableView.indexPathForRow(at: point)
        if indexPath == nil {
        } else if recognizer.state == UIGestureRecognizerState.began  {
            // 長押しされた場合の処理
            print("長押しされたcellのindexPath:\(String(describing: indexPath!.row))")
            pushNumber = indexPath!.row
            performSegue(withIdentifier: "toNext", sender: indexPath)
        }
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
        dataArray.removeAll(keepingCapacity: true)
        for color in colorArray {
            let data: Data = NSKeyedArchiver.archivedData(withRootObject: color)
            dataArray.append(data)
        }
        userDefaults.set(subjectArray, forKey: "Subject")
        userDefaults.set(dataArray, forKey: "Color")
        print(subjectArray)
        print(colorArray)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender != nil {
            let AddSubjectViewController = segue.destination as! AddSubjectViewController
            AddSubjectViewController.indexPath = pushNumber
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
            subjectArray.remove(at: indexPath.row)
            colorArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "削除") { (action, index) -> Void in
            self.subjectArray.remove(at: indexPath.row)
            self.colorArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        deleteButton.backgroundColor = UIColor.red
        
        return [deleteButton]
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
