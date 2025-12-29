# ⚙️ Network Automation API

> **Enterprise-grade backend API for telecom network automation**

A robust and scalable **Django REST Framework API** designed to power telecom network automation workflows, asynchronous processing, and secure integrations with frontend clients such as **Flutter Web**.

## Getting Started

### 1️⃣ Clone the repo

```bash
git clone https://github.com/AppRonin/network-automation-back.git
cd network-automation-back
```

### 2️⃣ Run Redis

```bash
sudo service redis-server start
```

### 3️⃣ Run the API server

```bash
python manage.py runserver
```

### 4️⃣ Start Dramatiq worker

```bash
dramatiq tasks.workers
```

## Author

Developed by **AppRonin**, Full-Stack Developer.
