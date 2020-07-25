//
//  DataViewModel.swift
//  COVID19-State
//
//  Created by Tony Young on 2020/7/25.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import Foundation
import SwiftUI

class DataViewModel: ObservableObject {
    
    @Published var mainData: MainData!
    @Published var daily: [Daily] = []
    @Published var last: Int = 0
    
    var sumURL: String
    var historyURL: String
    var sumSession: URLSession
    var historySession: URLSession
    
    init() {
        sumURL = ""
        historyURL = ""
        sumSession = URLSession(configuration: .default)
        historySession = URLSession(configuration: .default)
    }
    
    func getCountryData(country: String) {
        sumURL = "https://corona.lmao.ninja/v2/countries/\(country.lowercased())?yesterday=false"
        historyURL = "https://corona.lmao.ninja/v2/historical/\(country.lowercased())?lastdays=7"
        
        sumDecodeTask()
        historyDecodeTask(index: 0)
    }
    
    func getGlobalData() {
        sumURL = "https://corona.lmao.ninja/v2/all?today"
        historyURL = "https://corona.lmao.ninja/v2/historical/all?lastdays=7"
        
        sumDecodeTask()
        historyDecodeTask(index: 1)
    }
    
    func sumDecodeTask() {
        
        sumSession.dataTask(with: URL(string: sumURL)!) { (data, _, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            let json = try! JSONDecoder().decode(MainData.self, from: data!)
            
            DispatchQueue.main.async {
                self.mainData = json
            }
        }
        .resume()
    }
    
    func historyDecodeTask(index: Int) {
        sumSession.dataTask(with: URL(string: historyURL)!) { (data, _, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            var count = 0
            var cases: [String: Int] = [:]
            
            if index == 0 {
                let json = try! JSONDecoder().decode(MyCountry.self, from: data!)
                cases = json.timeline["cases"]!
            } else {
                let json = try! JSONDecoder().decode(Global.self, from: data!)
                cases = json.cases
            }
            
            DispatchQueue.main.async {
                for i in cases {
                    self.daily.append(Daily(count: count, day: i.key, cases: i.value))
                    count += 1
                }
                
                self.daily.sort { (t, t1) -> Bool in
                    if t.day < t1.day {
                        return true
                    } else {
                        return false
                    }
                }
                
                self.last = self.daily.last!.cases
            }
        }
        .resume()
    }
    
    func getCapsuleHeight(value: Int, height: CGFloat) -> CGFloat {
        if last != 0 {

            let converted = CGFloat(value) / CGFloat(last)

            return converted * height
        } else {
            return 0
        }
    }
}
