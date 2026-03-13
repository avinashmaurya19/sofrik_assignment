# E-Commerce Mini App

A Flutter e-commerce app with product listing, product details, and a shopping cart. Products are loaded from a public API; the cart is managed locally in the app.

---

## What This Project Does

- **Product listing** – Fetches and shows products in a grid. Supports search by product title.
- **Product detail** – Tap a product to see image, title, price, rating, and description. Add to cart or go to cart if already added.
- **Shopping cart** – View items, change quantity, remove items, see running total, and checkout (confirmation only, no real payment).
- **Navigation** – Bottom tabs: Products and Cart, with an item-count badge on the Cart tab.

---

## API Used

The app uses the **Fake Store API** (no API key required).

| Base URL | `https://fakestoreapi.com/` |
|----------|-----------------------------|

### Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/products` | Get all products. Returns a JSON array of product objects. |
| `GET` | `/products/{id}` | Get a single product by ID. Returns one product object. |

### Product object (response shape)

```json
{
  "id": 1,
  "title": "Fjallraven - Foldsack No. 1 Backpack...",
  "price": 109.95,
  "description": "Your perfect pack...",
  "category": "men's clothing",
  "image": "https://fakestoreapi.com/img/...",
  "rating": {
    "rate": 3.9,
    "count": 120
  }
}
```

- **Note:** The cart in this app is **not** from the API. Cart data is stored in the app (Riverpod state) only. The constant `getAllCartData` (`carts`) in the project is unused.

---

## Project Structure

```
lib/
├── main.dart                 # App entry, ProviderScope, MaterialApp
├── data/
│   └── constant.dart         # Base URL and API paths
├── model/
│   ├── product_model.dart    # Product + Rating from API
│   ├── cart_item_model.dart # Product + quantity (local cart)
│   └── cart_list_model.dart # (Unused – API cart format)
├── providers/
│   ├── product_provider.dart # Product service + products FutureProvider
│   ├── cart_provider.dart   # Cart state (add, setQuantity, remove, clear)
│   └── navigation_provider.dart # Selected tab index (Products / Cart)
├── services/
│   └── product_service.dart # Dio client, GET /products and /products/:id
├── screens/
│   ├── main_navigation_screen.dart # Bottom nav (Products, Cart)
│   ├── product_list_screen.dart   # Grid + search by title
│   ├── product_detail_screen.dart # Detail + Add to cart / Go to cart
│   └── cart_screen.dart           # Cart list, totals, checkout
├── components/
│   ├── product_card.dart    # Grid item (image, category, title, price)
│   ├── loading_view.dart   # Shimmer skeleton grid while loading
│   ├── error_view.dart     # Error message + Retry
│   └── empty_cart_view.dart# Empty cart message
└── widget/
    ├── app_colors.dart     # App color constants
    ├── app_text_style.dart # App text styles
    └── shimmer_widget.dart # Shimmer / ShimmerContainer
```

---

## Tech Stack

- **Flutter** – UI
- **Riverpod** – State (products, cart, selected tab)
- **Dio** – HTTP (products API)
- **cached_network_image** – Product images

---

## Getting Started

### Prerequisites

- Flutter SDK (see [flutter.dev](https://flutter.dev))
- Dart 3.x

### Run the app

```bash
flutter pub get
flutter run
```

Use the **Products** tab to browse and search, open a product for details, add to cart, then switch to **Cart** to adjust quantities and checkout.
