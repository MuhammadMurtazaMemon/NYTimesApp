
# NYTimesApp `SwiftUI`
A SwiftUI App for showing Most Popular Articles from NYTimes API. It's backend has written in Swift with MVVM architecture.

## Features
- Fetch NY Times most popular articles (default 7-day period), can be change by passing period value to view model. Accepted period values are 1, 7 and 30
- Display articles in list
- Show details on tap
- Unit tests for ViewModel

## Directory Structure
- #### ViewModels
    - It encapsulates all the business logic
    - It is dependent on `Models` to perform any operation
    - It has published properties for UI, where UI can listen to the changes on the model.

- #### Model
    - It is the interactor layer between `ViewModels` and `Services`
    - It is responsible for connect to network service to recieve desired data

- #### Services
    - It has a network service responsible to make and manage active network connections

- #### Network Requests
    - These are the NetworkRequestable objects that can be passed to network service to fetch data from server

- #### Data Classes
    - Data classes are the data holder objects

- #### Extensions
    - A handy methods on Apple framework to make APIs more robust
    - A handy methods and modifiers on SwiftUI Views to easily use it for UI related works like showing loader, showing error etc.

## Requirements

- iOS 16.0+
- Xcode 16.0+

## Meta

Hafiz Muhammad Murtaza – muhammadmurtaza10@gmail.com
