//
//  Indicator.swift
//  COVID19-State
//
//  Created by Tony Young on 2020/7/25.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import Foundation
import SwiftUI

struct Indicator: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        
        return view
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
    }
}
