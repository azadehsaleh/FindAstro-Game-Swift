

import Foundation
var fightIsOver = false
var resultForAstridLocation:Bool = false
var needNewPath = true
// A list of locations' names
let locationsName = ["Ithaca", "Argos" , "Mycanae" , "Sparta" , "Salamis" , "Lokris" , "Jordan" , "Tajris" , "Athens"]
// A list of monster's names
let monstersName = ["NEMEAN LION", "GOLDEN DEER" , "Typhon" , "LERNEAN HYDRA" , "Echidna" , "Sphinx" , "Mares of Diomedes" , "Erymanthian Boar" , "CRETAN BULL"]
// create Hugie object
let Hugie = heros("Hugie",50,10, true)
let hugieInitialHealthPoint = Hugie.maxNumberHealthPoint
var locList:[location]=[]
for i in 0..<locationsName.count{
    let tempLocation = location(locationsName[i],
                                monster(monstersName[i],Int.random(in: 25 ... 35),
                                Int.random(in: 4 ... 10)))
    locList.append(tempLocation)
}

// print locations' names and their monsters . we can comment this part
//for i in 0..<locationsName.count{
//    print("Location \(i+1) is: '\(locList[i].nameOfLocation)', and '\(locList[i].monster.name)' is in this location")
//}

let roadsList = [
    road(locList[0], locList[1], roadType.Paved),
    road(locList[0], locList[2], roadType.Paved),
    road(locList[0], locList[3], roadType.Swampy),
    road(locList[1], locList[2], roadType.Swampy),
    road(locList[1], locList[4], roadType.Paved),
    road(locList[2], locList[5], roadType.Mountainous),
    road(locList[2], locList[6], roadType.Mountainous),
    road(locList[3], locList[2], roadType.Mountainous),
    road(locList[4], locList[2], roadType.Paved),
    road(locList[5], locList[6], roadType.Paved),
    road(locList[5], locList[8], roadType.Paved),
    road(locList[6], locList[7], roadType.Paved),
    road(locList[7], locList[8], roadType.Paved)
]
//1. Generating a Map
let Map2 = map(roads: roadsList)
// This is to show to our instructor
print("                                ---- Map is Created ----")
Map2.printMap()


// 3. Placing Astrid and Hugie on the Map
var placeAstrid = Int.random(in: 0..<locList.count)
locList[placeAstrid] = location(
      nameOfLocation: locList[placeAstrid].nameOfLocation,
      monster: locList[placeAstrid].monster,
      astridTag: true)

var placeHero = Int.random(in: 0...placeAstrid)
// This is to show to our instructor
print("***This is to show to our instructor that the app knows where Astrid is***")
print("------- Astrid is in location called '\(locList[placeAstrid])' --------")
print("------- Hugie will start to journey from '\(locList[placeHero].nameOfLocation)'--------")


// 4. Starting the Game
var listOfEntry:[String]=["1. Search for Astrid","2. Rescue Astrid","3. Quit"]
userInputCheck()

func showMenu()-> String{
    print("What will you do?")
    for l in listOfEntry{
        print(l)
    }
    let n = readLine()
    return n!
}

func userInputCheck(){
    var entryCheking = checkEntry(z:showMenu())
    while(!entryCheking){
        entryCheking = checkEntry(z:showMenu())
    }
}

func checkEntry(z: String) -> Bool {
    var result:Bool = false
    
    switch z {
        case "1":
        print("Enter Choice: \(z)")
        print("Serching for Astrid...")
        result = true
        searchForAstrid()
        case "2":
        print("Enter Choice: \(z)")
        if (resultForAstridLocation){
            print("Starting quest")
            while (!fightIsOver){
                easyPath()
            }
            result = true
        } else {
            print("You should to Search for Astrid first.")
            userInputCheck()
            result = false
        }
        case "3":
        print("Enter Choice: \(z)")
        print("Goodbye!")
        result = true
        default:
        print("Enter Choice: \(z)")
        print("Invalid selection, try again.")
        result = false
    }
    return result
}

func searchForAstrid(){
    var index=0
    for i in 0..<locList.count{
        if (i == placeAstrid){
                print("Searching \(locList[i]): Astrid found")
                index = i
                resultForAstridLocation = true
                break
            } else{
               print("Searching \(locList[i]): Astrid not found, moving to next city")
               resultForAstridLocation = false
            }
    }
    print("Astrid found! She is in location '\(locList[index])'")
    print("----------------------------------------------------")
    listOfEntry[0]="1. Search for Astrid [COMPLETE!]"
    userInputCheck()
}

var easiestPath:[location] = []
func easyPath(){
    if (needNewPath){
        print("Generating the easiest path to Astrid....")
        locList[placeHero] = location(
            nameOfLocation: locList[placeHero].nameOfLocation,
            monster: locList[placeHero].monster,
            heroIsHere: Hugie)
       easiestPath = Map2.findEasiestPath(startingLocation: locList[placeHero], endingLocation: locList[placeAstrid])
        if (easiestPath.isEmpty){
            print("Hughie should be located in another location which is accessible to Astrid")
            placeHero = Int.random(in: 0...placeAstrid)
            userInputCheck()
        }
       
    }
    print("Path found. The easiest path to Astrid is: \(easiestPath)")
    print("")
    startFighting()
}


func startFighting(){
    var fightsList:[fight]=[]
    for i in 0..<easiestPath.count{
        let fight = fight(Hugie, easiestPath[i])
        fightsList.append(fight)
    }
    for i in 0..<fightsList.count{
        fightsList[i].fight()
        if (fightsList.last?.fightIsOver == true || fightsList[i].runAway == true  || Hugie.maxNumberHealthPoint == 0 ){
            if (fightsList.last!.location.monster.maxNumberHealthPoint == 0){
                print("You Rescued Astrid! Congratulation****")
                fightIsOver = true
                listOfEntry[1]="2. Rescue Astrid [COMPLETE!]"
                checkEntry(z: showMenu())
            } else if(Hugie.maxNumberHealthPoint == 0 || fightsList[i].runAway == true) {
                print(" Sorry Hugie! You Lost. Try Again!")
               // fightIsOver = true
                needNewPath = false
                userInputCheck()
                break
            }
        }
        
        Hugie.maxNumberHealthPoint = hugieInitialHealthPoint
    }
}

