//
//  RankingViewController.swift
//  StopWatch
//
//  Created by 杉山航 on 2017/02/16.
//  Copyright © 2017年 杉山航. All rights reserved.
//

import UIKit

class RankingViewController: UIViewController {

    let saveData: UserDefaults = UserDefaults.standard
    
    @IBOutlet var puras1: UILabel!
    @IBOutlet var puras2: UILabel!
    @IBOutlet var puras3: UILabel!
    @IBOutlet var mainasu: UILabel!
    @IBOutlet var mainasu2: UILabel!
    @IBOutlet var mainasu3: UILabel!
    @IBOutlet var minusname1: UILabel!
    @IBOutlet var minusname2: UILabel!
    @IBOutlet var minusname3: UILabel!
    @IBOutlet var plusname1: UILabel!
    @IBOutlet var plusname2: UILabel!
    @IBOutlet var plusname3: UILabel!
    /*
    var sukoaname1: String = ""
    var sukoaname2: String = ""
    var sukoaname3: String = ""
    var minussukoaname1: String = ""
    var minussukoaname2: String = ""
    var minussukoaname3: String = ""
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if plusname1.text == nil || minusname1.text == nil{
            plusname1.text = ""
            minusname1.text = ""
        }
        
        puras1.text = String(saveData.integer(forKey: "sukoa") )
        puras2.text = String(saveData.integer(forKey: "sukoa2") )
        puras3.text = String(saveData.integer(forKey: "sukoa3") )
        
        mainasu.text = String(saveData.integer(forKey: "mainasusukoa") )
        mainasu2.text = String(saveData.integer(forKey: "mainasusukoa2") )
        mainasu3.text = String(saveData.integer(forKey: "mainasusukoa3") )
        
        plusname1.text = saveData.object(forKey: "sukoaname1") as? String
        plusname2.text = saveData.object(forKey: "sukoaname2") as? String
        plusname3.text = saveData.object(forKey: "sukoaname3") as? String
        
        minusname1.text = saveData.object(forKey: "minussukoaname1") as? String
        minusname2.text = saveData.object(forKey: "minussukoaname2") as? String
        minusname3.text = saveData.object(forKey: "minussukoaname3") as? String
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toTop(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func risetto() {
    let alert:UIAlertController = UIAlertController(title: "ランキングをリセットしますか？", message: "OKを押すとリセットされます", preferredStyle: .alert)
                alert.addAction(
                        UIAlertAction(
                            title: "OK",
                            style:.default,
                            handler: {action in
                                //ボタンが押された時の動作
                                NSLog("OKが押された")
                                self.puras1.text = String("--")
                                self.puras2.text = String("--")
                                self.puras3.text = String("--")
                                self.mainasu.text = String("--")
                                self.mainasu2.text = String("--")
                                self.mainasu3.text = String("--")
                                self.plusname1.text = String("--")
                                self.plusname2.text = String("--")
                                self.plusname3.text = String("--")
                                self.minusname1.text = String("--")
                                self.minusname2.text = String("--")
                                self.minusname3.text = String("--")
                                self.saveData.set(nil, forKey: "mainasusukoa")
                                self.saveData.set(nil, forKey: "mainasusukoa2")
                                self.saveData.set(nil, forKey: "mainasusukoa3")
                                self.saveData.set(nil, forKey: "sukoa")
                                self.saveData.set(nil, forKey: "sukoa2")
                                self.saveData.set(nil, forKey: "sukoa3")
                                self.saveData.set(nil, forKey: "sukoaname1")
                                self.saveData.set(nil, forKey: "sukoaname2")
                                self.saveData.set(nil, forKey: "sukoaname3")
                                self.saveData.set(nil, forKey: "minussukoaname1")
                                self.saveData.set(nil, forKey: "minussukoaname2")
                                self.saveData.set(nil, forKey: "minussukoaname3")
                        }
                    )
        )
        alert.addAction(
            UIAlertAction(
                title: "キャンセル",
                style:.default,
                handler: {action in
                    //ボタンが押された時の動作
                    NSLog("キャンセルが押された")
            }
            )
        )
        present(alert, animated: true, completion: nil)

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
