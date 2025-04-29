# WallaMarvel

WallaMarvel is a technical test app that consumes the Marvel API to display a list of superheroes and their related comics. It supports search, pagination, and navigation to a detail view.

---

## 📱 Screenshots

- Heroes List

![Simulator Screenshot - iPhone 16 Pro - 2025-04-07 at 17 08 08](https://github.com/user-attachments/assets/0d7f9bae-ad51-451c-8469-a05a8ecaa461)


- Hero Detail  

![Simulator Screenshot - iPhone 16 Pro - 2025-04-07 at 17 08 19](https://github.com/user-attachments/assets/a4ac075e-b3b4-479d-abd4-339718e88168)


- Comic Detail

![Simulator Screenshot - iPhone 16 Pro - 2025-04-07 at 17 08 29](https://github.com/user-attachments/assets/37fdd179-bd18-45b1-ad7a-ae9ef856270f)
 

- Empty State on no results

![Simulator Screenshot - iPhone 16 Pro - 2025-04-07 at 17 11 33](https://github.com/user-attachments/assets/b1941f2d-3c3a-4604-9c43-eef2b1077569)


---

## 🚀 Features

- ✅ Infinite scroll with pagination.
- ✅ Real-time search with empty state feedback.
- ✅ Hero detail view with image and comic list.
- ✅ Decoupled architecture (MVP + Clean Layers).
- ✅ Visual empty state label for no search results.
- ✅ Fully tested: Presenters, Use Cases, Repositories, DataSources, and APIClient.
- ✅ UI tests using XCTest (search + navigation).

---

## 🧱 Architecture

The project follows clean architecture principles, split into the following layers:

- **UI (UIKit + SwiftUI):** View controllers and reusable components.
- **Presenter:** Presentation logic, fully decoupled from UI.
- **Use Cases:** Application-specific business logic.
- **Repository:** Abstraction over the data source layer.
- **Data Source:** Responsible for accessing external APIs.
- **APIClient:** Low-level HTTP request abstraction.
- **Models:** Clean, decodable data structures.

