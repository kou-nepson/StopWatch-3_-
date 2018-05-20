//
//  ViewController.swift
//  StopWatch
//
//  Created by 杉山航 on 2016/12/02.
//  Copyright © 2016年 杉山航. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, UITextFieldDelegate {

    @IBOutlet var label: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var handechan: UILabel!
    @IBOutlet var handechan2: UILabel!
    @IBOutlet var fight: UILabel!
    @IBOutlet var chama: UIImageView!
    @IBOutlet weak var plusname: UITextField!
    @IBOutlet weak var minusname: UITextField!
    
    var audioPlayer:AVAudioPlayer!
    var audioPlayer2:AVAudioPlayer!
    var audioPlayer3:AVAudioPlayer!
    
    let saveData: UserDefaults = UserDefaults.standard//スコアを保存する場所を作ります
    var sukoaname1: String = ""
    var sukoaname2: String = ""
    var sukoaname3: String = ""
    var minussukoaname1: String = ""
    var minussukoaname2: String = ""
    var minussukoaname3: String = ""
    var sukoa: Int = 0
    var sukoa2: Int = 0
    var sukoa3: Int = 0
    var mainasusukoa: Int = 0
    var mainasusukoa2: Int = 0
    var mainasusukoa3: Int = 0
    var number: Int = 0
    var count: Float = 10.0
    var timer: Timer = Timer()
    
    
    
    var chaosArray:[String] = ["パンと恋する.png","怪人　激ヤバ.jpg","this is Nepson!.png","怪人（背景なし）.jpg","足を食べる.png"]
    
    //MARK: キーボードが出ている状態で、キーボード以外をタップしたらキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //非表示にする。
        if(plusname.isFirstResponder){
            plusname.resignFirstResponder()
        }
        if(minusname.isFirstResponder){
            minusname.resignFirstResponder()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 再生する audio ファイルのパスを取得
        let sound_data = NSURL(fileURLWithPath: Bundle.main.path(forResource: "プラス音声", ofType: "m4a")!)
        let sound_data2 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "マイナス音声", ofType: "m4a")!)
        let sound_data3 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "必殺", ofType: "m4a")!)
        

        // auido を再生するプレイヤーを作成する
        var audioError:NSError?
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: sound_data as URL)
            audioPlayer2 = try AVAudioPlayer(contentsOf: sound_data2 as URL)
            audioPlayer3 = try AVAudioPlayer(contentsOf: sound_data3 as URL)
            
        } catch let error as NSError {
            audioError = error
            audioPlayer = nil
        }
        
        // エラーが起きたとき
        if let error = audioError {
            print("Error \(error.localizedDescription)")
        }
        
        audioPlayer.delegate = self
        audioPlayer2.delegate = self
        audioPlayer3.delegate = self
        
        audioPlayer.prepareToPlay()
        audioPlayer2.prepareToPlay()
        audioPlayer3.prepareToPlay()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func start() {
        if !timer.isValid {
            //タイマーが動作していなかったら動かす
            timer = Timer.scheduledTimer(
                timeInterval: 0.01,
                target: self,
                selector: #selector(self.up),
                userInfo: nil,
                repeats: true
            )
        }
        if count <= 0 {
            timer.invalidate()
            count = 10
        }
        if plusname.text == String("") || minusname.text == String("") {
            if timer.isValid {
                //タイマーが動作していたら停止する
                timer.invalidate()
            }
            let alert:UIAlertController = UIAlertController(title: "プレイヤー名を入力してください", message: "", preferredStyle: .alert)
            alert.addAction(
                UIAlertAction(
                    title: "OK",
                    style:.default,
                    handler: {action in
                        //ボタンが押された時の動作
                        NSLog("OKが押された")
                }
                )
            )
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func stop(){
        if timer.isValid {
            //タイマーが動作していたら停止する
            timer.invalidate()
        }
    }
    @IBAction func plus() {
        audioPlayer.play()
        number = number + 1
        label2.text = String(number)
        self.hande()
    }
    @IBAction func minus() {
        
        audioPlayer2.play()
        number = number - 1
        label2.text = String(number)
        self.hande()
    }
    @IBAction func Clear(){
        if timer.isValid == true{
            timer.invalidate()
        }
        count = 10
        label.text = String(count)
        number = 0
        label2.text = String(number)
        handechan2.text = String("")
        handechan.text = String("")
        label2.textColor = UIColor.white
        fight.text = String("")
        chama.image = nil
    }
    @IBAction func arawazapurasugawa(){
        if number <= -10 {
            number = number / 2
            label2.text = String(number)
            audioPlayer3.play()
        }
        self.hande()
    }
    @IBAction func arawazamainasugawa(){
        if number >= 10 {
            number = number / 2
            label2.text = String(number)
            audioPlayer3.play()
        }
        self.hande()
    }
    func up() {
        //countを0.01（時間経過分）足す
        count = count - 0.01
        //ラベルに小数点以下2桁まで表示
        label.text = String(format: "%.2f", count)
        if count <= 10.0 && count >= 9.70 {
            fight.text = String("FIGHT‼︎")
        }else {
            fight.text = String("")
        }
        chama.image = nil
        if count <= 0 {
            if timer.isValid {
                //タイマーが動作していたら停止する
                timer.invalidate()
            }
        }
        if count <= 0 && number >= 1 {
            let alert:UIAlertController = UIAlertController(title: "勝負あり‼︎", message: ""+plusname.text!+"の勝ち‼︎", preferredStyle: .alert)
            alert.addAction(
                UIAlertAction(
                            title: "OK",
                            style:.default,
                            handler: {action in
                                //ボタンが押された時の動作
                                NSLog("OKが押された")
                                self.input()
                                }
                            )
                )
            present(alert, animated: true, completion: nil)
        }else if count <= 0 && number <= -1 {
            let alert:UIAlertController = UIAlertController(title: "勝負あり‼︎", message: ""+minusname.text!+"の勝ち‼︎", preferredStyle: .alert)
            alert.addAction(
                UIAlertAction(
                    title: "OK",
                    style:.default,
                    handler: {action in
                        //ボタンが押された時の動作
                        NSLog("OKが押された")
                        self.input()
                }
                )
            )
            present(alert, animated: true, completion: nil)
        }else if count <= 0 && number == 0 {
            let alert:UIAlertController = UIAlertController(title: "そこまで‼︎", message: "引き分け‼︎", preferredStyle: .alert)
            alert.addAction(
                UIAlertAction(
                    title: "OK",
                    style:.default,
                    handler: {action in
                        //ボタンが押された時の動作
                        NSLog("OKが押された")
                }
                )
            )
            present(alert, animated: true, completion: nil)
        }
        self.chama10()
        self.chama20()
        self.chama30()
        self.chama40()
        self.chama50()
    }
    func collarchange() {
        if number > 0{
            label2.textColor = UIColor.red
        }else if number < 0{
            label2.textColor = UIColor.blue
        }else {
            label2.textColor = UIColor.white
        }
    }
    func hande() {
        if number >= 10 {
            handechan.text = String("÷")
        }else if number <= -10 {
            handechan2.text = String("÷")
        }else {
            handechan.text = String("")
            handechan2.text = String("")
        }
    }


    func input() {
        if number > 0 {
            sukoa = saveData.integer(forKey: "sukoa")
            sukoa2 = saveData.integer(forKey: "sukoa2")
            sukoa3 = saveData.integer(forKey: "sukoa3")
            
            
            if number > sukoa {
                sukoa3 = sukoa2
                sukoa2 = sukoa
                sukoa = number
                sukoaname3 = sukoaname2
                sukoaname2 = sukoaname1
                sukoaname1 = plusname.text!
            }else if number < sukoa && number > sukoa2 {
                sukoa3 = sukoa2
                sukoa2 = number
                sukoaname3 = sukoaname2
                sukoaname2 = plusname.text!
            }else if number < sukoa2 && number > sukoa3 {
                sukoa3 = number
                sukoaname3 = plusname.text!
            }
            
            saveData.set(sukoa, forKey: "sukoa")
            saveData.set(sukoa2, forKey: "sukoa2")
            saveData.set(sukoa3, forKey: "sukoa3")
            saveData.set(sukoaname1, forKey: "sukoaname1")
            saveData.set(sukoaname2, forKey: "sukoaname2")
            saveData.set(sukoaname3, forKey: "sukoaname3")

        }else if number < 0 {
            
            mainasusukoa = saveData.integer(forKey: "mainasusukoa")
            mainasusukoa2 = saveData.integer(forKey: "mainasusukoa2")
            mainasusukoa3 = saveData.integer(forKey: "mainasusukoa3")
            
            if number < mainasusukoa {
                mainasusukoa3 = mainasusukoa2
                mainasusukoa2 = mainasusukoa
                mainasusukoa = number
                minussukoaname3 = minussukoaname2
                minussukoaname2 = minussukoaname1
                minussukoaname1 = minusname.text!
            }else if number > mainasusukoa && number < mainasusukoa2 {
                mainasusukoa3 = mainasusukoa2
                mainasusukoa2 = number
                minussukoaname3 = minussukoaname2
                minussukoaname2 = minusname.text!
            }else if number > mainasusukoa2 && number < mainasusukoa3 {
                mainasusukoa3 = number
                minussukoaname3 = minusname.text!
            }
            saveData.set(mainasusukoa, forKey: "mainasusukoa")
            saveData.set(mainasusukoa2, forKey: "mainasusukoa2")
            saveData.set(mainasusukoa3, forKey: "mainasusukoa3")
            saveData.set(minussukoaname1, forKey: "minussukoaname1")
            saveData.set(minussukoaname2, forKey: "minussukoaname2")
            saveData.set(minussukoaname3, forKey: "minussukoaname3")
        }
    }
    
    func chama10() {
        if count <= 10 && count >= 9.0 {
            chama.image = UIImage(named:chaosArray[0])
        }
    }
    func chama20() {
        if count <= 9.0 && count >= 8.0 {
            chama.image = UIImage(named:chaosArray[1])
        }
    }
    func chama30() {
        if count <= 8.0 && count >= 7.0 {
            chama.image = UIImage(named:chaosArray[2])
        }
    }
    func chama40() {
        if count <= 7.0 && count >= 6.0 {
            chama.image = UIImage(named:chaosArray[3])
        }
    }
    func chama50() {
        if count <= 6.0 && count >= 5.0 {
            chama.image = UIImage(named:chaosArray[4])
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
