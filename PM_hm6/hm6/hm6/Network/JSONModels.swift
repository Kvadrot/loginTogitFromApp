//
//  JSONModels.swift
//  hm6
//
//  Created by 1 on 23.02.2021.
//

import Foundation

//MARK: JSON for Images
struct AllImages: Codable {
    
    var images: [ImageForFetchingDetails]?
}

struct ImageForFetchingDetails: Codable {
    var name: String
    var download_url: String
}
