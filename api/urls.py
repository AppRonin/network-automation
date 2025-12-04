from django.urls import path
from api.views import StartTaskView, ProgressView
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView

urlpatterns = [
    # JWT Authentication
    path("token/", TokenObtainPairView.as_view(), name="token_obtain_pair"),
    path("token/refresh/", TokenRefreshView.as_view(), name="token_refresh"),
    
    path("gpon-conversor/", StartTaskView.as_view()),
    path("progress/<str:task_id>/", ProgressView.as_view()),
]