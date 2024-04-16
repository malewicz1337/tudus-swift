# Tudus - SwiftUI To-Do Application

## Overview
Tudus is a simple and elegant to-do list application developed in Swift. It allows users to add, view, and delete tasks in a user-friendly interface.

## Features
- **Add Tasks:** Users can add new tasks to their to-do list.
- **View Tasks:** Tasks are displayed in an easy-to-read format.
- **Delete Tasks:** Users can delete tasks from their to-do list.

## Technical Details
- **SwiftData Integration:** The app uses SwiftData for data handling.
- **Model-View Structure:** Utilizes SwiftUI for a seamless user interface experience.
- **Dynamic UI Elements:** Incorporates a variety of UI elements including text fields, buttons, and grids.

### ContentView.swift
This is the main view of the application. It includes the layout and functionalities for adding and deleting tasks. It also renders the task list using a `LazyVGrid`.

### Item.swift
Defines the `Item` model, representing a task with `id` and `todo` properties.

### TudusApp.swift
The main application file that sets up the SwiftUI app structure and model container configuration.

## Installation
To run Tudus, clone the repository and open it in Xcode. Ensure you have the necessary dependencies installed.

## Contributing
Contributions are welcome! Feel free to fork the repository and submit your pull requests.

## License
Tudus is released under the [MIT License](LICENSE).
