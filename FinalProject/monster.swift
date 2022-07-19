
import Foundation
class monster:gameCharacter{
    var attackPower:Int
    var initialAttackPower:Int
      
    init(_ name:String, _ maxNumberHealthPoint:Int,_ attackPower:Int){
        self.attackPower=attackPower
        self.initialAttackPower = attackPower
        super.init(name,maxNumberHealthPoint)
    }
    
    override func attack() -> Int {
        self.attackPower = initialAttackPower
        let chance = Int.random(in: 1..<11)
        if(chance <= 2){
            attackPower = 0
            
        }
        
        print("*** \(name) attacks : \(attackPower) damage!")
        if(attackPower <= 0){
            print("*** \(name) missed his attack")
        }
        return self.attackPower
      }
    
}

