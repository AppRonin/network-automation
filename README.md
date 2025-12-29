# ⚙️ Network Automation API

> **Enterprise-grade backend API for telecom network automation**

A robust and scalable **Django REST Framework API** designed to power telecom network automation workflows, asynchronous processing, and secure integrations with frontend clients such as **Flutter Web**.

## ✨ Features

- 🚀 **RESTful API** built with Django REST Framework
- 🔐 **Token-based authentication** (Opaque Token)
- 📁 **File upload & validation** workflows
- 🧵 **Asynchronous background tasks** using Dramatiq
- ⚡ **Redis** as message broker
- 🗄 **PostgreSQL** for reliable data persistence

## 📂 Project Structure

```text
NETWORK_AUTOMATION/
├── api/                    # Main Django app (REST API)
├── network_automation/     # Project configuration
├── tasks/                  # Background task definitions
├── utils/                  # Shared utilities & helpers
├── media/                  # Uploaded files
├── env/                    # Virtual environment (optional)
├── .env                    # Environment variables
├── .env_sample             # Environment example template
├── requirements.txt        # Python dependencies
├── manage.py
└── README.md
```

## 🚀 Getting Started

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

## 🛠 Tech Stack

- **Python**
- **Django**
- **Django REST Framework**
- **Dramatiq**
- **Redis**
- **PostgreSQL**

## ✒ Author

**AppRonin**  
GitHub: https://github.com/AppRonin
