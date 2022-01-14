//
//  Constants.swift
//  SwiftMVVM
//
//  Created by Sandeep Kolankar on 13/01/22.
//

import Foundation

enum SocialLoginType: Int {
    case google = 0
    case faceBook
    case apple
}

struct Constants {
    
    struct CellIdentifier {
        static let postCellIdentifier = "PostCell"
    }
    
    struct URLs {
        static let postsUrl = "https://jsonplaceholder.typicode.com/posts"
    }
    
    struct Message {
        static let logoutWarning = "Are you sure you want to logout?"
        static let error = "Error!"
        static let ok = "Ok"
    }
    
    struct Login {
        static let usernameEmptyMessage = "Please Enter Username"
        static let passwordEmptyMessage = "Please Enter Password"
        static let usernameErrorMessage = "Entered Username is invalid"
        static let passwordErrorMessage = "Password length must be in range 6-10 characters."
        static let userLoggedInMessage  = "User logged in successfully"
    }
    
    struct Logout {
        static let cancel  = "Cancel"
        static let logbout = "Logout"
    }
    
}
