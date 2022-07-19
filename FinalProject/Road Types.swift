
import Foundation

enum roadType:CustomStringConvertible{
  case Paved
  case Swampy
  case Mountainous
}
extension roadType{
    var description: String{
        get{
            switch self{
            case .Paved:
                return "The road type is: Paved"
            case .Swampy:
                return "The road type is: Swamp"
            case .Mountainous:
                return "The road type is: mountain"
            }
        }
    }
}
