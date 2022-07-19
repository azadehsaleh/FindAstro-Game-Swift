
import Foundation

class fight{

    var hero : heros
    var monster : monster
    var whosTurn: String
    var fightIsOver : Bool
    var runAway :Bool = false
    var heroInitialHealthPoints:Int
    var location:location
    var sneaked:Bool = false

    init(_ hero:heros,_ location:location) {

        self.hero = hero
        self.monster = location.monster
        self.location = location
        self.whosTurn = monster.name
        self.fightIsOver = false
        self.heroInitialHealthPoints = hero.maxNumberHealthPoint

    }

     private func applyDamage(fromCharachter:gameCharacter,toCharachter:gameCharacter){
         toCharachter.takeDamage(amount: fromCharachter.attack())
    }

    func performTurn(action:Actions){
        
            switch (action){
            case Actions.attacking:
                print("\(hero.name) is \(action)")
                applyDamage(fromCharachter:hero, toCharachter:monster)
            case Actions.TryingToSneaking:
                print("\(hero.name) is \(action)")
               sneaked = hero.sneak()
                if (sneaked == true){
                    fightIsOver = true
                    monster.maxNumberHealthPoint = 0
                    print("Hugie sneaked")
                } else if(sneaked == false){
                print("Hugie couldnt sneak")
                }
                
            case Actions.runingAway:
                print("\(hero.name) is \(action)")
               // hero.maxNumberHealthPoint = 0
                self.fightIsOver = true
                self.runAway = true
                default:
                print("Enter a valid number")
            }
    }

    func fight(){
        print("")
        print("Arrived At \(location.nameOfLocation)")
        print("\(monster.name) is Waiting to FIGHT!!")
        print("Fight Begins!")
        print("")

        var counter = 1
        let monsterBaseHealthPoints = monster.maxNumberHealthPoint
        var validUserEntry = false

        repeat{
            print("-----Turn #:\(counter)-----")
            if( whosTurn == hero.name ){
                whosTurn = monster.name
            }
            else if(whosTurn == monster.name){
                whosTurn = hero.name
            }

            print("Current Turn is :\(whosTurn)")
            print("\(hero.name) HP : \(hero.maxNumberHealthPoint)/\(heroInitialHealthPoints)")
            print("\(monster.name) HP : \(monster.maxNumberHealthPoint)/\(monsterBaseHealthPoints)")
            print("")


            if (whosTurn == hero.name){
                repeat{
                print("\(hero.name),what move will you make?")
                print("1.Attack")
                print("2.Sneak")
                print("3.Give up")
            let userChoice:Int

                    if let input = Int(readLine()!){
                        userChoice = input
                    }
                    else{
                        userChoice = 0
                    }

                switch userChoice {
                case 1:
                    performTurn(action: Actions.attacking)
                    counter = counter + 1
                    validUserEntry = true

                case 2:
                    performTurn(action: Actions.TryingToSneaking)
                    counter = counter + 1
                    validUserEntry = true

                case 3:
                    performTurn(action: Actions.runingAway)
                    runAway = true
//                    print("")
                    validUserEntry = true

                default:
                    print("Sorry wrong entry, please choose again")
                    print("")
                }

                } while(validUserEntry == false)
                  print("")

            } else if( whosTurn == monster.name ){
                print("\(monster.name) is attacking")
                applyDamage(fromCharachter: monster, toCharachter: hero)
                counter = counter + 1

            }

        }while(hero.maxNumberHealthPoint > 0 && monster.maxNumberHealthPoint > 0 &&  self.fightIsOver == false )
        
        fightIsOver = true
        if (sneaked == true){
            print("Winner is \(hero.name)")

        }
        else if(runAway) {
           print("Fight is Over!")
            print("\(monster.name) won!")
        }
        else if (sneaked == false){
        print("Fight is over")
        print("Final Stats:")

        if(hero.maxNumberHealthPoint < 0){
            hero.maxNumberHealthPoint = 0

        }else if(monster.maxNumberHealthPoint < 0){
            monster.maxNumberHealthPoint = 0
        }

        print("\(hero.name) HP : \(hero.maxNumberHealthPoint)/50")
        print("\(monster.name) HP : \(monster.maxNumberHealthPoint)/\(monsterBaseHealthPoints)")

        if (hero.maxNumberHealthPoint == 0){
            print("Winner is \(monster.name)")
            
        }else if (monster.maxNumberHealthPoint == 0 || hero.sneak() == true ){
            print("Winner is \(hero.name)")

        }
    }
    }

}


