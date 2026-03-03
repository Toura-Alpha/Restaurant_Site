# Bella Vista Restaurant Website

A beautiful restaurant website built with Flask backend and HTML/CSS/JavaScript frontend, featuring a dynamic menu system and online reservations.

## Features

- Responsive design with natural, beautiful color scheme
- Dynamic menu display with category filtering
- Online reservation system
- Supabase database integration
- Smooth scrolling and animations

## Technology Stack

- **Backend**: Flask, Python
- **Frontend**: HTML5, CSS3, JavaScript
- **Database**: Supabase (PostgreSQL)
- **Styling**: Custom CSS with natural earth tones

## Setup Instructions

### Prerequisites

- Python 3.8 or higher
- Supabase account

### Installation

1. Install Python dependencies:
```bash
pip install -r requirements.txt
```

2. Environment variables are already configured in the `.env` file

3. Database tables are already created with sample menu items

### Running the Application

Start the Flask server:
```bash
python app.py
```

The application will be available at `http://localhost:5000`

## Project Structure

```
.
├── app.py                 # Flask application
├── requirements.txt       # Python dependencies
├── templates/
│   └── index.html        # Main HTML template
├── static/
│   ├── css/
│   │   └── style.css     # Styles with natural colors
│   └── js/
│       └── main.js       # Frontend JavaScript
└── .env                  # Environment variables
```

## Features Details

### Menu System
- Display menu items from database
- Filter by category (Appetizers, Mains, Desserts, Drinks)
- Beautiful card-based layout with images
- Hover effects and smooth transitions

### Reservation System
- User-friendly form for booking tables
- Real-time validation
- Success confirmation message
- Data stored in Supabase

### Design
- Natural color palette (olive green, sage, earth tones, cream)
- Responsive layout for all devices
- Smooth scrolling navigation
- Professional typography

## API Endpoints

- `GET /api/menu` - Fetch all menu items
- `POST /api/reservations` - Create a new reservation
- `GET /api/reservations` - Fetch all reservations

## Color Scheme

- Primary: #6B8E23 (Olive Green)
- Secondary: #8B7355 (Warm Brown)
- Accent: #D4A574 (Sand)
- Background: #FFFFF9 (Soft White)
- Text: #2C2416 (Dark Brown)
