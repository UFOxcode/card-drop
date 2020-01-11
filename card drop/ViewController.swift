//
//  ViewController.swift
//  card drop
//
//  Created by UFO Xcode on 2020/1/10.
//  Copyright © 2020 UFO Xcode. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var checkImageView: UIImageView!
    
    var quizBrain = QuizBrain()
    let synthesizer = AVSpeechSynthesizer()
    
    //divisor 是為了 旋轉用
    var divisor : CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reset()
        divisor = (view.frame.width / 2) / 1.21    // 0.61 是角度
    }

    @IBAction func panCard(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        
        //為☑️打勾 設屬性參數
        let xFromCenter = card.center.x - view.center.x
        
        // point 為 差距 ，所以把原來的center加上 point 就 drag 移動了
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        
        // 旋轉 + 縮小
        // min ( a, b) 會自動選小的數字
        let scale = min(75/abs(xFromCenter), 1)
        card.transform = CGAffineTransform(rotationAngle: xFromCenter / divisor).scaledBy(x: scale, y: scale)
        
        
        if xFromCenter > 0 {
            checkImageView.image = #imageLiteral(resourceName: "right")
        } else {
            checkImageView.image = #imageLiteral(resourceName: "wrong")
        }
        
        checkImageView.alpha = abs(xFromCenter) / view.center.x
        
        
        if sender.state == UIGestureRecognizer.State.ended {
           // 超過75 把卡片整個移開
            if card.center.x < 75 {
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x - 200, y: card.center.y)
                    card.alpha = 0
                })
                
                return   // 這個returen 很重要 。。。@@ 因為會回去，不會再往下執行
            } else if card.center.x > (view.frame.width - 75){
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x + 200, y: card.center.y)
                    card.alpha = 0
                })
                return
            }
                
                        
            
        // 回到原來位置, 但如果離手才回原位會比較自然。。所以加上。ended
        UIView.animate(withDuration: 0.2, animations: {
            card.center = self.view.center
//            self.checkImageView.alpha = 0
            self.reset()
        })
        }
    }
    
    @IBAction func reset(_ sender: UIButton) {
       reset()
    }
    
    
    func reset(){
         UIView.animate(withDuration: 0.2, animations: {
                   self.card.center = self.view.center
                   self.card.alpha = 1
                   self.checkImageView.alpha = 0
                   self.card.transform = CGAffineTransform.identity
               })
    }
}

