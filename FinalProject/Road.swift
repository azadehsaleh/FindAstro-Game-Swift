
import Foundation

class road:CustomStringConvertible{
 var startingLocation:location
 var endingLocation: location
 var roadTypes: roadType
 var roadSaftyInt:Int{
        get {
            func roadSaftyInt() -> Int{
                switch self.roadTypes{
                case .Paved:
                    return 3
                case .Swampy:
                    return 2
                case .Mountainous:
                    return 1
                default:
                    return 0
                }
            }
            return roadSaftyInt()
        }
    }
 init(_ startingLocation:location, _ endingLocation: location, _ roadTypes: roadType){
   self.startingLocation = startingLocation
   self.endingLocation = endingLocation
   self.roadTypes = roadTypes
 }
  
}
extension road{
    var description: String{
        get{
            return "\(self.startingLocation) -> \(self.roadTypes) -> \(self.endingLocation)"
        }
    }
}

