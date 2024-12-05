import Foundation

let input1 =
"""
"""

let input2 =
"""
"""

let strings = input1.split(separator: "\n", omittingEmptySubsequences: true)
    .map({
        String($0)
            .split(separator: "|", omittingEmptySubsequences: true)
            .map({ String($0) })
    })
let rules = strings
    .map({
        (Int($0[0]) ?? 0, Int($0[1]) ?? 0)
    })

let records = input2.split(separator: "\n", omittingEmptySubsequences: true)
    .map({
        String($0)
            .split(separator: ",", omittingEmptySubsequences: true)
            .compactMap({ Int(String($0)) })
    })

var dict: [Int: [Int]] = [:]
for rule in rules {
    if let array = dict[rule.1] {
        dict[rule.1] = array + [rule.0]
    } else {
        dict[rule.1] = [rule.0]
    }
}


func middleNumber(_ array: [Int]) -> Int {
    return array[array.count / 2]
}

// PART 1

var result = 0

func validRecord(_ record: [Int]) -> Bool {
    var banned: [Int] = []
    for elem in record {
        
        if banned.contains(elem) {
            return false
        }
        banned += (dict[elem] ?? [])
    }
    
    return true
}

for record in records {
    if validRecord(record) {
        result += middleNumber(record)
    }
}

print(result)

// PART 2

var result2 = 0

func fixRecord(_ record: [Int]) -> [Int] {
    return record.sorted { dict[$0]?.contains($1) ?? true }
}

for record in records {
    if !validRecord(record) {
        let fixed = fixRecord(record)
        result2 += middleNumber(fixed)
    }
}

print(result2)
