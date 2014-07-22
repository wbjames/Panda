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
    
    
    init() {
        let texture = runAtlas.textureNamed("panda_run_01")
        let size = texture.size()
        super.init(texture:texture, color:UIColor.whiteColor(), size: size)
        
        for i in 1..<runAtlas.textureNames.count {
            let tempName = String(format: "panda_run_%.2d", i)
            let runTexture = runAtlas.textureNamed(tempName)
            if runTexture {
                runFrames.append(runTexture)
            }
        }
        
        for i in 1..<jumpAtlas.textureNames.count {
            let tempName = String(format: "panda_jump_%.2d", i)
            let jumpTexture = jumpAtlas.textureNamed(tempName)
            if jumpTexture {
                jumpFrames.append(jumpTexture)
            }
        }
        
        for i in 1..<rollAtlas.textureNames.count {
            let tempName = String(format: "panda_roll_%.2d", i)
            let rollTexture = rollAtlas.textureNamed(tempName)
            if rollTexture {
                rollFrames.append(rollTexture)
            }
        }
        
        
        run()
    }
    
    
    func run(){
        self.removeAllActions()
        self.status = .run
        self.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(runFrames, timePerFrame: 0.05)))
    }
    
    func jump(){
        self.removeAllActions()
        self.status = .jump
        self.runAction(SKAction.animateWithTextures(jumpFrames, timePerFrame: 0.05))
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