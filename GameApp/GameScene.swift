//
//  GameScene.swift
//  GameApp
//
//  Created by javier pizarro on 11/30/20.
//  Copyright © 2020 javierpizarro. All rights reserved.
//


import SpriteKit

class GameScene: SKScene{/*object GameScene a subclass of SKScene class*/
    
    let catNode = SKSpriteNode(imageNamed: "cat")//instancing a node named "cat"
    
    override func didMove(to view: SKView) {//Present object in a SKView
        
        catNode.anchorPoint = CGPoint.zero//setting node position(property) on screen
        catNode.setScale(2.0)//setting the size(property)
        addChild(catNode)//adding node, it is a child of SKScene wich is also a node
        
    }
}
