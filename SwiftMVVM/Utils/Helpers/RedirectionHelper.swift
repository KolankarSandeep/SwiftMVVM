//
//  RedirectionHelper.swift
//  SwiftMVVM
//
//  Created by Sandeep Kolankar on 11/01/22.
//


import UIKit

struct RedirectionHelper {
    static func redirectToLogin() {
        DispatchQueue.main.async {
            let dashboardVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            windowScene.keyWindow?.rootViewController = dashboardVC
            windowScene.keyWindow?.makeKeyAndVisible()
        }
    }

    static func redirectToDashboard() {
        DispatchQueue.main.async {
            let dashboardVC = UIStoryboard(name: "Dashboard", bundle: nil).instantiateInitialViewController()
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            windowScene.keyWindow?.rootViewController = dashboardVC
            windowScene.keyWindow?.makeKeyAndVisible()
        }
    }
}
