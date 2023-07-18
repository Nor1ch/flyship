//
//  UserDefaults+extension.swift
//  FlyingShip
//
//  Created by Nor1 on 12.07.2023.
//

import Foundation
import UIKit

extension UserDefaults {
    
//MARK: - save and load custom objects and structs
    
    func set<T: Encodable>(encodable: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        }
    }
    
    func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = object(forKey: key) as? Data,
            let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
    
//MARK: - save and load images from file
    
    func saveImage(image: UIImage) -> String? {
            guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
            
            let fileName = UUID().uuidString
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            guard let data = image.jpegData(compressionQuality: 1) else { return nil}
            
            //Checks if file exists, removes it if so.
            if FileManager.default.fileExists(atPath: fileURL.path) {
                do {
                    try FileManager.default.removeItem(atPath: fileURL.path)
                    print("Removed old image")
                } catch let error {
                    print("couldn't remove file at path", error)
                }
                
            }
            
            do {
                try data.write(to: fileURL)
                return fileName
            } catch let error {
                print("error saving file with error", error)
                return nil
            }
            
        }
        
        func loadImage(fileName: String) -> UIImage? {
            guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil } // получили имя папки, где должен лежать файл
            let fileURL = documentsDirectory.appendingPathComponent(fileName) // добавили имя файла к имени папки
            let image = UIImage(contentsOfFile: fileURL.path) // прочитали файл, превратив его в UIImage
            return image // вернули картинку
        }
}
