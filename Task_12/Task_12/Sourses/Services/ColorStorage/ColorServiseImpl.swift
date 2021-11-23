//
//  ColorServiseImpl.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 15.11.2021.
//

import Foundation

class ColorServiceImpl {
    
    var walletColors: [Color] = [Color(name: "Celadon"), Color(name: "Deep Saffron"), Color(name: "Pink"), Color(name: "Green Blue Crayola"), Color(name: "Amaranth Red")]
    
}

extension ColorServiceImpl: ColorService {
    
    func color() -> [Color] {
        return walletColors
    }
}
