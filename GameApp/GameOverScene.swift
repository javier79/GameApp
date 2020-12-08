//
//  GameOverScene.swift
//  GameApp
//
//  Created by javier pizarro on 12/7/20.
//  Copyright © 2020 javierpizarro. All rights reserved.
//

import SpriteKit

class GameOverScene : SKScene{
    
    let playButton = SKSpriteNode(imageNamed: "start")
    let gameOverLabel = SKLabelNode(text: "Game Over")
    
    override func didMove(to view: SKView) {
        /*properties and execution of a Game Over Label in the middle of view**/
        self.backgroundColor = .orange
        
        gameOverLabel.fontColor = SKColor.black
        gameOverLabel.fontName =  "helvetica"
        gameOverLabel.fontSize = 40
        gameOverLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2 )
        addChild(gameOverLabel)
        
        
        
        playButton.setScale(0.5)//scaling down size from default size
        playButton.position = CGPoint(x: self.size.width/2, y:self.size.height/4)/*positioning for start button at half the width of scene size and one fourth of the height of the scene or bottom center**/

        addChild(playButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         
         let touch = touches.first//fetch the first element on array
         if let location = touch?.location(in: self){//if a touch register on StartScene
             
             if atPoint(location) == playButton{/*if coordinates on location
                  match that of start button**/
                 
                 let gameScene = GameScene(size: self.size)/*create instantiate GameScene with the same size as StartScene**/
                 let transition = SKTransition.crossFade(withDuration: 1.5)//transition definition
                 self.view?.presentScene(gameScene, transition: transition)/*execute change the view to gameScene and a transition**/
             }
                 
         }
     }
}
