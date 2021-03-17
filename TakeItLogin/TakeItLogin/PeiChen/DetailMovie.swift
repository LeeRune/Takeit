//
//  DetailMovie.swift
//  Tackit
//
//  Created by 傅培禎 on 2021/3/10.
//

import UIKit

class DetailMovie: UIViewController {

    @IBOutlet weak var movieImage01: UIImageView!
    @IBOutlet weak var movieLabel01: UILabel!
    var movies01 : MovieByPei!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movies01.name
        movieImage01.image = movies01.image
        movieLabel01.text = "影名: \(movies01.name!)\n\(String(movies01.detail))"
    }


    }
    

    

