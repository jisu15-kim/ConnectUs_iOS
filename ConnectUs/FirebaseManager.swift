//
//  FirebaseManager.swift
//  instagram_ios_jason
//
//  Created by κΉμ§μ on 2023/01/05.
//

import UIKit
import FirebaseStorage

class FirebaseManager {
    let storage = Storage.storage()
    
    static func uploadImage(image: UIImage, completion: @escaping (URL?) -> Void) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.3) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        let imageName = UUID().uuidString + String(Date().timeIntervalSince1970)
        
        let firebaseReference = Storage.storage().reference().child("\(imageName)")
        firebaseReference.putData(imageData, metadata: metaData) { metaData, error in
            firebaseReference.downloadURL { url, _ in
                print("π₯π₯π₯π₯π₯π₯π₯π₯π₯μλ‘λ μ±κ³΅")
                completion(url)
            }
        }
    }
}
