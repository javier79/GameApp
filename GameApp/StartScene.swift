//
//  StartScene.swift
//  GameApp
//
//  Created by javier pizarro on 12/5/20.
//  Copyright © 2020 javierpizarro. All rights reserved.
//

import SpriteKit

class StartScene: SKScene{

    let playButton = SKSpriteNode(imageNamed: "start")
    let catNode = SKSpriteNode(imageNamed: "cat")
    
    override func didMove(to view: SKView){
        
        self.backgroundColor = SKColor.white
        
        catNode.position = CGPoint(x: self.size.width/2, y: self.size.height * 3/4)
        addChild(catNode)
        
        playButton.setScale(0.5)//scaling down size from default size
        playButton.position = CGPoint(x: self.size.width/2, y: self.size.height/4)/*positioning for start button at half the width of scene size and one fourth of the height of the scene or bottom center**/
            addChild(playButton)
    
    }
}
