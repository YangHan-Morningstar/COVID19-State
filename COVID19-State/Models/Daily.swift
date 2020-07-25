//
//  Daily.swift
//  COVID19-State
//
//  Created by Tony Young on 2020/7/25.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import Foundation

struct Daily: Identifiable {
    var id = UUID()
    var count: Int
    var day: String
    var cases: Int
}
