
import Foundation
class location:CustomStringConvertible{
  var nameOfLocation:String
  var monster:monster
  var heroIsHere:heros?
  var astridTag: Bool?
  init(_ nameOfLocation:String, _ monster:monster){
    self.nameOfLocation = nameOfLocation
    self.monster = monster
  }
    convenience init(nameOfLocation:String, monster:monster, heroIsHere:heros){
        self.init(nameOfLocation,monster)
        self.heroIsHere = heroIsHere
    }
    convenience init(nameOfLocation:String,monster:monster,astridTag:Bool){
        self.init(nameOfLocation,monster)
        self.astridTag = astridTag
    }
}
extension location{
    var description: String{
        get {
            return "\(self.nameOfLocation)"
        }
    }
}
