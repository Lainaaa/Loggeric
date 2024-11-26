# Loggeric

Loggeric is a lightweight Swift logging library built on top of `os_log`. It provides structured logging with predefined levels and customizable formats for better readability and debugging.

---

## Features

- Supports different log levels: `default`, `debug`, `info`, `error`, `fault`
- Provides a convenient API for logging messages with contextual information
- Automatically includes file name, function name, and line number in logs
- Customizable message formatting
- Uses `os_log` for efficient and system-integrated logging

---

## Installation

Now supports only SPM.

## Usage
### Initialization
Create a logger instance by specifying an optional subsystem and module:

```swift
let logger = Loggeric(subsystem: "com.example.app", module: "ExampleModule")
```
If subsystem or module is not provided, default values will be used.

### Logging Messages
Loggeric provides methods for logging messages at different levels:

```swift
logger.default("This is a default log")
logger.debug("Debugging info")
logger.info("Informational message")
logger.error("An error occurred")
logger.fault("Critical error")
```
Each log includes:

* Log level with a corresponding emoji (e.g., 🖤 for debug)
* Timestamp
* Module (if provided)
* File, function, and line number
Example output:

```swift
🖤[DEBUG] 2024-11-24 15:45:10
NetworkModule | File.swift | fetchData() | line: 42
Fetching data from API
```

## Customization
### Adding Contextual Information
Loggeric automatically captures file, function, and line information. You can pass additional details through the message parameter.

## Tests
Loggeric includes unit tests written using the Swift Testing framework. To run the tests:

Navigate to the project directory in your terminal.
Execute the following command:
```swift
swift test
```

## Contributing
We welcome contributions! Please fork the repository, create a feature branch, and submit a pull request. Ensure all tests pass before submitting.

## License
Loggeric is released without the MIT License. Don't see LICENSE for details.

## Author
Created by Dmitrij Meidus.

Happy logging! 🚀
