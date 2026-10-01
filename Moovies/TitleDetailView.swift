//
//  TitleDetailView.swift
//  Moovies
//
//  Created by NamaaIT Apple3 on 29/09/2026.
//

import SwiftUI
import SwiftData

struct TitleDetailView: View {
    let title: Title
    var titleName: String {
        return (title.name ?? title.title ) ?? ""
    }
    
    let viewModel = ViewModel()
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        GeometryReader { geo in
            switch viewModel.videoIdStatus {
            case .notStarted:
                EmptyView()
            case .fetching:
                ProgressView()
                    .frame(width: geo.size.width, height: geo.size.height)
            case .success:
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        YoutubePlayer(videoId: viewModel.videoId)
                            .aspectRatio(1.3, contentMode: .fit)
                        
                        Text(titleName)
                            .bold()
                            .font(.title2)
                            .padding(5)
                        
                        Text(title.overview ?? "")
                            .padding(5)
                        
                        HStack {
                            Spacer()
                            
                            Button {
                                let saveTitle = title
                                saveTitle.title = titleName
                                modelContext.insert(saveTitle)
                                try? modelContext.save()
                            } label: {
                                Text(Constants.downloadString)
                                    .ghostButton()
                            }
                            
                            Spacer()
                        }
                       
                    }
                }
            case .failed(let underlyingError):
                Text(underlyingError.localizedDescription)
            }
        }
        .task {
            await viewModel.getVideoId(for: titleName)
        }
    }
}

#Preview {
    TitleDetailView(title: Title.previewTitles[0])
}
