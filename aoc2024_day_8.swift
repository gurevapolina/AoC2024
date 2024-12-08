import Foundation
import UIKit

class ViewController: UIViewController {
    
    let input =
    """
    ....................................8.............
    ..................E...............................
    .................................g................
    ...........................................l...b..
    ..C...........s..............8..........b.........
    ..................3..1........................b...
    ............N....3.....................1.....b....
    .....................N.....8....1..............2..
    ..q....................................P..........
    ......................N...........................
    ...........E.................................l....
    .............S.....c.............T..2v............
    .........w....E........q............L.....P.....l.
    ........w..............................a...V......
    ...........t..................v..V................
    .....w.C............................V....4.....L..
    ........................................I.n..T....
    .....E.5..C...8....3..q...........................
    ...............s..0...A........W...........a....T.
    ...............A................vPT...L..W..e.4...
    ...........Cw..................2.....G.p.....4....
    ....S........q........s.............a.............
    S.............c......e....................V.......
    ......5...........................................
    ....5.............................................
    ...........................I............g.........
    ...............c.........A........................
    .................s.............G.............etg..
    .........5...L.........f...v......W...............
    ............................0.W.....I........t....
    ..................................................
    ...................f...........Q.0................
    ..............1m9.f..........0........3.........F.
    ..f...9................B..........................
    ...........S...........................F......e...
    ........c.............n.....Q.....................
    .....N...............B............g..7....t.......
    ..........B.........P.......G.....................
    ..m...........................Q...................
    .............m.....................p...........F..
    .....M..B......Q..i.....................7.4.......
    ............M..................7..................
    ...........n......................................
    ................................p.....6.F.7.......
    ..........M...........p.........6.................
    .M............i...................................
    ..............................G...................
    ..............li.......................6..........
    .....9.....................i...6..................
    .....n.............................9..............
    """
    
    let testInput =
    """
    ............
    ........0...
    .....0......
    .......0....
    ....0.......
    ......A.....
    ............
    ............
    ........A...
    .........A..
    ............
    ............
    """

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parse()
        part1()
        part2()
    }
    
    typealias Coord = (Int, Int)
    var map: [[String]] = []
    
    func parse() {
//       map = testInput.split(separator: "\n", omittingEmptySubsequences: true)
       map = input.split(separator: "\n", omittingEmptySubsequences: true)
            .map({
                String($0)
                    .split(separator: "", omittingEmptySubsequences: true)
                    .map({ String($0) })
            })
    }
    
    func isValidPoint(i: Int, j: Int) -> Bool {
        guard i >= 0, j >= 0, i < map.height, j < map.width else { return false }
        return true
    }
    
    
    func buildDict() -> [String: [Coord]] {
        var dict: [String: [Coord]] = [:]
        
        for i in 0..<map.height {
            for j in 0..<map.height {
                if let elem = map[i][j].first,
                   elem.isLetter || elem.isNumber {
                    
                    if let coords = dict[map[i][j]] {
                        dict[map[i][j]] = coords + [Coord(i, j)]
                    } else {
                        dict[map[i][j]] = [Coord(i, j)]
                    }
                }
            }
        }
        
        return dict
    }
    
    func findAntinodes1(first: Coord, second: Coord) -> [Coord] {
        let diffX = first.1 - second.1
        let diffY = first.0 - second.0
        
        let firstPoint = Coord(second.0 - diffY, second.1 - diffX)
        let secondPoint = Coord(first.0 + diffY, first.1 + diffX)
        
        print(first, second, firstPoint, secondPoint)
        
        var result: [Coord] = []
        if isValidPoint(i: firstPoint.0, j: firstPoint.1) {
            result.append(firstPoint)
        }
        if isValidPoint(i: secondPoint.0, j: secondPoint.1) {
            result.append(secondPoint)
        }
        return result
    }
    
    func findAntinodes2(first: Coord, second: Coord) -> [Coord] {
        let diffX = first.1 - second.1
        let diffY = first.0 - second.0
        
        var result: [Coord] = []
        
        var coord = second
        while isValidPoint(i: coord.0, j: coord.1) {
            let newPoint = Coord(coord.0 - diffY, coord.1 - diffX)
            if isValidPoint(i: newPoint.0, j: newPoint.1) {
                result.append(newPoint)
            }
            coord = newPoint
        }
        
        coord = first
        while isValidPoint(i: coord.0, j: coord.1) {
            let newPoint = Coord(coord.0 + diffY, coord.1 + diffX)
            if isValidPoint(i: newPoint.0, j: newPoint.1) {
                result.append(newPoint)
            }
            coord = newPoint
        }
        
        result.append(first)
        result.append(second)

        return result
    }
    
    var isPart2 = false
    
    func part1() {
        let dict = buildDict()
        
        var array: [Coord] = []
        
        for elem in dict.values {
            for i in 0..<elem.count {
                for j in (i + 1)..<elem.count {
                    array += findAntinodes1(first: elem[i], second: elem[j])
                }
            }
        }
        
        let set = Set(array.map({ [$0.0, $0.1] }))
        print(set.count)
    }
    
    func part2() {
        let dict = buildDict()
        
        var array: [Coord] = []
        
        for elem in dict.values {
            for i in 0..<elem.count {
                for j in (i + 1)..<elem.count {
                    array += findAntinodes2(first: elem[i], second: elem[j])
                }
            }
        }
        
        let set = Set(array.map({ [$0.0, $0.1] }))
        print(set.count)
    }
}

extension [[String]] {
    var height: Int {
        return count
    }
    
    var width: Int {
        return first?.count ?? 0
    }
}
