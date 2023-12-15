//
//  FeedImageViewModel.swift
//  EssentialFeediOS
//
//  Created by Zoltan Damo on 13/12/2023.
//

struct FeedImageViewModel<Image> {
    let description: String?
 	let location: String?
 	let image: Image?
 	let isLoading: Bool
 	let shouldRetry: Bool

    var hasLocation: Bool {
             return location != nil
         }
}
