//
//  StorageManager.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 07/06/24.
//

import Foundation
import FirebaseStorage
import UIKit

final class StorageManager
{
    static let shared = StorageManager()
    private let storage = Storage.storage().reference()
    public typealias UploadPictureCompletion = (Result<String, Error>) -> Void
    
    // image format - /images/misty-gmail-com_profile_picture.png
    
    public func  uploadProfilePicure(with data: Data, filename: String, completion: @escaping UploadPictureCompletion)
    {
        storage.child("images/\(filename)").putData(data, metadata: nil, completion: { metadata, error in
            guard error  == nil else {
                print("failed to upload data to firabase for picture")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            self.storage.child("images/\(filename)").downloadURL(completion: { url, error in
                guard let url = url else
                {
                    print("Failed to get download url")
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    return
                }
                
                let urlString = url.absoluteString
                print("download url returned: \(urlString)")
                completion(.success(urlString))
            })
        
        })
    }
                                                    
    public enum StorageErrors: Error
    {
            case failedToUpload
            case failedToGetDownloadUrl
        
        }
      
    
    public func downloadURL(for path: String, completion: @escaping (Result<URL, Error>) -> Void)
    {
        let reference = storage.child(path)
        reference.downloadURL(completion: { url, error in
            guard let ur = url, error == nil else {
                completion(.failure(StorageErrors.failedToGetDownloadUrl))
                return
            }
            completion(.success(url!))
        })
    }
}
