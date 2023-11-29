//
//  FeedItem.swift
//  Essential Feed
//
//  Created by Zoltan Damo on 2023. 09. 08..
//

import Foundation

public struct FeedImage : Equatable {
    public let id: UUID
    public let description: String?
    public let location: String?
    public let url: URL

    public init(id: UUID, description: String?, location: String?, url: URL) {
		self.id = id
		self.description = description
		self.location = location
		self.url = url
	}
}