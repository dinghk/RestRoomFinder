//
//  HomeScreen.swift
//  RestRoomFinder
//
//  Created by Mohammad Azam on 10/14/20.
//

import SwiftUI
import Combine

struct HomeScreen: View {
    
    @ObservedObject private var locationManager = LocationManager()
    @EnvironmentObject var store: Store<AppState>
    @State private var cancellables: AnyCancellable? = nil
    
    struct Props {
        let restrooms: [Restroom]
        let onFetchRestroomByLatLng: (Double, Double) -> Void
    }
    
    private func map(state: RestroomState) -> Props {
        Props(restrooms: state.restroom, onFetchRestroomByLatLng: { (lat, lng) in
            store.dispatch(action: FetchRestroomAction(latitude: lat, longitude: lng))
        })
    }
    
    var body: some View {
        let props = map(state: store.state.restrooms)
        
        VStack(alignment: .leading) {
            VStack {
                HStack {
                    EmptyView()
                }.frame(maxWidth: .infinity, maxHeight: 44)
                Spacer()
                
                HStack {
                    Text("Restrooms")
                        .foregroundColor(Color.white)
                        .font(.largeTitle)
                    Spacer()
                    Button(action: {
                        // update location
                        locationManager.updateLocation()
                    }, label: {
                        Image(systemName: "arrow.clockwise.circle")
                            .font(.title)
                            .foregroundColor(Color.white)
                    })
                }.padding()
                
                List(props.restrooms, id: \.id) { restroom in
                    RestroomCell(restroom: restroom)
                }.buttonStyle(PlainButtonStyle())
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.brown))
                .edgesIgnoringSafeArea(.all)
        }
        
            .onAppear(perform: {
                self.cancellables = locationManager.$location.sink { location in
                    if let location = location {
                        props.onFetchRestroomByLatLng(location.coordinate.latitude, location.coordinate.longitude)
                    }
                }
            })
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(
            reducer: appReducer,
            state: AppState(),
            middlewares: [restroomMiddleware()]
        )
        return HomeScreen().environmentObject(store)
    }
}

struct RestroomCell: View {
    let restroom: Restroom
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(restroom.name ?? "Not available")
                    .font(.headline)
                Spacer()
                Text(String(format: "%.2f miles", restroom.distance))
            }.padding([.top], 10)
            
            Text(restroom.address)
                .font(.subheadline)
                .opacity(0.5)
            
            Button("Directions") {
                guard let targetURL = URL(string: "http://maps.apple.com/?address=\(restroom.address.encodeURL() ?? "")") else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(targetURL) {
                    UIApplication.shared.open(targetURL, options: [:], completionHandler: nil)
                }
            }.font(.caption)
                .foregroundColor(Color.white)
                .padding(6)
                .background(Color(.darkGray))
                .cornerRadius(6)
            
            Text(restroom.comment ?? "")
                .font(.footnote)
            HStack {
                Text(restroom.accessible ? "🧨" : "")
            }
        }
    }
}
