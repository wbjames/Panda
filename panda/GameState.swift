import Foundation

class GameState: NSObject{
    var runDistance:Int = 0
    var highRunDistance:Int = 0
    var stars:Int = 0
    
    class var sharedInstance: GameState{
        struct Static{
            static let instance: GameState = GameState()
        }
        return Static.instance
    }
    
    override init() {
        super.init()
        runDistance = 0
        highRunDistance = 0
        stars = 0
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let hscore:Int? = defaults.objectForKey("highScore") as? Int
        if hscore != nil{
            highRunDistance = hscore!
        }
        let ss:Int? = defaults.objectForKey("stars") as? Int
        if ss != nil{
            stars = ss!
        }
    }
    
    func saveState() {
        highRunDistance = max(runDistance, highRunDistance)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(highRunDistance, forKey: "highRunDistance")
        defaults.setInteger(stars, forKey: "stars")
        defaults.synchronize()
    
    }
    
}

