
//
//  AddSubjectViewController.swift
//  study
//
//  Created by 西林咲音 on 2017/05/04.
//  Copyright © 2017年 西林咲音. All rights reserved.
//

import UIKit

class AddSubjectViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textField: UITextField!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    var text: String = ""
    let userDefaults = UserDefaults.standard
    var subjectArray:[String] = []
    var dataArray:[Data] = []
    var redValue: CGFloat = 0
    var greenValue: CGFloat = 0
    var blueValue: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        subjectArray = userDefaults.array(forKey: "Subject") as? [String] ?? []
        dataArray = userDefaults.array(forKey: "Color") as? [Data] ?? []
        print(subjectArray)
        print(dataArray)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        // キーボードを閉じる
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        textField.resignFirstResponder()
    }
    
    @IBAction func doneButton(_ sender: Any) {
        textField.resignFirstResponder()
        if textField.text == "" {
            let alert = UIAlertController(
                title: "エラー",
                message: "文字を入力してください",
                preferredStyle: .alert)
            // アラートにボタンをつける
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            // アラート表示
            self.present(alert, animated: true, completion: nil)
        } else{
            let data: Data = NSKeyedArchiver.archivedData(withRootObject: colorView.backgroundColor!)
            dataArray.append(data)
            userDefaults.set(dataArray, forKey: "Color")
            print(dataArray)
            text = textField.text!
            print(text)
            subjectArray.append(text)
            userDefaults.set(subjectArray, forKey: "Subject")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func redSlider(_ sender: UISlider) {
        sender.value.round()
        let redText: String = "".appendingFormat("%.0f", sender.value)
        redLabel.text = redText
        redValue = CGFloat(sender.value / 255)
        colorView.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha:1.0)
    }
    
    @IBAction func greenSlider(_ sender: UISlider) {
        sender.value.round()
        let greenText: String = "".appendingFormat("%.0f", sender.value)
        greenLabel.text = greenText
        greenValue = CGFloat(sender.value / 255)
        colorView.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha:1.0)
    }
    
    @IBAction func blueSlider(_ sender: UISlider) {
        sender.value.round()
        let blueText: String = "".appendingFormat("%.0f", sender.value)
        blueLabel.text = blueText
        blueValue = CGFloat(sender.value / 255)
        colorView.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha:1.0)
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
