//
//  ViewController.swift
//  GameApp
//
//  Created by javier pizarro on 11/27/20.
//  Copyright © 2020 javierpizarro. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {//default

    override func viewDidLoad() {//default
        super.viewDidLoad()//default
        
        let startScene = StartScene(size: view.bounds.size)/*GameScene() call object size to be same as the view and assigned to*/
        
        let skView = view as! SKView/*it cast(change) default view(UIView) to an SKView. For this line to work we needed before hand to define under
         custom class the class SKView as we already do. Otherwise the app will crash.*/
        
        skView.showsFPS = true//frame per seconds indicator
        skView.showsNodeCount = true
        skView.presentScene(startScene)//present scene on a skView

    }


}

