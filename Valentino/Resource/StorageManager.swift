//
//  StorageManager.swift
//  Valentino
//
//  Created by Liu John on 2022-03-14.
//

import FirebaseStorage

public class StorageManager{
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    
    public enum VLStorageManagerError: Error {
        case failedToDownload
    }

    // MARK: - Public
    
    public func uploadUserPost(model: UserPost, completion: @escaping (Result<URL, Error>) -> Void) {
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL, VLStorageManagerError>) -> Void) {
        bucket.child(reference).downloadURL { (url, error) in
            guard let url = url, error == nil else {
                completion(.failure(.failedToDownload))
                return
            }
            
            completion(.success(url))
        }
    }
    
}

public enum UserPostType {
    case photo, video
}

public struct UserPost {
    let postType: UserPostType
    
}
