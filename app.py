from flask import Flask, render_template, jsonify, request
from flask_cors import CORS
import os
from dotenv import load_dotenv
from supabase import create_client, Client

load_dotenv()

app = Flask(__name__, static_folder='static', template_folder='templates')
CORS(app)

supabase_url = os.getenv('SUPABASE_URL')
supabase_key = os.getenv('SUPABASE_KEY')

# Use service_role key to bypass RLS (for both local and production)
supabase: Client = create_client(supabase_url, supabase_key)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/about')
def about():
    return render_template('about.html')

@app.route('/menu')
def menu():
    return render_template('menu.html')

@app.route('/reservations')
def reservations():
    return render_template('reservations.html')

@app.route('/contact')
def contact():
    return render_template('contact.html')

@app.route('/api/menu', methods=['GET'])
def get_menu():
    try:
        response = supabase.table('menu_items').select('*').order('category', desc=False).execute()
        return jsonify({'success': True, 'data': response.data})
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/api/reservations', methods=['POST'])
def create_reservation():
    try:
        data = request.json
        response = supabase.table('reservations').insert({
            'name': data['name'],
            'email': data['email'],
            'phone': data['phone'],
            'date': data['date'],
            'time': data['time'],
            'guests': data['guests'],
            'message': data.get('message', '')
        }).execute()
        return jsonify({'success': True, 'data': response.data})
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/api/reservations', methods=['GET'])
def get_reservations():
    try:
        response = supabase.table('reservations').select('*').order('date', desc=False).execute()
        return jsonify({'success': True, 'data': response.data})
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True, port=5000)


# database pass= J0DI10H3M4OOBYbM