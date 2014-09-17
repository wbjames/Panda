import SpriteKit

class BackGround:SKNode{
    var arrBG = [SKSpriteNode]()
    
    var arrFar = [SKSpriteNode]()
    

    override init() {
        super.init()
        
        var farTexture = SKTexture(imageNamed: "background_f1")
        
        var farBg0 = SKSpriteNode(texture: farTexture)
        farBg0.anchorPoint = CGPointZero
        farBg0.position.y = 150
        
        var farBg1 = SKSpriteNode(texture: farTexture)
        farBg1.anchorPoint = CGPointZero
        farBg1.position.x = farBg0.frame.width
        farBg1.position.y = 150
        
        var farBg2 = SKSpriteNode(texture: farTexture)
        
        farBg2.anchorPoint = CGPointZero
        farBg2.position.x = farBg0.frame.width * 2
        farBg2.position.y = 150
        
        self.addChild(farBg0)
        self.addChild(farBg1)
        self.addChild(farBg2)
        arrFar.append(farBg0)
        arrFar.append(farBg1)
        arrFar.append(farBg2)
        
        //近处背景
        var texture = SKTexture(imageNamed: "background_f0")
        
        var bg0 = SKSpriteNode(texture: texture)
        bg0.anchorPoint = CGPointZero
        bg0.position.y = 70
        
        var bg1 = SKSpriteNode(texture: texture)
        bg1.anchorPoint = CGPointZero
        bg1.position.x = bg0.frame.width
        bg1.position.y = 70
        self.addChild(bg0)
        self.addChild(bg1)
        arrBG.append(bg0)
        arrBG.append(bg1)

    }

    func move(speed: CGFloat){
        // 近景
        for bg in arrBG{
            bg.position.x -= speed
        }
        if arrBG[0].position.x + arrBG[0].frame.width < speed {
            arrBG[0].position.x = 0
            arrBG[1].position.x = arrBG[0].frame.width
        }
        
        //远景
        for far in arrFar{
            far.position.x -= speed/4
        }
        if arrFar[0].position.x + arrFar[0].frame.width < speed/4 {
            arrFar[0].position.x = 0
            arrFar[1].position.x = arrFar[0].frame.width
            arrFar[2].position.x = arrFar[0].frame.width * 2
        }
 
    }
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
}