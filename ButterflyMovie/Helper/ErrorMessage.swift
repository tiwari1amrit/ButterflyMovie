//
//  ErrorMessage.swift
//  Inks
//
//  Created by Amrit Tiwari on 9/1/2023.
//

import Foundation

struct ErrorMessage {

    static let noContentAvailable = "No content available"

}

struct Errors {
    struct Validation {

        static let error = "Error!"
        static let success = "Success!"
        static let warning = "Warning!"
    }

    struct Apis {

        static let noInternet = "The Internet connection appears Offline."
        static let error = "Error"
        static let serverError = "Server Error. Try again"

        static let tokenExpired = "Login Token Expired! Login Again."

        static let unableToFetch = "Unable to fetch data. Try again"

    }

    struct Parse {
        static let parseError = "Can't able to parse data"
    }

    static let titleIsEmpty = "Title field is empty"

    static let imageNotFound = "Unable to find image"

    static let descriptionFieldEmpty = "Description field is empty"

}
