# 💍 Wedding Web App

A simple Ruby on Rails application to share the details of a wedding and allow guests to upload and view photos after the event.

## 🎯 Features

- 📆 Display key wedding details (date, time, location, etc.)
- 📸 Guests can create personal albums with their name
- ⬆️ Upload multiple photos to each album
- 🖼️ Browse photos grouped by album/person
- 🧼 Optional: Password protection or private tokens
- ☁️ Built using Active Storage for image uploads

## 🛠️ Tech Stack

- Ruby on Rails (PostgreSQL)
- Active Storage (for image handling)
- Tailwind CSS or Bootstrap (styling, to be decided)
- Dev environment via `bin/rails` scripts

## 📦 Models

### Album

| Field       | Type    | Description                         |
|-------------|---------|-------------------------------------|
| `name`      | string  | Guest's name / album title          |
| `description` | text  | (Optional) Album description        |

### Photo

| Field         | Type      | Description                       |
|---------------|-----------|-----------------------------------|
| `image`       | attachment | Uploaded image file (Active Storage) |
| `description` | text      | (Optional) Caption or context     |
| `album_id`    | reference | Links photo to a specific album   |

## 🚀 Getting Started

1. Clone the repository:
   `git clone git@github.com:magoar/wedding_web.git`

2. Install dependencies:
   `bundle install && yarn install`

3. Set up the database:  
   `bin/rails db:create`
   `bin/rails db:migrate`

5. Start the Rails server:
   `bin/dev`
