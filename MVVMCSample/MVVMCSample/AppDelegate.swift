//
//  AppDelegate.swift
//  MVVMCSample
//
//  Created by Ranjeet Singh on 20/05/20.
//  Copyright © 2020 Ranjeet Singh. All rights reserved.
//

import UIKit

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
    subscript(i: Range<UInt>) -> String {
        let lower = Int(i.lowerBound)
        let upper = Int(i.upperBound)
        let sIndex = lower > self.count ? self.endIndex : index(startIndex, offsetBy: lower)
        let eIndex = upper > count ? self.endIndex : index(startIndex, offsetBy: upper)
        return String(self[sIndex..<eIndex])
    }
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        debugPrint("Text"[2..<3])
        
//        let a = [5, 5, 5, 5, 5]
//         debugPrint("first dublicate \(firstDuplicate(a: a))")
//        // Override point for customization after application launch.
//
//        let arr = [[1, 2, 3],[4, 5, 6],[7, 8, 9]]
//        debugPrint(arr)
//        debugPrint(rotateImage(a: arr))
//        debugPrint(checkPalindrome(inputString: "hlbeeykoqqqqokyeeblh"))
//
//
//        let romanNumber = "XLX" // 2015
        let romanNumber = "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMCDLXXVI" // 53476
//        let romanNumber = "MMMMDCCCLXXXVIII"
        let grid: [[Character]] =
       [[".",".",".","2",".",".","6",".","."],
       [".",".",".","1",".",".",".",".","."],
       [".",".",".",".",".",".",".",".","."],
       [".",".",".","5",".","1",".",".","8"],
       [".","3",".",".",".",".",".",".","."],
       [".",".",".","9",".",".",".",".","3"],
       ["4",".",".",".",".",".",".",".","."],
       [".",".",".",".",".",".","3","8","."],
       [".",".",".",".",".",".",".",".","4"]]
        
        debugPrint("sudexo = \(sudoku2(grid: grid))")
        debugPrint(integerValueOfRomanNumeral(s: romanNumber))
        
//
//        let crypt =
//        ["TEN",
//         "TWO",
//         "ONE"]
//        let solution: [[Character]] =
//        [["O","1"],
//         ["T","0"],
//         ["W","9"],
//         ["E","5"],
//         ["N","4"]]
        
        let crypt =
        ["AA",
         "AA",
         "AA"]
        let solution: [[Character]] = [["A","0"]]
        debugPrint("Crypto = \(isCryptSolution(crypt: crypt, solution: solution))")
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }



    func firstDuplicate(a: [Int]) -> Int {
        var dict = [Int:Int]()
        for (i,v) in a.enumerated() {
            if let x = dict[v] {
                if x == -1 {
                    dict[v] = i
                }
            } else {
                dict[v] = -1
            }
        }
        
        var myKey = -1
        var repetedValue = Int.max
        for (key, value) in dict {
            if value == -1 {
                continue
            } else {
                if repetedValue > value {
                    repetedValue = value
                    myKey = key
                }
            }
            debugPrint(key, value)
        }

        return myKey
    }
 
    
    func firstNotRepeatingCharacter(s: String) -> Character {
        var nonRepeatingChar: Character = "_"
        var dict = [Character: Int]()
        for ch in s {
            if let count = dict[ch] {
                dict[ch] = count + 1
            } else {
                dict[ch] = 1
            }
        }
        
        for ch in s {
            if dict[ch] == 1 {
                nonRepeatingChar = ch
                break
            }
        }
        return nonRepeatingChar
    }

    func rotateImage(a: [[Int]]) -> [[Int]] {
        var a = a
        var i = 0
        var j = 0
        let c = a.count

        for _ in i..<c {
            j = i
            for _ in j..<c {
                let temp = a[i][j]
                a[i][j] = a[j][i]
                a[j][i] = temp
                j += 1
            }
            i += 1
        }
        
        i = 0
        for _ in i..<c {
            j = 0
            for _ in j..<c/2 {
                let temp = a[i][j]
                a[i][j] = a[i][c - 1 - j]
                a[i][c-1-j] = temp
                j += 1
            }

            i += 1
        }
        
        return a
    }

    func checkPalindrome(inputString: String) -> Bool {
        let inputString = inputString.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if inputString.isEmpty {
            return false
        }
        guard inputString.count >= 2 else {
            return true
        }

        let count = inputString.count
        let firstHalfIndex = inputString.index(inputString.startIndex, offsetBy: count/2)
        let firstSubStr = String(inputString[..<firstHalfIndex])
        var index = count/2 + (count % 2 == 0 ? 0 : 1)
        let lastHalfIndex = inputString.index(inputString.startIndex, offsetBy: index)
        let lastSubStr = String(inputString[lastHalfIndex..<inputString.endIndex].reversed())
        
        return firstSubStr == lastSubStr
        while (index < count/2) {
            let firstChar = inputString[index]
            let lastChar = inputString[count - 1 - index]
            if firstChar != lastChar {
                return false
            }
            index += 1
        }
        return true

    }

}



enum RomanNumber: String {
    case I, V, X, L, C, D, M, none
    
    var intValue: Int {
        switch self {
            case .I: return 1
            case .V: return 5
            case .X: return 10
            case .L: return 50
            case .C: return 100
            case .D: return 500
            case .M: return 1000
            case .none: return -1
        }
    }
 
}

func validation(number: RomanNumber, pv1: RomanNumber, pv2: RomanNumber, pv3: RomanNumber) -> Bool {
    if pv1 == pv2, pv2 == pv3, pv3 == .none {
        return true
    }
    else if pv1 == pv2, pv2 == pv3, pv3 == number, number != .M {
        return false
    } else if pv1.intValue < number.intValue, pv2 != .none,  pv2.intValue < number.intValue {
        return false
    } else if (pv1 == .V) || (pv1 == .L) || (pv1 == .D), pv1.intValue < number.intValue {
        return false
    } else if (pv1 == .V) || (pv1 == .L) || (pv1 == .D), pv1 == number {
        return false
    } else if pv2 != .none, pv1 != pv2, pv2 == number, !((pv1 == .I) || (pv1 == .X) || (pv1 == .C) || (pv1 == .M)) {
        return false
    } else {
        return true
    }
}

func integerValueOfRomanNumeral(s: String) -> Int {
    var sum = 0
    var previousNum1: RomanNumber = .none
    var previousNum2: RomanNumber = .none
    var previousNum3: RomanNumber = .none
    let s = s.uppercased()
    for ch in s {
        let str = String(ch)
        guard let romanNumber = RomanNumber(rawValue: str) else { return -1}
        if validation(number: romanNumber, pv1: previousNum1, pv2: previousNum2, pv3: previousNum3) {
            let number = romanNumber.intValue
            if previousNum1 != .none, number > previousNum1.intValue {
                 sum -= (previousNum1.intValue * 2)
            }
            sum += number
            previousNum3 = previousNum2
            previousNum2 = previousNum1
            previousNum1 = romanNumber
            
        } else {
            return -1
        }
    }
    return sum
}

/*
 var a: [[Character]] = [[".", ".", ".", ".", "2", ".", ".", "9", "."],
 [".", ".", ".", ".", "6", ".", ".", ".", "."],
 ["7", "1", ".", ".", "7", "5", ".", ".", "."],
 [".", "7", ".", ".", ".", ".", ".", ".", "."],
 [".", ".", ".", ".", "8", "3", ".", ".", "."],
 [".", ".", "8", ".", ".", "7", ".", "6", "."],
 [".", ".", ".", ".", ".", "2", ".", ".", "."],
 [".", "1", ".", "2", ".", ".", ".", ".", "."],
 [".", "2", ".", ".", "3", ".", ".", ".", "."]]
 
 [[".",".",".","2",".",".","6",".","."],
 [".",".",".","1",".",".",".",".","."],
 [".",".",".",".",".",".",".",".","."],
 [".",".",".","5",".","1",".",".","8"],
 [".","3",".",".",".",".",".",".","."],
 [".",".",".","9",".",".",".",".","3"],
 ["4",".",".",".",".",".",".",".","."],
 [".",".",".",".",".",".","3","8","."],
 [".",".",".",".",".",".",".",".","4"]]
 */
func sudoku2(grid: [[Character]]) -> Bool {
    //check for each colom
     for i in 0..<grid.count {
        var charDict: [Character: Bool] = ["1": false, "2": false, "3": false,
                                            "4": false, "5": false, "6": false,
                                             "7": false, "8": false, "9": false]
        for j in 0..<grid.count {
            let ch: Character = grid[i][j]
            if ch == "." {
                continue
            } else {
                if charDict[ch] == false {
                    charDict[ch] = true
                } else {
                    return false
                }
            }
        }
     }
     
     //check for each row
     for i in 0..<grid.count {
        var charDict: [Character: Bool] = ["1": false, "2": false, "3": false,
                                            "4": false, "5": false, "6": false,
                                             "7": false, "8": false, "9": false]
        for j in 0..<grid.count {
            let ch: Character = grid[j][i]
            if ch == "." {
                continue
            } else {
                if charDict[ch] == false {
                    charDict[ch] = true
                } else {
                    return false
                }
            }
        }
     }
    
    //Check for each 3X3 matrix
    var i = 0
    while i < grid.count {
        var j = 0
        while j < grid.count {
          var charDict: [Character: Bool] = ["1": false, "2": false, "3": false,
                                            "4": false, "5": false, "6": false,
                                             "7": false, "8": false, "9": false]
            for k in 0..<3 {
                let arr = grid[i+k]
                for l in 0..<3 {
                    let ch: Character = arr[j+l]
                    if ch == "." {
                        continue
                    } else {
                        if charDict[ch] == false {
                            charDict[ch] = true
                        } else {
                            return false
                        }
                    }
                }
            }
        j += 3
        }
        i += 3
    }
    return true
}

func isCryptSolution(crypt: [String], solution: [[Character]]) -> Bool {
    
    var solutionDict = [Character: String]()
    for mapArray in solution {
        guard let char = mapArray.first, let num = mapArray.last else { return false }
        solutionDict[char] = String(num)
    }
    var numbers = [String]()
    for word in crypt {
        var numStr = ""
        for ch in word {
            guard let number = solutionDict[ch] else { return false }
            numStr += number
        }
        numbers.append(numStr)
    }
    var sum: UInt64 = 0
    for i in 0..<numbers.count - 1 {
        let number = numbers[i]
        if number.count > 1, number[0] == "0" {
            return false
        }
        guard let num = UInt64(number) else { return false }
        sum += num
    }
    guard let lastValue = numbers.last, let total = UInt64(lastValue) else { return false }
    return sum == total
}

