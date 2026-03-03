let allMenuItems = [];
let currentFilter = 'all';

document.addEventListener('DOMContentLoaded', () => {
    loadMenuItems();
    setupFilterButtons();
    setupReservationForm();
    setupSmoothScroll();
    setupMobileMenu();
    setMinDate();
});

async function loadMenuItems() {
    const menuContainer = document.getElementById('menu-items');

    try {
        const response = await fetch('/api/menu');
        const data = await response.json();

        if (data.success) {
            allMenuItems = data.data;
            displayMenuItems(allMenuItems);
        } else {
            menuContainer.innerHTML = '<p class="loading">Failed to load menu items.</p>';
        }
    } catch (error) {
        console.error('Error loading menu:', error);
        menuContainer.innerHTML = '<p class="loading">Error loading menu. Please try again later.</p>';
    }
}

function displayMenuItems(items) {
    const menuContainer = document.getElementById('menu-items');

    if (items.length === 0) {
        menuContainer.innerHTML = '<p class="loading">No items found.</p>';
        return;
    }

    menuContainer.innerHTML = items.map(item => `
        <div class="menu-item" data-category="${item.category}">
            <img src="${item.image_url}" alt="${item.name}" class="menu-item-image" onerror="this.src='https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=800'">
            <div class="menu-item-content">
                <div class="menu-item-header">
                    <h3 class="menu-item-name">${item.name}</h3>
                    <span class="menu-item-price">$${parseFloat(item.price).toFixed(2)}</span>
                </div>
                <p class="menu-item-description">${item.description}</p>
                <span class="menu-item-category">${item.category}</span>
            </div>
        </div>
    `).join('');
}

function setupFilterButtons() {
    const filterButtons = document.querySelectorAll('.filter-btn');

    filterButtons.forEach(button => {
        button.addEventListener('click', () => {
            filterButtons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');

            const category = button.dataset.category;
            currentFilter = category;

            if (category === 'all') {
                displayMenuItems(allMenuItems);
            } else {
                const filtered = allMenuItems.filter(item => item.category === category);
                displayMenuItems(filtered);
            }
        });
    });
}

function setupReservationForm() {
    const form = document.getElementById('reservation-form');

    form.addEventListener('submit', async (e) => {
        e.preventDefault();

        const formData = {
            name: document.getElementById('name').value,
            email: document.getElementById('email').value,
            phone: document.getElementById('phone').value,
            date: document.getElementById('date').value,
            time: document.getElementById('time').value,
            guests: parseInt(document.getElementById('guests').value),
            message: document.getElementById('message').value
        };

        try {
            const response = await fetch('/api/reservations', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(formData)
            });

            const data = await response.json();

            if (data.success) {
                form.style.display = 'none';
                document.getElementById('reservation-success').style.display = 'block';

                setTimeout(() => {
                    form.reset();
                    form.style.display = 'flex';
                    document.getElementById('reservation-success').style.display = 'none';
                    setMinDate();
                }, 5000);
            } else {
                alert('Failed to make reservation. Please try again.');
            }
        } catch (error) {
            console.error('Error making reservation:', error);
            alert('Error making reservation. Please try again later.');
        }
    });
}

function setupSmoothScroll() {
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                const offset = 80;
                const targetPosition = target.offsetTop - offset;
                window.scrollTo({
                    top: targetPosition,
                    behavior: 'smooth'
                });
            }
        });
    });
}

function setupMobileMenu() {
    const toggle = document.querySelector('.mobile-menu-toggle');
    const navMenu = document.querySelector('.nav-menu');

    if (toggle) {
        toggle.addEventListener('click', () => {
            navMenu.style.display = navMenu.style.display === 'flex' ? 'none' : 'flex';
        });
    }
}

function setMinDate() {
    const dateInput = document.getElementById('date');
    if (dateInput) {
        const today = new Date().toISOString().split('T')[0];
        dateInput.setAttribute('min', today);
    }
}

window.addEventListener('scroll', () => {
    const navbar = document.querySelector('.navbar');
    if (window.scrollY > 100) {
        navbar.style.backgroundColor = 'rgba(44, 36, 22, 0.98)';
    } else {
        navbar.style.backgroundColor = 'rgba(44, 36, 22, 0.95)';
    }
});
