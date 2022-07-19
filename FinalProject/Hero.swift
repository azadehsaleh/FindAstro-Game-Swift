
import Foundation
class heros:gameCharacter{
    var weaponStrength:Int
    var isInLocation:Bool
    var initialWeaponStrength:Int
    
    init(_ name:String ,_ maxNumberHealthPoint:Int ,_ weaponStrength:Int, _ isInLocation:Bool){
        self.weaponStrength = weaponStrength
        self.isInLocation = isInLocation
        self.initialWeaponStrength = weaponStrength
        super.init(name,maxNumberHealthPoint)
        
    }
    
    override func attack() -> Int {
        
        self.weaponStrength = initialWeaponStrength
        let chance = Int.random(in: 1..<11)
        
        if(chance <= 3){
            let criticalHit = Double(weaponStrength) * 1.2
            weaponStrength = Int(criticalHit)
            print("Critical Hit")
        }
        print("\(name) attacks : \(weaponStrength) damage!")
        return weaponStrength
    }
    
    func sneak() -> Bool {
    var sneak = false
    let randomInt = Int.random(in: 1..<11)
    if(randomInt <= 3){
            sneak = true
        }
    return sneak
        
    }

}

