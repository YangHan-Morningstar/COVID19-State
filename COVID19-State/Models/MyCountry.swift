//
//  MyCountry.swift
//  COVID19-State
//
//  Created by Tony Young on 2020/7/25.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import Foundation

struct MyCountry: Decodable {
    var timeline: [String: [String: Int]]
}
