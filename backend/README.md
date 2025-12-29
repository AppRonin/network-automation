# ⚙️ Network Automation Backend

> **Enterprise-grade backend API for telecom network automation**

A robust and scalable **Django REST Framework API** designed to power telecom network automation workflows, asynchronous processing, and secure integrations with frontend clients such as **Flutter Web**.

## Getting Started

### 1️⃣ Clone the repo

```bash
git clone https://github.com/AppRonin/network-automation.git
cd network-automation
```

### 2️⃣ Run the API server

```bash
cd backend
python manage.py runserver
```

### 3️ Run Redis

```bash
sudo service redis-server start
```

### 4️⃣ Start Dramatiq worker

```bash
dramatiq tasks.workers
```

## Author

Developed by **AppRonin**, Full-Stack Developer.
