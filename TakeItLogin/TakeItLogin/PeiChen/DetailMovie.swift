//
//  DetailMovie.swift
//  Tackit
//
//  Created by 傅培禎 on 2021/3/10.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class DetailMovie: UIViewController {

    @IBOutlet weak var movieImage01: UIImageView!
    @IBOutlet weak var movieLabel01: UILabel!
    var movies01 : MovieByPei!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let _ : MovieByPei
        let urlSring = "URL"
        if URL(string: urlSring) != nil {
        let task = URLSession.shared.dataTask(with: URL(string: movies01.poster)!) { (data, response, error) in
                 if let  data = data {
                    DispatchQueue.main.async {
                        self.movieImage01.image = UIImage(data: data)
                    }
                 }
                 else{
                    print("err: \(String(describing: error))")
            }
            
        }
            task.resume()

    }
    
        
        
        
        
        
        self.title = movies01.movieName
        movieImage01.image = movies01.image
        movieLabel01.text = "影名: \(movies01.movieName)\n\(String(movies01.intro))"
    }


    }
    

    

