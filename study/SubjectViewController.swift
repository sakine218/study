//
//  SubjectViewController.swift
//  study
//
//  Created by 西林咲音 on 2017/05/03.
//  Copyright © 2017年 西林咲音. All rights reserved.
//

import UIKit

class SubjectViewController: UIViewController {
    
    @IBOutlet var dateLabel: UILabel!
    
    let weekArray: [String] = ["","日","月","火","水","木","金","土"]
    //weekArrayで取得する数字は1~7だけどArrayの最初は0から始まるので最初は空白にしとく！

    
    override func viewDidLoad() {
        super.viewDidLoad()        // Do any additional setup after loading the view, typically from a nib.
        hoge()
        //日付を表示するメソッドの呼び出し
    }
    
    func hoge() {
        let monthComp = Calendar.Component.month
        let month = NSCalendar.current.component(monthComp, from: NSDate() as Date)
        let dayComp = Calendar.Component.day
        let day = NSCalendar.current.component(dayComp, from: NSDate() as Date)
        let weekComp = Calendar.Component.weekday
        let week = NSCalendar.current.component(weekComp, from: NSDate() as Date)
        let weekText: String = weekArray[week]
        //weekで取得したInt型の数字がそのままArrayの番号を取るのに使えるので簡単！
        dateLabel.text = String(month) + "月" + String(day) + "日" + "(" + weekText + ")"
        //Int型のはString型にキャストして+でドッキング
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
