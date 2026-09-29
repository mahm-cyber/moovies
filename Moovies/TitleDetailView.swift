//
//  TitleDetailView.swift
//  Moovies
//
//  Created by NamaaIT Apple3 on 29/09/2026.
//

import SwiftUI

struct TitleDetailView: View {
    let title: Title
    
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                LazyVStack(alignment: .leading) {
                    AsyncImage(url: URL(string: title.posterPath ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    }placeholder: {
                        ProgressView()
                           
                    }
                    .frame(
                        width: geo.size.width,
                        height: geo.size.height * 0.85
                    )
                    
                    Text(title.name ?? title.title ?? "")
                        .bold()
                        .font(.title2)
                        .padding(5) 
                    
                    Text(title.overview ?? "")
                        .padding(5)
                }
            }
        }
    }
}

#Preview {
    TitleDetailView(title: Title.previewTitles[0])
}
