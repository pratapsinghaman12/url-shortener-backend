# 🔗 URL Shortener API (Rails)

This is the backend API for the URL Shortener app, built with **Ruby on Rails**.

---

## 🚀 Setup Instructions

### 🖥️ Prerequisites

- Ruby (>= 3.2)
- Rails (>= 7.1 or 8.0)
- PostgreSQL or SQLite
- Bundler

---

### 📦 Setup

```bash
# Install dependencies
bundle install

# Setup the database
rails db:create
rails db:migrate

# Run the server
rails server
```

> The server runs on: http://localhost:3000

---

## ✅ Features

- Shorten long URLs
- Prevent duplicates
- Redirect to original URL
- Delete shortened URL

---

## 🧪 Running Tests

```bash
bundle exec rspec
```

---

## 🛡️ API Endpoints

| Method | Endpoint             | Description                    |
|--------|----------------------|--------------------------------|
| GET    | /urls                | List all URLs                  |
| POST   | /urls                | Create a new short URL         |
| GET    | /:short              | Redirect to original URL       |
| DELETE | /urls/:id            | Delete a URL                   |

---

## ⚙️ Technologies Used

- Ruby on Rails
- RSpec (for testing)
- SQLite3 / PostgreSQL

---

## 📜 License

MIT
