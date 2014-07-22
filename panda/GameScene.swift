import SpriteKit

class GameScene: SKScene,ProtocolMainScene {
    // define var
    lazy var panda = Panda()
    lazy var platformFactory = PlatformFactory()
    
    var moveSpeed:CGFloat = 15
    var lastDis:CGFloat = 0.0
    
    override func didMoveToView(view: SKView) {
        let skyColor = SKColor(red: 133/255, green: 197/255, blue: 207/255, alpha: 1)
        self.backgroundColor = skyColor
        
        panda.position = CGPointMake(200, 400)
        self.addChild(panda)
        
        self.addChild(platformFactory)
        platformFactory.delegate = self
        platformFactory.sceneWidth = self.frame.width
        platformFactory.createPlatform(10, x: 0, y: 200)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if panda.status == Status.run {
            panda.jump()
        } else if panda.status == Status.jump {
            panda.roll()
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        lastDis -= moveSpeed
        if lastDis <= 0 {
            println("new platform")
            //platformFactory.createPlatform(1, x: 1500, y: 200)
            platformFactory.createPlatformRandom()
        }
        
        platformFactory.moving(moveSpeed)
    }
    
    func onGetData(dist: CGFloat) {
        self.lastDis = dist
    }
}


protocol ProtocolMainScene{
    func onGetData(dist: CGFloat)
}