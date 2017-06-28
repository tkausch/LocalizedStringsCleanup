//
//  main.swift
//  LocalizedCleanup
//
//  Created by Thomas Kausch on 28.06.17.
//  Copyright © 2017 Thomas Kausch. All rights reserved.
//

import Foundation


func unwrapp(_ stringValue: String, _ offsetAtEnd: Int) -> String {
    let trimmed = stringValue.trimmingCharacters(in:.whitespacesAndNewlines)
    let start = trimmed.index(trimmed.startIndex, offsetBy: 1)
    let end = trimmed.index(trimmed.endIndex, offsetBy: offsetAtEnd)
    let range = start..<end
    return trimmed.substring(with: range)
}



if CommandLine.arguments.count < 2 {
    print("Usage: LocalizedCleanup <inputFile>" )
    abort()
}


// Get path to input and output file
let cwd = FileManager.default.currentDirectoryPath
let inputFilePath = cwd + "/" + CommandLine.arguments[1];


var localizedStrings = [String:String]()


// read and cleanup Localized.strings input
do {
    let data = try String(contentsOfFile: inputFilePath, encoding: .utf8)
    let lines = data.components(separatedBy: .newlines)
    for line in lines {
        let lineTokens = line.components(separatedBy: "=")
        if lineTokens.count == 2 {
            let key = unwrapp(lineTokens[0],-1)
            let value = unwrapp(lineTokens[1],-2)
            if !localizedStrings.keys.contains(key) {
                localizedStrings[key] = value
            } else {
                if localizedStrings[key] != value {
                    var i = 1
                    while localizedStrings.keys.contains("\(key).\(i)") {
                        i += 1
                    }
                    localizedStrings["\(key).\(i)"] = value
                }
            }
        } else {
            // Skip invalid lines
        }
    }
} catch {
    print(error)
}


// write localizedString to file
let sortedKeys = Array(localizedStrings.keys).sorted(by: <)

for key in sortedKeys {
    if let value = localizedStrings[key] {
        let line = String(format:"\"%@\" = \"%@\";", key, value)
        print(line)
    }
}
