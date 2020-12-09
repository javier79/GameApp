//
//  GameScene.swift
//  GameApp
//
//  Created by javier pizarro on 11/30/20.
//  Copyright © 2020 javierpizarro. All rights reserved.
//


import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate{/*object GameScene a subclass of SKScene class*/
    
    let catNode = SKSpriteNode(imageNamed: "cat")//instancing a node image named "cat"
    let bgNode = SKSpriteNode(imageNamed: "bg")
    var timer = Timer()/*a timer that fires after a certain time interval has elapsed, sending a specified message to a target object**/
    var gameTime = 0//temporary counter
    
    override func didMove(to view: SKView) {//Present object in a SKView
        //execute addBall() every two seconds on GameScene(self)
        
        physicsWorld.contactDelegate = self/*protocol implementation to display notifications when catNode and ball get in contact**/
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(addBall), userInfo: nil, repeats: true)//nil means we are not passing user info.
        addCat()
        //addBackground()
        
        
    }
    
    @objc func addBall(){//@objc is cause of #selector function above
        
        gameTime += 1/*counts til 10, GameScene would last 10 secs before
         GameOverScene is rendered*/
        
        
        let randomX = arc4random_uniform(UInt32(self.size.width))/*provides a random number that ranges from 0 to the widest value of the view on x axis(upper bound)**/
        
        let ball = SKSpriteNode(imageNamed: "red-ball")
        ball.position.y = self.size.height//this remain the same
        ball.position.x = CGFloat(randomX)/*random number to generate point of origin of the ball on x axis. due randomX is of type UInt32 and position only accepts CGFloat we are casting to that type*/
        
        /*ball.position = CGPoint(x: self.size.width/2, y:self.size.height)point of origin:on x axis half the wide of view and on y axis the height of the view this equals the coordinates for the center top of the view**/
        
        ball.setScale(0.3)/*due default size was too big, we use this line to shrink the ball*/
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2 + 5)/*Physics body definition with size(ball.size.width/2, this is a formula for the radius of our ball so that the SKPhysics body have the same dimentions(radius)) and shape to "wrap" a ball*/
        ball.physicsBody?.contactTestBitMask = (ball.physicsBody?.collisionBitMask)!/*setting contactTestBitMask. Due collisionBitMask is set by default in our case allowing for ball to have properties of collision when in contact with cat, it sets contactTestBitMask
            when collisionBitMask returns that ball and cat have come to collide with
            each other, which contactTestBitMask ackowledge's as the ocurrence of
            contact between the two which calls function didBegin()
            that will execute message in terminal. **/
        
        ball.name = "ball"
        
        addChild(ball)
        
        let moveAction = SKAction.moveTo(y: 0, duration: 5)/*from positioning in
         top-center of the view to 0 in y axis, for a duration of 5 secs **/
        
        let deleteAction = SKAction.removeFromParent()/*deletes node **/
        
        let scaleAction = SKAction.scale(by: 0.5, duration: 1)//red-ball shrink
        
        ball.run(SKAction.sequence([moveAction, scaleAction, deleteAction]))/*function provide an array to execute both defined actions above one after the other(sequence action)*/
        
        if gameTime > 10{
            timer.invalidate()//stop timer which contains addBall, so balls are stopped
            presentGameOverScene()//execute presentation of game  over scene
        }
    }
    
    func presentGameOverScene(){
        
        let gameOverScene = GameOverScene(size: self.size)//definitio
        let transition = SKTransition.doorsOpenVertical(withDuration: 1.5)
        self.view?.presentScene(gameOverScene, transition: transition)/*present scene and execut transitions*/
    }
    
    
    func addCat(){
        
        //catNode.anchorPoint = CGPoint.zero
        catNode.position = CGPoint(x: catNode.size.width/2, y: catNode.size.height/2)
        /*this positioning above is with respect to it's own container the effect
         is that the SKPhysicsBody now looks aligned with the cat
         and not sideways as when we defined instead catNode anchor point(above in comments))**/
        //catNode.anchorPoint = CGPoint.zero//setting node position(property) on screen
        catNode.setScale(0.8)//setting the size(property)
        catNode.zPosition = 1//z position from nearer to farther(cat in front of background)
        catNode.physicsBody = SKPhysicsBody(rectangleOf: catNode.size)/*we are employing a rectangle shape the size of our catNode**/
        catNode.physicsBody?.affectedByGravity = false
        /*by default gravity takes effect over our nodes when a SKPhysicsBody is instantiated for our nodes, for our
            cat to stay at the bottom of the view we must override the property with this line*/
        catNode.physicsBody?.isDynamic = false/*this will disable gravite effect, friction and collision with other objects, in our case the cat is not affected when interacts with ball but, the ball due its dynamic property is true by default when accquire a SKPhysicsBody it will be affected when in contact with cat*/
        catNode.name = "cat"
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
    /*function below is called whenever there is contact between two SKPhisics bodies**/
    func didBegin(_ contact: SKPhysicsContact) {
        //print("cat and ball contacted")
        
        
        /*variables bodyA and bodyB are properties of SKPhysicsContact when two nodes(physics bodies) come into contact swift assign to each node one of this variables anyone of the two. Due in our case we only want eliminate the ball and that bodyA/bodyB are assigned automathically, the code below allows to determine which var contains the ball  **/
        
        /*guard keyword manages when we might receive a null value
         from the else clause, thats my understanding at the time**/
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == "ball"{
            nodeA.removeFromParent()
        }else if nodeB.name == "ball"{
            nodeB.removeFromParent()
        
        }
    }
}
