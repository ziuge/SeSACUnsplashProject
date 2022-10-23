//
//  UnsplashViewModel.swift
//  SeSACUnsplashProject
//
//  Created by CHOI on 2022/10/23.
//

class ViewModel {
    
    func requestRandomPhoto() {
        APIService.randomPhoto { photo, statusCode, error in
            guard let photo = photo else { return }
            
        }
    }
    
}
