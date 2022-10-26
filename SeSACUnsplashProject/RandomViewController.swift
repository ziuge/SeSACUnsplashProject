//
//  RandomViewController.swift
//  SeSACUnsplashProject
//
//  Created by CHOI on 2022/10/22.
//

import UIKit
import Kingfisher

class RandomViewController: UIViewController {

    @IBOutlet weak var randomImageView: UIImageView!
    
    var viewModel = ViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.requestRandomPhoto()
        
//        viewModel.randomPhoto.bind { photo in
//            DispatchQueue.global().async {
//                print(photo)
//                let url = URL(string: photo.urls.thumb)!
//                let data = try? Data(contentsOf: url)
//                DispatchQueue.main.async {
//                    self.randomImageView.image = UIImage(data: data!)
//                }
//            }
//        }
        
    }

    
    
}

extension RandomViewController {
    
}
