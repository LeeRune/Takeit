//
//  MovieImage.swift
//  Takeit_iOS
//
//  Created by 傅培禎 on 2021/3/8.
//

import UIKit

class MovieImage: UIViewController {
    var movie01 : Movie!
    @IBOutlet weak var movieImage01: UIImageView!
    @IBOutlet weak var movieName01: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movie01.name
        movieImage01.image = movie01.image
        movieName01.text = "影名: \(movie01.name!)"
        
        movieName01.text = "影名: \(movie01.name!)\n \(String(movie01.detail))"

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
