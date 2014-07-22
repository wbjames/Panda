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
    }
}