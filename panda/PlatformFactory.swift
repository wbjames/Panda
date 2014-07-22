import SpriteKit

class PlatformFactory:SKNode{
    let textureLeft = SKTexture(imageNamed: "platform_l")
    let textureMid = SKTexture(imageNamed: "platform_m")
    let textureRight = SKTexture(imageNamed: "platform_r")
    
    var platforms = [Platform]()
    var sceneWidth:CGFloat = 0.0
    var delegate:ProtocolMainScene?
    
    
    func createPlatformRandom() {
        let midNum:UInt32 = UInt32(arc4random()%4 + 1)
        
        let gap:CGFloat = CGFloat(UInt(arc4random()%8 + 1))
        
        let x:CGFloat = self.sceneWidth + CGFloat(UInt(midNum*50)) + gap + 100
        
        let y:CGFloat = CGFloat(UInt(arc4random()%200 + 200))
        
        createPlatform(midNum, x: x, y: y)
    }
    
    
    
    func createPlatform(midNum:UInt32, x:CGFloat, y:CGFloat){
        let platform = Platform()
        platform.position = CGPointMake(x, y)
        
        let platform_left = SKSpriteNode(texture: textureLeft)
        platform_left.anchorPoint = CGPointMake(0.0, 0.9)
        
        let platform_right = SKSpriteNode(texture: textureRight)
        platform_right.anchorPoint = CGPointMake(0.0, 0.9)
        
        var arrPlatform = [SKSpriteNode]()
        
        arrPlatform.append(platform_left)
        
        for i in 1...midNum {
            let platform_mid = SKSpriteNode(texture: textureMid)
            platform_mid.anchorPoint = CGPointMake(0.0, 0.9)
            arrPlatform.append(platform_mid)
        }
        
        arrPlatform.append(platform_right)
        
        platform.onCreate(arrPlatform)
        
        self.addChild(platform)
        
        platforms.append(platform)
        
        delegate?.onGetData(platform.width + x - sceneWidth)
    }
    
    
    func moving(speed:CGFloat) {
        for p in platforms {
            p.position.x -= speed
        }
        if platforms[0].position.x <= -platforms[0].width{
            platforms.removeAtIndex(0)
        }
    }
}