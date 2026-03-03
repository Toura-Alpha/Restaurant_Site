/*
  # Create Restaurant Website Tables

  1. New Tables
    - `menu_items`
      - `id` (uuid, primary key)
      - `name` (text) - Name of the menu item
      - `description` (text) - Description of the dish
      - `price` (numeric) - Price of the item
      - `category` (text) - Category (appetizers, mains, desserts, drinks)
      - `image_url` (text) - URL to dish image
      - `available` (boolean) - Whether item is currently available
      - `created_at` (timestamptz) - Timestamp of creation

    - `reservations`
      - `id` (uuid, primary key)
      - `name` (text) - Customer name
      - `email` (text) - Customer email
      - `phone` (text) - Customer phone number
      - `date` (date) - Reservation date
      - `time` (time) - Reservation time
      - `guests` (integer) - Number of guests
      - `message` (text) - Special requests or message
      - `status` (text) - Status (pending, confirmed, cancelled)
      - `created_at` (timestamptz) - Timestamp of creation

  2. Security
    - Enable RLS on both tables
    - Add policies for public read access to menu items
    - Add policies for creating reservations (public can create)
    - Add policies for authenticated admin users to manage data
*/

CREATE TABLE IF NOT EXISTS menu_items (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  description text NOT NULL,
  price numeric(10,2) NOT NULL,
  category text NOT NULL,
  image_url text DEFAULT '',
  available boolean DEFAULT true,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS reservations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  email text NOT NULL,
  phone text NOT NULL,
  date date NOT NULL,
  time time NOT NULL,
  guests integer NOT NULL,
  message text DEFAULT '',
  status text DEFAULT 'pending',
  created_at timestamptz DEFAULT now()
);

ALTER TABLE menu_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE reservations ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can view available menu items"
  ON menu_items FOR SELECT
  USING (available = true);

CREATE POLICY "Anyone can create reservations"
  ON reservations FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Authenticated users can view all menu items"
  ON menu_items FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Authenticated users can view reservations"
  ON reservations FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Authenticated users can update reservations"
  ON reservations FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

INSERT INTO menu_items (name, description, price, category, image_url) VALUES
  ('Caprese Salad', 'Fresh mozzarella, tomatoes, basil, and balsamic glaze', 12.99, 'appetizers', 'https://images.pexels.com/photos/1435904/pexels-photo-1435904.jpeg?auto=compress&cs=tinysrgb&w=800'),
  ('Bruschetta', 'Toasted bread topped with tomatoes, garlic, and olive oil', 9.99, 'appetizers', 'https://images.pexels.com/photos/2662875/pexels-photo-2662875.jpeg?auto=compress&cs=tinysrgb&w=800'),
  ('Grilled Salmon', 'Atlantic salmon with seasonal vegetables and lemon butter', 24.99, 'mains', 'https://images.pexels.com/photos/1516415/pexels-photo-1516415.jpeg?auto=compress&cs=tinysrgb&w=800'),
  ('Ribeye Steak', 'Prime ribeye with roasted potatoes and herb butter', 32.99, 'mains', 'https://images.pexels.com/photos/769289/pexels-photo-769289.jpeg?auto=compress&cs=tinysrgb&w=800'),
  ('Margherita Pizza', 'Classic pizza with tomato sauce, mozzarella, and fresh basil', 16.99, 'mains', 'https://images.pexels.com/photos/2147491/pexels-photo-2147491.jpeg?auto=compress&cs=tinysrgb&w=800'),
  ('Pasta Carbonara', 'Creamy pasta with pancetta, egg, and parmesan', 18.99, 'mains', 'https://images.pexels.com/photos/1279330/pexels-photo-1279330.jpeg?auto=compress&cs=tinysrgb&w=800'),
  ('Tiramisu', 'Classic Italian dessert with espresso and mascarpone', 8.99, 'desserts', 'https://images.pexels.com/photos/6880219/pexels-photo-6880219.jpeg?auto=compress&cs=tinysrgb&w=800'),
  ('Chocolate Lava Cake', 'Warm chocolate cake with molten center and vanilla ice cream', 9.99, 'desserts', 'https://images.pexels.com/photos/2097090/pexels-photo-2097090.jpeg?auto=compress&cs=tinysrgb&w=800'),
  ('Fresh Lemonade', 'House-made lemonade with mint', 4.99, 'drinks', 'https://images.pexels.com/photos/96974/pexels-photo-96974.jpeg?auto=compress&cs=tinysrgb&w=800'),
  ('Espresso', 'Rich Italian espresso', 3.99, 'drinks', 'https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg?auto=compress&cs=tinysrgb&w=800');
