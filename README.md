# Rails e-Commerce Shop

A full-featured, secure, and modular e-Commerce web application built using **Ruby on Rails** and **Bulma CSS**.

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Tech Stack & Dependencies](#tech-stack--dependencies)
- [Getting Started & Installation](#getting-started--installation)
- [Project Architecture & Infrastructure](#project-architecture--infrastructure)
- [Bonus Features](#bonus-features)

---

## Overview
This application provides a complete marketplace platform where users can create accounts, list products for sale with specs and images, manage their listings, and shop using an interactive session-persisted shopping cart.

---

## Features

### 1. User Authentication (Devise)
- Custom `RegistrationsController` inheriting from `Devise::RegistrationsController`.
- Secure parameters handling for account signup (`name`, `email`, `password`, `password_confirmation`) and account editing (`current_password`).

### 2. Product Management & Ownership Controls
- **Sell Products**: Authenticated users can list items specifying title, model, description, brand, condition, finish, price, and image uploads.
- **Seller Visibility**: Displays seller name ("Sold by: [Name]") on every product listing card without having to open the ad.
- **Authorization Guards**: Server-side controller guards and client-side view filters ensure that **only the creator/owner of an ad** can edit or delete it.

### 3. Shopping Cart System
- **Session-Based Cart (`CurrentCart` Concern)**: Cart persists across guest browsing and automatically transfers items when a guest signs in.
- **Live Cart Badge**: Header navigation bar features a dynamic cart icon showing total items in cart.
- **Cart Management**: Add items, adjust item quantities (`+` / `-`), remove individual line items, or empty the entire cart.
- **Auto-Dismiss Notifications**: Flash messages `"Added to your cart"` and `"Removed from your cart"` automatically fade out after a short duration.
- **Empty Cart Confirmation**: Prompts an `"Are you sure?"` confirmation modal before clearing cart items and redirecting to homepage.

---

## Tech Stack & Dependencies

- **Framework**: Ruby on Rails 6.1
- **Language**: Ruby 2.6+ / 3.0+
- **Database**: SQLite3
- **Authentication**: Devise gem
- **Styling**: Bulma CSS & Sass
- **File Uploads**: CarrierWave & ActiveStorage

---

## Getting Started & Installation

Follow these steps to run the application locally on your system.

### Prerequisites
Make sure you have Ruby and Bundler installed on your system.
```bash
ruby -v
bundle -v
```

### Installation Steps

1. **Navigate to the Project Directory**:
   ```bash
   cd shop
   ```

2. **Install Gem Dependencies**:
   ```bash
   bundle install
   # Or if using vendored bundle path:
   BUNDLE_PATH=vendor/bundle bundle install
   ```

3. **Setup Database & Seed Data**:
   ```bash
   bundle exec rails db:migrate
   bundle exec rails db:seed
   ```

4. **Start the Rails Development Server**:
   ```bash
   bundle exec rails s
   ```

5. **Access the Application**:
   Open your browser and navigate to `http://localhost:3000`.

---

## Project Architecture & Infrastructure

The project structure enforces strict separation of concerns into clean, modular files:

```
app/
├── controllers/
│   ├── concerns/
│   │   └── current_cart.rb        # Session cart management concern
│   ├── carts_controller.rb        # Cart view and clear actions
│   ├── line_items_controller.rb   # Add, remove, & decrement cart items
│   ├── products_controller.rb     # Product CRUD & authorization checks
│   └── registrations_controller.rb# Custom Devise parameters
├── helpers/
│   └── products_helper.rb         # Product seller & ownership helpers
├── models/
│   ├── cart.rb                    # Cart model & total calculation methods
│   ├── line_item.rb               # LineItem relationship & subtotals
│   ├── product.rb                 # Product validations & image uploader
│   └── user.rb                    # User authentication associations
└── views/
    ├── carts/                     # Cart table & checkout views
    ├── layouts/                   # Application layout with navbar badge & toast JS
    └── products/                  # Product cards, detail show, and form partials
```

---

## Bonus Features
- **Direct Grid Add to Cart**: Add products to cart directly from homepage product cards without needing to open the product detail page.
- **Quantity Adjustments**: Increment and decrement product line item quantities directly inside cart view.
- **Expanded Brands & Finishes**: Extended brand choices (Apple, Samsung, Sony, Dell, Nike, Adidas) and finishes (Silver, Gold, SpaceGray).
- **Simulated Payment Modal**: Interactive modal on cart page for credit card checkout simulation.

---

## License & Credits
Developed as part of the Reboot01 curriculum.
