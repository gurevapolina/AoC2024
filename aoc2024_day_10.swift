import Foundation
import UIKit

class ViewController: UIViewController {
    
    let input =
    """
    3456782987078721223458762106567889430671098769654
    4349891276129850312369643487656976521589123658723
    3232010125034765409874554998540125102479034567014
    2101326734535676332123667887030434234328798598323
    3210417898743980123011256770121898985215657685412
    4398506987652098834500349843210763876004034556702
    0347615456901127985678932352107652187123126549811
    1256789347810036376547101461458943098014987430910
    2187693210211245217832106570367892367123470121321
    0096540124300354308943067689256701451234565123438
    1454431035445475217652108212101610450965434034589
    2563224546766986700543299103454321345876123127676
    3470110450897867891056782456969010216789007098787
    2989323761210568782344321327878543100218218989896
    1056109894323479653451450018967632321307127676125
    0347234765012988598560561009878901430456034565034
    1218945678967893467621872323451010569210183034789
    2301856521050012332132965410067129878345892123654
    2545665430541003343045894890128934565456734301203
    1238756767632174956556787761238981250349845210312
    0019567898948985867843295454345670361238896901498
    1123498787656876768930176321054865476766767810567
    2345019698343403452343289830238956789857654329801
    1276520501232312301450109321107678900348943210762
    0989431452301659412567018450234543211234510345643
    7871012369498748703698107567892454322365431239652
    6982321078543237654899216012301898723670121238701
    5983430347670100102765345985432385610184210321981
    4676521257881243211255435876987894321095103430870
    3676598766999356980346126785456765467656712561561
    2189432105438767898987065490308701378345899874432
    3008710219127346710897654301219652109234710923653
    3219623478033235021588923218789543212121023014567
    4988510565454104134676517809654194501033454321098
    5675432109567893245785406945403087672122569498545
    4789323678652107896690345236712121088011078567632
    3291014569743456987501210189874534599187563458901
    2104349878898543210012981065963678678296782768940
    1001256763278787620125878874052169501345891857434
    3210389854109696787434569943141054322321710996523
    4389876703010545896563430812232189810430601087012
    0478945012321032398654321001145670798510512989802
    1567032129834121067743433234030321667623403676501
    2432143018765012159812387105321434598787954565410
    3654976576544167841003098076101340125697801894321
    4567889487637650932342127689234256734676512387212
    9654112390128941013234534548940189836785003456101
    8741001498037432100105677637654302345494176543212
    7632110567126501211012988921013211012343289810101
    """
    
    let testInput =
    """
    89010123
    78121874
    87430965
    96549874
    45678903
    32019012
    01329801
    10456732
    """

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parse()
        part1()
        part2()
    }
    
    var map: [[Int]] = []
    
    func parse() {
//        map = testInput.split(separator: "\n", omittingEmptySubsequences: true)
        map = input.split(separator: "\n", omittingEmptySubsequences: true)
            .map({ String($0).split(separator: "").map({ Int(String($0)) ?? 0 }) })
    }
    
    func findHeads() -> [Point] {
        var heads: [Point] = []
        for i in 0..<map.height {
            for j in 0..<map.width {
                if map[i][j] == 0 {
                    heads.append((i, j))
                }
            }
        }
        return heads
    }
    
    func isOnMap(_ point: Point) -> Bool {
        return point.i >= 0 && point.i < map.height && point.j >= 0 && point.j < map.width
    }
    
    func nextPoint(head: Point, direction: Direction) -> Point? {
        let next: Point
        switch direction {
        case .up:
            next = (head.i - 1, head.j)
        case .down:
            next = (head.i + 1, head.j)
        case .left:
            next = (head.i, head.j - 1)
        case .right:
            next = (head.i, head.j + 1)
        }
        if !isOnMap(next) {
            return nil
        }
        if map[next.i][next.j] - map[head.i][head.j] != 1 {
            return nil
        }
        return next
    }
    
    func findRoutes(_ head: Point) {
        if map[head.i][head.j] == 9 {
            let newKey = [head.i, head.j]
            if let count = foundRoutes[newKey] {
                foundRoutes[newKey] = count + 1
            } else {
                foundRoutes[newKey] = 1
            }
            return
        }
        
        if let next = nextPoint(head: head, direction: .up) {
            findRoutes(next)
        }
        if let next = nextPoint(head: head, direction: .down) {
            findRoutes(next)
        }
        if let next = nextPoint(head: head, direction: .left) {
            findRoutes(next)
        }
        if let next = nextPoint(head: head, direction: .right) {
            findRoutes(next)
        }
    }
    
    var foundRoutes: [[Int]: Int] = [:]
    
    func part1() {
        let heads = findHeads()

        var result = 0
        for head in heads {
            foundRoutes = [:]
            findRoutes(head)
            result += foundRoutes.keys.count
        }
        print(result)
    }
    
    func part2() {
        let heads = findHeads()

        var result = 0
        for head in heads {
            foundRoutes = [:]
            findRoutes(head)
            
            let sum  = foundRoutes.values.reduce(0, +)
            result += sum
        }
        print(result)
    }
}

enum Direction {
    case up
    case down
    case left
    case right
}

typealias Point = (i: Int, j: Int)

extension [[Int]] {
    var height: Int {
        return count
    }
    
    var width: Int {
        return self[0].count
    }
}
