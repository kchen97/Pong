//
//  MenuVC.swift
//  Pong
//
//  Created by Korman Chen on 10/9/17.
//  Copyright © 2017 Korman Chen. All rights reserved.
//

import Foundation
import UIKit

enum gameType {
    case easy
    case medium
    case hard
}

class MenuVC: UIViewController {
    
    @IBAction func Easy(_ sender: Any) {
        moveToGame(game: .easy)
    }
    
    
    @IBAction func Medium(_ sender: Any) {
        moveToGame(game: .medium)
    }
    
    
    @IBAction func Hard(_ sender: Any) {
        moveToGame(game: .hard)
    }
    
    func moveToGame(game: gameType) {
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        
        currentGameType = game
        
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
}
