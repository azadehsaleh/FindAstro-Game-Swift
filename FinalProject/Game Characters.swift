
import Foundation

import Foundation
class gameCharacter{
  var name:String
  var maxNumberHealthPoint:Int
  var amountOfDamage:Int?
 
    init (_ name:String, _ maxNumberHealthPoint:Int){
      self.name = name
      self.maxNumberHealthPoint = maxNumberHealthPoint
   }
 
   func takeDamage(amount:Int){
     self.maxNumberHealthPoint = self.maxNumberHealthPoint - amount
   }
   func attack() -> Int {
     return amountOfDamage!
   }
    func displayCharacter(){
        print("\(self.name) has \(self.maxNumberHealthPoint) Health")
    }
}

