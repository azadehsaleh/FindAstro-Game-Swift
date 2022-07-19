
import Foundation

import Foundation
class map{
    var mapDirectory:[String:[(l:location, rd:roadType , rdPrice:Int)]] = [:]
    init(roads:[road]){
        for rd in roads{
            // Every roads has a starting location and ending location
            // 1- get the starting location
            let startingLocation = rd.startingLocation
            var roadSaftyInt = rd.roadSaftyInt
            if (mapDirectory[startingLocation.nameOfLocation] == nil){
                mapDirectory[startingLocation.nameOfLocation]=[]
                let tupleToAdd = (rd.endingLocation,rd.roadTypes,rd.roadSaftyInt)
                mapDirectory[startingLocation.nameOfLocation]!.append(tupleToAdd)
            }else{
                let tupleToAdd = (rd.endingLocation,rd.roadTypes,rd.roadSaftyInt)
                mapDirectory[startingLocation.nameOfLocation]!.append(tupleToAdd)
            }
        }
    }
    func printMap(){
        for (key,value) in mapDirectory{
           print(" \(key) is connected to \(value)")
            
        }
    }

    func findEasiestPath(startingLocation:location, endingLocation:location)  -> [location]{
        var currentLocation = startingLocation
        var easiestPath:[location] = [currentLocation]
        if (currentLocation.nameOfLocation == endingLocation.nameOfLocation){
           // print("Hugie found Astrid in \(currentLocation.nameOfLocation)")
        } else {
            while (currentLocation.nameOfLocation != endingLocation.nameOfLocation){
               // Hugie will go to the next easy location
                if let neighboursLists = mapDirectory[currentLocation.nameOfLocation]{
                    var nextLocation = neighboursLists.first!.l
                    var safestPath = neighboursLists.first!.rdPrice
               // Neighbours List is here:
                    for n in neighboursLists{
                    if (n.l.nameOfLocation == endingLocation.nameOfLocation){
                        nextLocation = n.l
                    } else if (n.rdPrice > safestPath){
                        safestPath = n.rdPrice
                        nextLocation = n.l
                    }
                } // end for
                    currentLocation = nextLocation
                easiestPath.append(currentLocation)
                } else {
                    print("There is no road to this location!")
                    return []
                }
            }// end while
        } // else end
      //  Path found
        return easiestPath
    }
}

