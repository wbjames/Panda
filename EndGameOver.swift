import SpriteKit

class EndGameScene:SKScene {
    
    init(size: CGSize, runDistance: Int){
        super.init(size: size)

        let lblHighRunDistance = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        lblHighRunDistance.fontSize = 30
        lblHighRunDistance.fontColor = SKColor.whiteColor()
        lblHighRunDistance.position = CGPointMake(self.size.width/2, self.size.height - 140)
        lblHighRunDistance.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        lblHighRunDistance.text = String(format: "最高记录 %d", GameState.sharedInstance.highRunDistance)
        self.addChild(lblHighRunDistance)

        
        let lblGameOver:SKLabelNode = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        lblGameOver.fontSize = 100
        lblGameOver.fontColor = SKColor.whiteColor()
        lblGameOver.position = CGPointMake(self.size.width/2, self.size.height/2)
        lblGameOver.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        lblGameOver.text = String(runDistance)
        
        self.addChild(lblGameOver)
        
        let lblTapAgain:SKLabelNode = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        lblTapAgain.fontSize = 50
        lblTapAgain.fontColor = SKColor.whiteColor()
        lblTapAgain.position = CGPointMake(self.size.width/2, 160)
        lblTapAgain.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        lblTapAgain.text = "点击再玩一次"
        self.addChild(lblTapAgain)
        
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        if let gameScene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view.
            let skView = self.view as SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            gameScene.scaleMode = .AspectFill
            
            println(gameScene.size)
            skView.presentScene(gameScene)
            
//            let reveal = SKTransition.fadeWithDuration(0.5)
//            self.view.presentScene(gameScene, transition: reveal)
            //gameScene.backgroundMusicPlayer.play()
        }

        
    }
    
}