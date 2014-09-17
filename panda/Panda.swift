import SpriteKit

enum Status: Int{
    case run=1, jump, jump2, roll
}

class Panda: SKSpriteNode{
    let runAtlas = SKTextureAtlas(named: "run.atlas")
    let runFrames = [SKTexture]()
    
    let jumpAtlas = SKTextureAtlas(named: "jump.atlas")
    let jumpFrames = [SKTexture]()
    
    let rollAtlas = SKTextureAtlas(named: "roll.atlas")
    let rollFrames = [SKTexture]()
    
    var status = Status.run
    var jumpStart:CGFloat = 0.0
    var jumpEnd:CGFloat = 0.0
    
    override init() {
        let texture = runAtlas.textureNamed("panda_run_01")
        let size = texture.size()
        super.init(texture:texture, color:UIColor.whiteColor(), size: size)
        
        for i in 1..<runAtlas.textureNames.count {
            let tempName = String(format: "panda_run_%.2d", i)
            let runTexture = runAtlas.textureNamed(tempName)
            if (runTexture != nil) {
                runFrames.append(runTexture)
            }
        }
        
        for i in 1..<jumpAtlas.textureNames.count {
            let tempName = String(format: "panda_jump_%.2d", i)
            let jumpTexture = jumpAtlas.textureNamed(tempName)
            if (jumpTexture != nil) {
                jumpFrames.append(jumpTexture)
            }
        }
        
        for i in 1..<rollAtlas.textureNames.count {
            let tempName = String(format: "panda_roll_%.2d", i)
            let rollTexture = rollAtlas.textureNamed(tempName)
            if (rollTexture != nil) {
                rollFrames.append(rollTexture)
            }
        }
        
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: texture.size())
        self.physicsBody.dynamic = true
        self.physicsBody.allowsRotation = false
        self.physicsBody.restitution = 0
        self.physicsBody.categoryBitMask = BitMaskType.panda
        self.physicsBody.collisionBitMask = BitMaskType.platform
        self.physicsBody.contactTestBitMask = BitMaskType.scene | BitMaskType.platform
        
        run()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    
    func run(){
        self.removeAllActions()
        
        self.status = .run
        self.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(runFrames, timePerFrame: 0.05)))
    }
    
    func jump(){
        self.removeAllActions()
        if self.status != Status.jump2{
            self.runAction(SKAction.animateWithTextures(jumpFrames, timePerFrame: 0.05))
            self.physicsBody.velocity = CGVectorMake(0, 450)
            if status == Status.jump {
                status = Status.jump2
                self.jumpStart = self.position.y
            }else {
                status = Status.jump
            }
            self.runAction(SKAction.animateWithTextures(jumpFrames, timePerFrame: 0.05))
        }
    }
    
    func roll(){
        self.removeAllActions()
        self.status = .roll
        self.runAction(SKAction.animateWithTextures(rollFrames, timePerFrame: 0.05), completion:{
            () in
            self.run()
            
            })
    }
    
}