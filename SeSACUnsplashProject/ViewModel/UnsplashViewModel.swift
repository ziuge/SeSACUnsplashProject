//
//  UnsplashViewModel.swift
//  SeSACUnsplashProject
//
//  Created by CHOI on 2022/10/23.
//

import Foundation
import RxSwift

enum PhotoError: Error {
    case noPhoto
    case serverError
}

class ViewModel {
    
    var randomPhoto: CObservable<RandomPhoto> = CObservable(RandomPhoto(id: "", color: "", urls: Urls(raw: "", full: "", regular: "", small: "", thumb: "", smallS3: ""), likes: 0))
    var listPhoto = PublishSubject<PhotoResult>()
    
    func requestRandomPhoto() {
        print(#function)
        APIService.randomPhoto { photo, statusCode, error in
            guard let photo = photo else { return }
            self.randomPhoto.value = photo
        }
    }
    
    func requestListPhoto() {
        print(#function)
        APIService.listPhoto { [weak self] photo, statusCode, error in
            print(photo, statusCode, error)
            
            guard let statusCode = statusCode, statusCode == 200 else {
                self?.listPhoto.onError(PhotoError.serverError)
                return
            }
            
            guard let photo = photo else {
                self?.listPhoto.onError(PhotoError.noPhoto)
                return
            }
            
            self?.listPhoto.onNext(photo)
            print("listPhoto", self?.listPhoto)
        }
    }

}
