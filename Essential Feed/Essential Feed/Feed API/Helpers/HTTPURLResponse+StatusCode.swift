//
//  HTTPURLResponse+StatusCode.swift
//  Essential Feed
//
//  Created by Zoltan Damo on 19/12/2023.
//

import Foundation

extension HTTPURLResponse {
    private static var OK_200: Int { return 200 }

    var isOK: Bool {
        return statusCode == HTTPURLResponse.OK_200
    }
}
