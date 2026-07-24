# Shop 🛒

[![Ruby](https://img.shields.io/badge/Ruby-3.0.0-CC342D?style=flat&logo=ruby)](https://www.ruby-lang.org/)
[![Ruby on Rails](https://img.shields.io/badge/Ruby_on_Rails-6.1.3-CC0000?style=flat&logo=ruby-on-rails)](https://rubyonrails.org/)
[![SQLite](https://img.shields.io/badge/Database-SQLite3-003B57?style=flat&logo=sqlite)](https://www.sqlite.org/)
[![Bulma CSS](https://img.shields.io/badge/UI_Framework-Bulma-00D1B2?style=flat&logo=bulma)](https://bulma.io/)
[![Devise](https://img.shields.io/badge/Auth-Devise-4.7-black)](https://github.com/heartcombo/devise)

Shop is a full-stack e-Commerce marketplace web application built with Ruby on Rails and Bulma CSS. It allows users to register accounts, post item listings with image uploads, manage personal product ads, and shop using an interactive session-persistent shopping cart.

---

## ⚡ Key Features

- **User Authentication**: User registration and account management powered by Devise with custom name attributes and credential validation.
- **Product Ad Creator**: Authenticated users can list products specifying title, brand, model, condition, finish, price, description, and image uploads via CarrierWave.
- **Seller Attribution**: Product cards in the marketplace display seller names ("Sold by: [Seller]") directly on homepage product cards without requiring buyers to open each ad.
- **Ownership Authorization**: Strict server-side authorization guards and client-side controls ensure that only the user who created an ad can edit or delete it.
- **Direct Add-to-Cart**: Quick "Add to Cart" action buttons directly on homepage product grid cards and product detail pages.
- **Session Cart Persistence**: Guest shopping carts persist via session storage and carry over active items when a guest signs in.
- **Granular Cart Management**: Adjust item quantities (`+` / `-`), remove individual line items, calculate real-time order totals, and trigger auto-dismissing toast notifications (`"Added to your cart"`, `"Removed from your cart"`).
- **Empty Cart Safeguard**: Interactive confirmation modal ("Are you sure?") before clearing cart contents and redirecting to the storefront.
- **Checkout Flow**: Simulated credit card checkout modal on the cart page for order completion.

---

## 🏗 Data & Request Flow

```mermaid
flowchart TD
    A[Visitor Browse Store / Products] --> B{Add Item to Cart?}
    B -->|Yes| C[CurrentCart Concern: Fetch / Create Cart in Session]
    C --> D[LineItemsController: Add or Increment Product Quantity]
    D --> E[Render Auto-Dismiss Notification Toast]
    E --> F[Update Nav Header Cart Counter Badge]
    A --> G{User Actions: Sign Up / Sign In}
    G --> H[Devise RegistrationsController: Preserve Cart Session]
    H --> I[Authenticated User Seller Dashboard]
    I --> J{Create / Edit / Delete Ad}
    J -->|Authorize Owner| K[ProductsController Guard: Check current_user == product.user]
```

---

## ⚙️ How to Run Locally

### Prerequisites
- **Ruby**: version 2.6.0 or higher (recommended: 3.0.0)
- **Bundler**: `gem install bundler`
- **SQLite3**: installed on host system

### Installation & Execution Steps

1. **Clone & Navigate to Project**:
   ```bash
   git clone <repository-url>
   cd shop
   ```

2. **Install Dependencies**:
   ```bash
   bundle install
   # Or using vendored path:
   BUNDLE_PATH=vendor/bundle bundle install
   ```

3. **Set Up Database & Run Migrations**:
   ```bash
   bundle exec rails db:migrate
   bundle exec rails db:seed
   ```

4. **Launch Development Server**:
   ```bash
   bundle exec rails s
   ```

5. **Open Application**:
   Open your browser and go to `http://localhost:3000`.

---

## 📂 Project Structure

```
shop/
├── app/
│   ├── controllers/
│   │   ├── concerns/
│   │   │   └── current_cart.rb         # Session cart persistence helper
│   │   ├── carts_controller.rb         # Cart views & clear action
│   │   ├── line_items_controller.rb    # Add, remove, and quantity controls
│   │   ├── products_controller.rb      # Product CRUD & authorization guards
│   │   ├── registrations_controller.rb # Custom Devise registration parameters
│   │   └── store_controller.rb         # Store index handler
│   ├── helpers/
│   │   └── products_helper.rb          # Seller attribution & owner checks
│   ├── models/
│   │   ├── cart.rb                     # Cart totals & line items association
│   │   ├── line_item.rb                # Product line item subtotals
│   │   ├── product.rb                  # Product validations & image uploader
│   │   └── user.rb                     # User authentication model
│   ├── uploaders/
│   │   └── image_uploader.rb           # CarrierWave image uploader
│   └── views/
│       ├── carts/                      # Shopping cart page & checkout modal
│       ├── devise/                     # Authentication & registration forms
│       ├── layouts/                    # Application wrapper with cart badge & toasts
│       └── products/                   # Storefront grid, detail views, and ad form
├── config/
│   └── routes.rb                       # Application routes & resource mappings
├── db/
│   ├── migrate/                        # Database migrations (users, products, carts, line_items)
│   └── seeds.rb                        # Initial database seed records
└── vendor/
    └── bundle/                         # Pre-packaged gem dependencies
```

---

## 📝 License
Distributed under the MIT License. See `LICENSE.md` for details.
