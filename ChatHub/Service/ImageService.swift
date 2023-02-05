//
//  ImageService.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 05/02/2023.
//

import Foundation
import Firebase
import FirebaseStorage
import RxSwift

final class ConcreteImageService {
    
    let userService = ConcreteUserService()
    
    private let disposeBag = DisposeBag()
    
    private func uploadImage(image: UIImage, completion: @escaping (String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        let filename = NSUUID().uuidString
        let refrence = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        refrence.putData(imageData) { metadat, error in
            refrence.downloadURL { result in
                switch result {
                case .success(let url):
                    let urlString = url.absoluteString
                    completion(urlString)
                case .failure:
                    return
                }
            }
        }
    }
    
    func uploadProfileImage(_ image: UIImage) {
        guard let uid = userService.userSession?.uid else { return }

        uploadImage(image: image) { imageUrl in
            Firestore.firestore().collection("users").document(uid).updateData(["profileImageUrl": imageUrl]) { error in
                guard error == nil else {
                    return
                }
            }
        }
    }
}