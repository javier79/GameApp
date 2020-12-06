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
    let squareNode = SKSpriteNode(imageNamed: "square")
    var texture = [SKTexture]()//create array of type SKTexture
    
    override func didMove(to view: SKView){
        
        self.backgroundColor = SKColor.white
        
        for i in 1...12{//iterates 12 times
            texture.append(SKTexture(imageNamed:"\(i)"))/*append to array all 12 photos,
            the imageNamed fetch the images(creates an image object of each of the images)  */
        }
        
        squareNode.anchorPoint = CGPoint(x: 0, y: 1)/*anchor point set at left top corner of squareNode*/
        squareNode.position = CGPoint(x: 0, y: self.size.height/2)
        squareNode.size = CGSize(width: self.size.width, height:self.size.height/2)
        addChild(squareNode)
        
        catNode.position = CGPoint(x: self.size.width/2, y: self.size.height * 3/4)
        addChild(catNode)
        
        let animateAction = SKAction.animate(with: texture, timePerFrame:0.1)/*animation
         definition, with the files of array texture*/
        catNode.run(SKAction.repeatForever(animateAction))//animation execution
        
        playButton.setScale(0.5)//scaling down size from default size
        playButton.position = CGPoint(x: self.size.width/2, y: self.size.height/4)/*positioning for start button at half the width of scene size and one fourth of the height of the scene or bottom center**/
            addChild(playButton)
    
    }
}
