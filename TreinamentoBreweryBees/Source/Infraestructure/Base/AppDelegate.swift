//
//  AppDelegate.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 27/03/24.
//

import Firebase
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureFirebase()
        
        //Configurar Remote Config
        ///Atribuir os valores no dictionary
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

extension AppDelegate {
    private func configureFirebase() {
        FirebaseApp.configure()
        
        let logger = Logger(category: "BreweryFirebase")
        logger.log(message: "FirebaseApp configurado!", level: .info)
    }
}

