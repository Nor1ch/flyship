//
//  ProfileManager.swift
//  FlyingShip
//
//  Created by Nor1 on 14.07.2023.
//

import Foundation
import Combine

private enum Keys: String {
    case imageKey
    case profilesKey
}

//MARK: - менеджер всех профилей игроков

final class ProfileManager {
    static var shared = ProfileManager()
    private init(){
        self.profiles = UserDefaults.standard.value([Profile].self, forKey: Keys.profilesKey.rawValue) ?? []
    }
    @Published var profiles: [Profile] = [] {
        didSet {
            saveProfiles()
        }
    }
    var currentProfile: Profile?
    
    func saveProfiles() {
        DispatchQueue.global().async {
            UserDefaults.standard.set(encodable: self.profiles, forKey: Keys.profilesKey.rawValue)
        }
    }
    func updateProfile(profile: Profile){
            let index = profiles.firstIndex(where: {$0.name == profile.name})
            if let index = index {
                profiles.remove(at: index)
                profiles.insert(profile, at: 0)
        }
    }
}
