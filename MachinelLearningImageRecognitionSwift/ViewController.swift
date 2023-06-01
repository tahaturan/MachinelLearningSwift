//
//  ViewController.swift
//  MachinelLearningImageRecognitionSwift
//
//  Created by Taha Turan on 1.06.2023.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    
    var chosenImage = CIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func changeButtonClicked(_ sender: Any) {
        selectImage()
      
        
    }
    
}


//MARK: -Resim Secim Islemleri
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
        
        if let ciImage = CIImage(image: imageView.image!){
            chosenImage = ciImage
        }
        
        recognizeImage(image: chosenImage)
    }
    
}


//MARK: -Resim tanima icin fonksiyonlar
extension ViewController{
    //MARK: ne oldugunu anlamak icin
    func recognizeImage(image: CIImage)  {
        
        //resimleri tanimak icin adimlarimiz
        // 1-) request olusturmak
        // 2-) request in handler edilmesi
        
        
        if let model = try? VNCoreMLModel(for: MobileNetV2().model){
            //Request Olsuturma
            let request = VNCoreMLRequest(model: model) { vnrequest , error in
                
                if let results = vnrequest.results as? [VNClassificationObservation]{
                    
                    if results.count > 0 {
                        let topResult = results.first
                        
                        DispatchQueue.main.async {
                            let confidenceLevel = (topResult?.confidence ?? 0) * 100 // yuzde kac ihtimalle
                            self.resultLabel.text = "\(confidenceLevel)% it's \(topResult!.identifier)" // sonucunda ne cikti
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
        
        
    }
}
