import Foundation
import UIKit
import HeapModule
import OrderedCollections

class ViewController: UIViewController {

    let input =
    """
    x00: 1
    x01: 0
    x02: 0
    x03: 0
    x04: 0
    x05: 1
    x06: 1
    x07: 1
    x08: 1
    x09: 1
    x10: 1
    x11: 1
    x12: 0
    x13: 0
    x14: 1
    x15: 1
    x16: 1
    x17: 1
    x18: 1
    x19: 0
    x20: 0
    x21: 0
    x22: 0
    x23: 1
    x24: 1
    x25: 0
    x26: 0
    x27: 1
    x28: 0
    x29: 0
    x30: 0
    x31: 1
    x32: 0
    x33: 0
    x34: 1
    x35: 0
    x36: 1
    x37: 1
    x38: 0
    x39: 0
    x40: 1
    x41: 0
    x42: 1
    x43: 0
    x44: 1
    y00: 1
    y01: 1
    y02: 1
    y03: 1
    y04: 0
    y05: 0
    y06: 1
    y07: 1
    y08: 0
    y09: 0
    y10: 0
    y11: 1
    y12: 0
    y13: 1
    y14: 0
    y15: 1
    y16: 1
    y17: 1
    y18: 0
    y19: 0
    y20: 0
    y21: 0
    y22: 0
    y23: 0
    y24: 1
    y25: 0
    y26: 1
    y27: 0
    y28: 1
    y29: 0
    y30: 1
    y31: 0
    y32: 0
    y33: 0
    y34: 1
    y35: 1
    y36: 0
    y37: 0
    y38: 1
    y39: 1
    y40: 1
    y41: 0
    y42: 0
    y43: 1
    y44: 1

    rwb XOR ntb -> z31
    sgt XOR tgq -> z11
    ctd OR cnk -> ptc
    y36 AND x36 -> hwr
    y31 AND x31 -> vkm
    tqn OR cvv -> vsm
    vsm AND bnj -> psh
    ccs AND bsj -> mtm
    qts AND kvg -> jkh
    y21 AND x21 -> fmg
    jht XOR vgt -> z37
    y37 AND x37 -> bnw
    kvd OR twk -> ksj
    ksj XOR bhc -> z40
    qmd XOR fnh -> z43
    wpw AND ppn -> bdh
    x20 AND y20 -> snt
    y38 AND x38 -> mbt
    knh XOR jfn -> z38
    x13 XOR y13 -> fvr
    dwh AND tvp -> hng
    wrd AND npf -> prh
    y14 AND x14 -> dcr
    fvn AND bks -> fmj
    mrd XOR gdn -> z24
    x29 XOR y29 -> wpw
    qjq AND psp -> fbs
    x43 XOR y43 -> fnh
    x18 XOR y18 -> wkc
    y24 XOR x24 -> mrd
    y03 XOR x03 -> psp
    gqt OR dth -> fvn
    y12 XOR x12 -> gcm
    y16 AND x16 -> dnw
    x07 AND y07 -> djw
    kbc AND nkm -> dvh
    vrn XOR dkr -> kmb
    fbs OR wcf -> pkm
    x12 AND y12 -> vrv
    x34 AND y34 -> gbs
    qnc OR gbv -> dgv
    x15 XOR y15 -> kvg
    y22 AND x22 -> fpw
    jfm AND cst -> mgb
    y37 XOR x37 -> jht
    kqm XOR fvr -> z13
    vsd AND wrp -> jmq
    cqq XOR hqr -> z28
    x09 AND y09 -> qrc
    mmf XOR tsw -> z35
    bqb AND vfb -> vgj
    kvg XOR qts -> tvp
    x24 AND y24 -> gbv
    hsj OR bdh -> nkm
    y20 XOR x20 -> kpp
    fsh OR jkh -> z15
    x44 AND y44 -> gvw
    tvp XOR dwh -> z16
    x04 AND y04 -> pgh
    bhg AND hpj -> mqf
    y07 XOR x07 -> bks
    cgv XOR cmg -> z27
    vfb XOR bqb -> z21
    x19 AND y19 -> qhh
    y35 XOR x35 -> vdk
    y33 XOR x33 -> wrp
    y10 AND x10 -> kks
    trn OR vft -> gdn
    qhw OR vdk -> bsj
    dvh OR cfn -> rwb
    kwc OR qwc -> ppn
    x06 XOR y06 -> rrs
    tnp XOR ktg -> z19
    x11 XOR y11 -> sgt
    wfw OR pgh -> pst
    djw OR fmj -> cvp
    hqr AND cqq -> qwc
    y01 XOR x01 -> npf
    dqw OR rvr -> qmd
    y17 XOR x17 -> rrp
    y01 AND x01 -> tvb
    qrh AND hcq -> vft
    x11 AND y11 -> cnk
    rhk AND pkm -> wfw
    gdn AND mrd -> qnc
    y41 AND x41 -> rjg
    knh AND jfn -> brc
    y08 XOR x08 -> dqr
    jht AND vgt -> jcq
    cmd AND ttt -> sjm
    rrp XOR qqc -> z17
    cbq XOR fqm -> z32
    qmd AND fnh -> vkf
    y22 XOR x22 -> jfm
    x35 AND y35 -> mmf
    sjd XOR qjg -> z34
    bsj XOR ccs -> z36
    tnp AND ktg -> dss
    y02 XOR x02 -> dgk
    x34 XOR y34 -> sjd
    x04 XOR y04 -> rhk
    x03 AND y03 -> wcf
    x08 AND y08 -> cvv
    bhg XOR hpj -> z44
    hcv AND ckw -> cds
    npf XOR wrd -> z01
    x26 XOR y26 -> kch
    mbt OR brc -> qjf
    fpw OR mgb -> hcq
    cbq AND fqm -> qqp
    fvn XOR bks -> z07
    x26 AND y26 -> jrv
    kks OR kmb -> tgq
    rhm OR cts -> cmd
    nkm XOR kbc -> z30
    y36 XOR x36 -> ccs
    x18 AND y18 -> rwt
    mvm OR wvd -> dwm
    y40 XOR x40 -> bhc
    x21 XOR y21 -> vfb
    prh OR tvb -> nkn
    y25 AND x25 -> z25
    gbs OR nvt -> tsw
    rhk XOR pkm -> z04
    psp XOR qjq -> z03
    cbh OR vrv -> kqm
    y32 XOR x32 -> fqm
    cvp AND dqr -> tqn
    mqf OR gvw -> z45
    x27 XOR y27 -> cgv
    qwd OR dqj -> qjq
    y28 XOR x28 -> hqr
    x44 XOR y44 -> bhg
    wpw XOR ppn -> z29
    y39 XOR x39 -> wsm
    vrn AND dkr -> z10
    psh OR qrc -> dkr
    rrs AND dwm -> dth
    hcq XOR qrh -> z23
    fmg OR vgj -> cst
    dqr XOR cvp -> z08
    kpp XOR ngd -> z20
    ttt XOR cmd -> z14
    rjg OR cds -> nfp
    x10 XOR y10 -> vrn
    cmg AND cgv -> hqk
    dgv AND bpw -> gcj
    njn OR vkf -> hpj
    mvj OR jrv -> cmg
    x40 AND y40 -> bhd
    x41 XOR y41 -> ckw
    hvs XOR nfp -> z42
    dgk AND nkn -> qwd
    dpg OR gcj -> hpr
    x33 AND y33 -> ksh
    nrm OR snt -> bqb
    sgt AND tgq -> ctd
    wkc AND njf -> gnm
    y38 XOR x38 -> knh
    y25 XOR x25 -> bpw
    y42 AND x42 -> dqw
    ksh OR jmq -> qjg
    cst XOR jfm -> z22
    rrp AND qqc -> bhk
    wrp XOR vsd -> z33
    vkm OR dcg -> cbq
    y00 XOR x00 -> z00
    y17 AND x17 -> fhk
    y16 XOR x16 -> dwh
    bpw XOR dgv -> dpg
    sjm OR dcr -> qts
    jcq OR bnw -> jfn
    x32 AND y32 -> cch
    kch AND hpr -> mvj
    bhk OR fhk -> njf
    x28 AND y28 -> kwc
    fpr OR hqk -> cqq
    y05 AND x05 -> mvm
    hpr XOR kch -> z26
    ptc AND gcm -> cbh
    dkm OR bhd -> hcv
    x30 AND y30 -> cfn
    rwt OR gnm -> tnp
    mmf AND tsw -> qhw
    ngd AND kpp -> nrm
    y15 AND x15 -> fsh
    y43 AND x43 -> njn
    y00 AND x00 -> wrd
    x29 AND y29 -> hsj
    x02 AND y02 -> dqj
    y23 XOR x23 -> qrh
    y05 XOR x05 -> rdh
    y19 XOR x19 -> ktg
    dwm XOR rrs -> z06
    kqm AND fvr -> cts
    ptc XOR gcm -> z12
    y27 AND x27 -> fpr
    sjd AND qjg -> nvt
    x09 XOR y09 -> bnj
    mtm OR hwr -> vgt
    cch OR qqp -> vsd
    hng OR dnw -> qqc
    wsm AND qjf -> twk
    x23 AND y23 -> trn
    x30 XOR y30 -> kbc
    x39 AND y39 -> kvd
    bhc AND ksj -> dkm
    ckw XOR hcv -> z41
    rdh AND pst -> wvd
    dgk XOR nkn -> z02
    rwb AND ntb -> dcg
    x13 AND y13 -> rhm
    y42 XOR x42 -> hvs
    hvs AND nfp -> rvr
    y14 XOR x14 -> ttt
    y31 XOR x31 -> ntb
    wsm XOR qjf -> z39
    pst XOR rdh -> z05
    njf XOR wkc -> z18
    bnj XOR vsm -> z09
    dss OR qhh -> ngd
    x06 AND y06 -> gqt
    """

    let testInput =
    """
    x00: 1
    x01: 0
    x02: 1
    x03: 1
    x04: 0
    y00: 1
    y01: 1
    y02: 1
    y03: 1
    y04: 1

    ntg XOR fgs -> mjb
    y02 OR x01 -> tnw
    kwq OR kpj -> z05
    x00 OR x03 -> fst
    tgd XOR rvg -> z01
    vdt OR tnw -> bfw
    bfw AND frj -> z10
    ffh OR nrd -> bqk
    y00 AND y03 -> djm
    y03 OR y00 -> psh
    bqk OR frj -> z08
    tnw OR fst -> frj
    gnj AND tgd -> z11
    bfw XOR mjb -> z00
    x03 OR x00 -> vdt
    gnj AND wpb -> z02
    x04 AND y00 -> kjc
    djm OR pbm -> qhw
    nrd AND vdt -> hwm
    kjc AND fst -> rvg
    y04 OR y02 -> fgs
    y01 AND x02 -> pbm
    ntg OR kjc -> kwq
    psh XOR fgs -> tgd
    qhw XOR tgd -> z09
    pbm OR djm -> kpj
    x03 XOR y03 -> ffh
    x00 XOR y04 -> ntg
    bfw OR bqk -> z06
    nrd XOR fgs -> wpb
    frj XOR qhw -> z04
    bqk OR frj -> z07
    y03 OR x01 -> nrd
    hwm AND bqk -> z03
    tgd XOR rvg -> z12
    tnw OR pbm -> gnj
    """

    override func viewDidLoad() {
        super.viewDidLoad()

        parse()
        part1()
        part2()
    }

    var strings: [String] = []
    var dict: [String: Int] = [:]
    var actions: [Action] = []

    func parse() {
//        strings = testInput.split(separator: "\n")
        strings = input.split(separator: "\n")
            .map({ String($0) })

        for string in strings {
            if string.contains(":") {
                let parts = string.components(separatedBy: ": ")
                dict[parts[0]] = Int(parts[1]) ?? 0
            } else {
                let parts = string.components(separatedBy: " ")
                let operand1 = parts[0]
                let operand2 = parts[2]
                let operation = Operation(string: parts[1])
                let resultTarget = parts[4]

                let action = Action(operand1: operand1,
                                    operand2: operand2,
                                    operation: operation,
                                    resultTarget: resultTarget)
                actions.append(action)
            }
        }
    }

    func part1() {
        var index = 0
        while !actions.isEmpty {
            let action = actions[index]
            if action.performOperation(dict: &dict) {
                actions.remove(at: index)
                if !actions.isEmpty {
                    index = index % actions.count
                }
            } else {
                index = (index + 1) % actions.count
            }
        }

        let binaryResult = dict
            .filter({ $0.key.contains("z") })
            .sorted(by: { $0.key >= $1.key })
            .map({ $0.value })
            .map({ String($0) })
            .joined()

        let result = Int(binaryResult, radix: 2)!
        print(result)
    }

    func part2() {
    }
}

struct Action {
    let operand1: String
    let operand2: String
    let operation: Operation
    let resultTarget: String

    func performOperation(dict: inout [String: Int]) -> Bool {
        guard let value1 = dict[operand1],
              let value2 = dict[operand2]
        else { return false }

        let result: Int
        switch operation {
        case .and:
            result = value1 & value2
        case .or:
            result = value1 | value2
        case .xor:
            result = value1 ^ value2
        }

        dict[resultTarget] = result
        return true
    }
}

enum Operation {
    case and
    case or
    case xor

    init(string: String) {
        switch string {
        case "AND":
            self = .and
        case "OR":
            self = .or
        case "XOR":
            self = .xor
        default:
            fatalError()
        }
    }
}
