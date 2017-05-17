//
//  TimerViewController.swift
//  study
//
//  Created by 西林咲音 on 2017/05/03.
//  Copyright © 2017年 西林咲音. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    weak var timer: Timer!
    @IBOutlet weak var timeLabel: UILabel!
    var subjectPicker: UIPickerView!
    let userDefaults = UserDefaults.standard
    var subjectArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(subjectArray)
        subjectPicker = UIPickerView()
        // Do any additional setup after loading the view, typically from a nib.
        // サイズを指定する.
        subjectPicker.frame = CGRect(x: 0,y: 250,width: self.view.bounds.width, height: 180)
        // Delegateを設定する.
        subjectPicker.delegate = self
        // DataSourceを設定する.
        subjectPicker.dataSource = self
        // Viewに追加する.
        self.view.addSubview(subjectPicker)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        subjectArray = userDefaults.array(forKey: "Subject") as? [String] ?? []
        subjectPicker.reloadAllComponents()
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /*
     pickerに表示する行数を返すデータソースメソッド.
     (実装必須)
     */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return subjectArray.count
    }
    
    /*
     pickerに表示する値を返すデリゲートメソッド.
     */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return subjectArray[row] as String
    }
    
    /*
     pickerが選択された際に呼ばれるデリゲートメソッド.
     */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("row: \(row)")
        print("value: \(subjectArray[row])")
    }
    
    @IBAction func eventButton(_ sender: Any) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
