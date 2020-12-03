//
//  GameScene.swift
//  GameApp
//
//  Created by javier pizarro on 11/30/20.
//  Copyright © 2020 javierpizarro. All rights reserved.
//


import SpriteKit

class GameScene: SKScene{/*object GameScene a subclass of SKScene class*/
    
    let catNode = SKSpriteNode(imageNamed: "cat")//instancing a node image named "cat"
    let bgNode = SKSpriteNode(imageNamed: "bg")
    
    override func didMove(to view: SKView) {//Present object in a SKView
        
        addCat()
        addBackground()
        addBall()
        
    }
    
    func addBall(){
        let ball = SKSpriteNode(imageNamed: "red-ball")
        ball.position = CGPoint(x: self.size.width/2, y:self.size.height)/*point of origin:on x axis half the wide of view and on y axis the height of the view this equals the coordinates for the center top of the view**/
        ball.setScale(0.3)/*due default size was too big, we use this line to shrink the ball*/
        addChild(ball)
        
        let moveAction = SKAction.moveTo(y: 0, duration: 5)/*from positioning in
         top-center of the view to 0 in y axis, for a duration of 5 secs **/
        ball.run(moveAction)//execute action defined on line before
    }
    
    func addCat(){
        catNode.anchorPoint = CGPoint.zero//setting node position(property) on screen
        catNode.setScale(0.8)//setting the size(property)
        catNode.zPosition = 1//z position from nearer to farther(cat in front of background)
        addChild(catNode)//adding node, it is a child of SKScene wich is also a node
    }
    
    func addBackground(){
        bgNode.anchorPoint = CGPoint.zero
        bgNode.zPosition = 0
        addChild(bgNode)//z position from nearer to farther(background farther than cat)
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {/*the parameter passed touches: Set<UITouch> allows an array to store our touch
          with event: UIEvent? allows for the functiolnality to define an interaction
         between an user and the app**/
        
        let touch = touches.first//from collection grab first element
        if let location = touch?.location(in: self){/*returns the coordinate system of the location that was touch. we use IF as this location is
            optional(as per tutorial)**/
            
            catNode.position.x = location.x/*moves catNode position on x axis
             from it's position to the coordinates on x axis stored in location*/
            
        }
    }
}
