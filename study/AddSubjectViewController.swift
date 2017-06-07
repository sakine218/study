
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
    @IBOutlet weak var deletButton: UIButton!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    var text: String = ""
    let userDefaults = UserDefaults.standard
    var subjectArray:[String] = []
    var dataArray:[Data] = []
    var redValue: CGFloat = 0
    var greenValue: CGFloat = 0
    var blueValue: CGFloat = 0
    var indexPath: Int!
    var colorArray: [UIColor] = []
    var color: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        deletButton.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        subjectArray = userDefaults.array(forKey: "Subject") as? [String] ?? []
        dataArray = userDefaults.array(forKey: "Color") as? [Data] ?? []
        for obj in dataArray {
            let color: UIColor = NSKeyedUnarchiver.unarchiveObject(with: obj) as! UIColor
            colorArray.append(color)
        }
        print(subjectArray)
        print(dataArray)
        if indexPath != nil {
            textField.text = subjectArray[indexPath]
            deletButton.isHidden = false
            colorView.backgroundColor = colorArray[indexPath]
            color = colorArray[indexPath]
            redValue = convertToRGB(color).red * 255
            greenValue = convertToRGB(color).green * 255
            blueValue = convertToRGB(color).blue * 255
            redLabel.text = "".appendingFormat("%.0f", redValue)
            greenLabel.text = "".appendingFormat("%.0f", greenValue)
            blueLabel.text = "".appendingFormat("%.0f", blueValue)
            redSlider.value = Float(redValue)
            greenSlider.value = Float(greenValue)
            blueSlider.value = Float(blueValue)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func convertToRGB(_ color: UIColor) -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        
        let components = color.cgColor.components! // UIColorをCGColorに変換し、RGBとAlphaがそれぞれCGFloatで配列として取得できる
        return (red: components[0], green: components[1], blue: components[2], alpha: components[3])
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
