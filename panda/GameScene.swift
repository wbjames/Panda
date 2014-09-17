import SpriteKit
import AVFoundation

protocol ProtocolMainScene{
    func onGetData(dist: CGFloat)
}

class GameScene: SKScene,ProtocolMainScene, SKPhysicsContactDelegate {
    // define var
    lazy var panda = Panda()
    lazy var platformFactory = PlatformFactory()
    lazy var bg = BackGround()
    
    var runDistance:Int = 0
    
    var moveSpeed:CGFloat = 15
    let speedAddFactor:CGFloat = 0.01
    var lastDis:CGFloat = 0.0
    
    var lastYieldTimeInterval:CFTimeInterval = 0.0
    
    
    var backgroundMusicPlayer:AVAudioPlayer = AVAudioPlayer()
    let lblGameOver:SKLabelNode = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    
    override func didMoveToView(view: SKView) {
        let skyColor = SKColor(red: 133/255, green: 197/255, blue: 207/255, alpha: 1)
        self.backgroundColor = skyColor
        
        self.addChild(bg)
        
        
        lblGameOver.fontSize = 40
        lblGameOver.fontColor = SKColor.whiteColor()
        lblGameOver.position = CGPointMake(100, self.frame.height - 150)
        lblGameOver.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        lblGameOver.text = String(runDistance);
        self.addChild(lblGameOver)
        
        
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVectorMake(0, -5)
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsBody.dynamic = false
        self.physicsBody.categoryBitMask = BitMaskType.scene
        
        panda.position = CGPointMake(200, 400)
        

        
        
        
        self.addChild(panda)
        
        self.addChild(platformFactory)
        platformFactory.delegate = self
        platformFactory.sceneWidth = self.frame.width
        platformFactory.createPlatform(10, x: 0, y: 200)
        
        
        
        var bgMusicURL:NSURL = NSBundle.mainBundle().URLForResource("apple", withExtension: "mp3")!
        backgroundMusicPlayer = AVAudioPlayer(contentsOfURL: bgMusicURL, error: nil)
        backgroundMusicPlayer.numberOfLoops = -1
        backgroundMusicPlayer.prepareToPlay()
        backgroundMusicPlayer.play()
        
        println("moveSpeed = \(moveSpeed)")
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        panda.jump()
       
    }
   
    func updateWithTimeSinceLastUpdate(timeSinceLastUpdate:CFTimeInterval){
        lastYieldTimeInterval += timeSinceLastUpdate
        if lastYieldTimeInterval > 1 {
            lastYieldTimeInterval = 0
            moveSpeed += speedAddFactor
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        bg.move(moveSpeed/5)
        
        
        runDistance += Int(moveSpeed);
        GameState.sharedInstance.runDistance = runDistance
        lblGameOver.text = String(runDistance)
        
        lastDis -= moveSpeed
        if lastDis <= 0 {
            println("new platform")
            //platformFactory.createPlatform(1, x: 1500, y: 200)
            platformFactory.createPlatformRandom()
        }
        
        platformFactory.moving(moveSpeed)
        
        updateWithTimeSinceLastUpdate(currentTime)
    }
    
    func onGetData(dist: CGFloat) {
        self.lastDis = dist
    }
    
    
    
    func didBeginContact(contact: SKPhysicsContact!){
        if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask) == (BitMaskType.panda | BitMaskType.platform) {
            panda.run()
            panda.jumpEnd = panda.position.y
            if( panda.jumpEnd - panda.jumpStart < -70) {
                panda.roll()
            }
            self.runAction(SKAction.playSoundFileNamed("hit_platform.mp3", waitForCompletion: false))
        }
        
        else if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask) == (BitMaskType.panda | BitMaskType.scene) {
            self.runAction(SKAction.playSoundFileNamed("lose.mp3", waitForCompletion: false))
            
            gameOver()
            println("game over!")
        }
     }
    
    func didEndContact(contact: SKPhysicsContact!) {
        if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask) == (BitMaskType.panda | BitMaskType.platform) {
            panda.jumpStart = panda.position.y
        }
    }
    
    func gameOver(){
        GameState.sharedInstance.saveState()
        
        let endGameScene = EndGameScene(size: self.size, runDistance: runDistance)
        let reveal = SKTransition.fadeWithDuration(0.5)
        backgroundMusicPlayer.stop()
        self.view.presentScene(endGameScene, transition: reveal)
        
    }
}






