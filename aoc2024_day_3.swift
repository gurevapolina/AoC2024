import Foundation

let input =
"""
"""

let strings = input.split(separator: "\n", omittingEmptySubsequences: true).map({ String($0) })
let string = strings.first ?? ""

// PART 1

let regex = try! Regex(#"mul\(\d{1,3},\d{1,3}\)"#)

let result1: Int = string.ranges(of: regex)
    .map({
        String(string.substring(with: $0))
            .replacingOccurrences(of: "mul(", with: "")
            .replacingOccurrences(of: ")", with: "")
    })
    .map({ args in
        let split = args.split(separator: ",").compactMap({ Int(String($0)) })
        return split[0] * split[1]
    })
    .reduce(0, { $0 + $1 })


print(result1)

// PART 2

let regex2 = try! Regex(#"mul\(\d{1,3},\d{1,3}\)|don't\(\)|do\(\)"#)

let filtered = string.ranges(of: regex2)
    .map({
        String(string.substring(with: $0))
            .replacingOccurrences(of: "mul(", with: "")
            .replacingOccurrences(of: ")", with: "")
    })
    .map({ args in
        if args.contains(",") {
            let split = args.split(separator: ",").compactMap({ Int(String($0)) })
            return "\(split[0] * split[1])"
        } else {
            return args
        }
    })

var result2 = 0

var include = true
for op in filtered {
    if op.starts(with: "don") {
        include = false
    } else if op.starts(with: "do") {
        include = true
    } else if include {
        result2 += (Int(op) ?? 0)
    }
}

print(result2)
