//
//  YoutubePlayer.swift
//  Moovies
//
//  Created by NamaaIT Apple3 on 30/09/2026.
//

import SwiftUI
import WebKit


struct YoutubePlayer: UIViewRepresentable {
    let webView = WKWebView()
    let videoId: String
    let youtubeBaseURL = APIConfig.shared?.youtubeBaseURL
    
    
    func makeUIView(context: Context) -> some UIView {
        webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let baseURLString = youtubeBaseURL,
              let baseURL = URL(string: baseURLString) else {
            return
        }
        
        let fullURL = baseURL.appending(path: videoId)
       var request =  URLRequest(url: fullURL)
        
        request
            .setValue(
                "https://\(Bundle.main.bundleIdentifier ?? "")",
                forHTTPHeaderField: "Referer"
            )
        
        webView.load(request)
    }
}
