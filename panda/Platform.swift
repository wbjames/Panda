import SpriteKit

class Platform:SKNode {
    var width:CGFloat = 0.0
    var height:CGFloat = 10
    
    func onCreate(arrSprite:[SKSpriteNode]) {
        for platform in arrSprite {
            platform.position.x = self.width
            self.addChild(platform)
            self.width += platform.size.width
        }
        
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.width,self.height), center: CGPointMake(self.width/2, 0))
        self.physicsBody.categoryBitMask = BitMaskType.platform
        self.physicsBody.dynamic = false
        self.physicsBody.allowsRotation = false
        self.physicsBody.restitution = 0
                
    }
    
}