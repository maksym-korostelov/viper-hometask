//
//  Resources.swift
//  homeTask1_MVVMC_v2
//
//  Created by Maksym Korostelov on 12/8/19.
//  Copyright © 2019 Maksym Korostelov. All rights reserved.
//

import Foundation

enum Constants {
    static var randomDataUrl: URL? {
        return URL(string:
            "https://www.random.org/strings/?num=10&len=8&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new")
    }
}
