//
//  ViewController.swift
//  MachinelLearningImageRecognitionSwift
//
//  Created by Taha Turan on 1.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func changeButtonClicked(_ sender: Any) {
        selectImage()
      
        
    }
    
}


//MARK: Resim Secim Islemleri
extension ViewController: UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        
        self.dismiss(animated: true)
    }
    
}

