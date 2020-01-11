//
//  QuizBrain.swift
//  card drop
//
//  Created by UFO Xcode on 2020/1/10.
//  Copyright © 2020 UFO Xcode. All rights reserved.
//



import Foundation
struct QuizBrain {
    var questinNumber = 0
    var score = 0
    let quiz = ["box":"盒子", "cap":"棒球帽", "car":"汽車", "cat":"貓", "cup":"杯子", "dad":"爸爸", "dog":"狗"]
//    let arrayQuiz1 = ["bag","bed","big","box","cap","car","cat","cup","dad","dog","dam","fan","fox","hat","hit","jam","jet","man","map","mat","net","pen","rat","run","six","sun","van"]
    
    let arrayQuiz1 = ["box","cap","car","cat","cup","dad","dog"]
    
    
    
    
    
    mutating func previousQuetion (){
        
        if questinNumber != 0{
            questinNumber -= 1
        }
      
    }
    
    mutating func nextQuestion() {
        if questinNumber + 1 < arrayQuiz1.count{
            questinNumber += 1
           
        } else {
            questinNumber = arrayQuiz1.count - 1                                   // print(" 改為最後一張，不再跑一圈了")
            
        }
    }
    
    
    func getQuestion() -> (eng: String, chinese: String) {
        
        let dicToChinese = String(quiz[arrayQuiz1[questinNumber]] ?? "default" )
        
        return (arrayQuiz1[questinNumber], dicToChinese)
    }
    
    // Menu B  start here
    func get4Answers () -> (w1: String, w2: String, w3: String, w4: String){
        let xx = questinNumber

        var arrayAnswers : [String] = []

        var zArray = arrayQuiz1

        arrayAnswers.append(zArray[xx])
        
        zArray.remove(at: xx)
        print (zArray.description)
        //let shuffledArray = zArray.shuffled()

        zArray.shuffle()
        for i in 1...3 {
          
        arrayAnswers.append(zArray[i])
            
        }
        arrayAnswers.shuffle()
        print (arrayAnswers.description)
        
        return (arrayAnswers[0], arrayAnswers[1], arrayAnswers[2], arrayAnswers[3])

    }
    
    
    
    
}
