//
//  RandomPhoto.swift
//  SeSACUnsplashProject
//
//  Created by CHOI on 2022/10/23.
//

struct RandomPhoto: Codable, Hashable {
    let id: String
    let color: String
    let likes: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case color
        case likes
    }
}

struct Urls: Codable, Hashable {
    let raw, full, regular, small: String
    let thumb, smallS3: String

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}
