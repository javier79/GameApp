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
    var timer = Timer()/*a timer that fires after a certain time interval has elapsed, sending a specified message to a target object**/
    
    override func didMove(to view: SKView) {//Present object in a SKView
        //execute addBall() every two seconds on GameScene(self)
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(addBall), userInfo: nil, repeats: true)//nil means we are not passing user info.
        addCat()
        addBackground()
        
        
    }
    
    @objc func addBall(){//@objc is cause of #selector function above
        
        let randomX = arc4random_uniform(UInt32(self.size.width))/*provides a random number that ranges from 0 to the widest value of the view on x axis(upper bound)**/
        
        let ball = SKSpriteNode(imageNamed: "red-ball")
        ball.position.y = self.size.height//this remain the same
        ball.position.x = CGFloat(randomX)/*random number to generate point of origin of the ball on x axis. zdue randomX is of type UInt32 and position only accepts CGFloat we are casting to that type*/
        
        /*ball.position = CGPoint(x: self.size.width/2, y:self.size.height)point of origin:on x axis half the wide of view and on y axis the height of the view this equals the coordinates for the center top of the view**/
        
        ball.setScale(0.3)/*due default size was too big, we use this line to shrink the ball*/
        addChild(ball)
        
        let moveAction = SKAction.moveTo(y: 0, duration: 5)/*from positioning in
         top-center of the view to 0 in y axis, for a duration of 5 secs **/
        
        let deleteAction = SKAction.removeFromParent()/*deletes node **/
        
        let scaleAction = SKAction.scale(by: 0.5, duration: 1)//red-ball shrink
        
        ball.run(SKAction.sequence([moveAction, scaleAction, deleteAction]))/*function provide an array to execute both defined actions above one after the other(sequence action)*/
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
    
    /*override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {/* whenever there is a new touch on the screen the code below will execute **/
        addBall()
    }*/
    
    
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
