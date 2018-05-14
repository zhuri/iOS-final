//
//  ImageViewController.swift
//  GrupiX-Final
//
//  Created by Cacttus Education 12 on 5/9/18.
//  Copyright © 2018 Cacttus Education 12. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var image: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension ImageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! ImageViewCell
        
        let url:URL = URL.init(fileURLWithPath: "https://picsum.photos/200/300?random")
        load(url: url)
        cell.imageView.image = self.image
        
        return cell
    }
    
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension ImageViewController: UICollectionViewDelegate {
    
}
