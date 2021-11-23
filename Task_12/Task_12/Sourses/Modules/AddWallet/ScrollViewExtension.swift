//
//  ScrollViewExtension.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 02.11.2021.
//

import UIKit

extension UIScrollView {
    func setContentInsetAndScrollIndicatorInsets(_ edgeInsets: UIEdgeInsets) {
        self.contentInset = edgeInsets
        self.scrollIndicatorInsets = edgeInsets
    }
}
