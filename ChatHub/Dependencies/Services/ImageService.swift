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

protocol ImageService {
    func uploadProfileImage(_ image: UIImage) -> Observable<Void>
}

final class ConcreteImageService: ImageService {
    
    private let userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }
        
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
    
    func uploadProfileImage(_ image: UIImage) -> Observable<Void> {
        return Observable.create { observer in
            guard let uid = self.userService.userSession?.uid else { return Disposables.create() }
            self.uploadImage(image: image) { imageUrl in
                Firestore.firestore().collection("users").document(uid).updateData(["profileImageUrl": imageUrl]) { error in
                    guard error == nil else {
                        guard let error = error else { return }
                        observer.onError(error)
                        return
                    }
                    observer.onNext(())
                    observer.onCompleted()
                }
            }
            
            return Disposables.create()

        }
                
    }
}
