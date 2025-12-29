# 🦋⚙️ Network Automation

> **telecom network automation platform**  
> Modern **Flutter Web frontend** and a robust **Django REST backend**, designed for enterprise-grade telecom workflows.

The project is split into two independent but connected applications:

- 🦋 **Frontend** → Built with **Flutter**
- ⚙️ **Backend** → Built with **Django**

<div align="center">
  <p float="left">
    <img src="frontend/lib/images/screenshot.png" width="80%" />
  </p>
</div>

## Getting Started

### 1️⃣ Clone the repository

```bash
git clone https://github.com/AppRonin/network-automation.git
cd network-automation
```

### 2️⃣ Frontend Setup

```bash
cd frontend
flutter pub get
flutter run -d web-server --web-port=5173
```

### 3️⃣ Backend Setup

```bash
cd backend
python manage.py runserver
```

Start Redis:

```bash
sudo service redis-server start
```

Start Dramatiq worker:

```bash
dramatiq tasks.workers
```

## Author

Developed by **AppRonin**, Full-Stack Developer.
