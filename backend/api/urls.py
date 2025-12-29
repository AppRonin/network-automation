from django.urls import path
from api.views import GponConversorView, ProgressView
from rest_framework.authtoken.views import obtain_auth_token

urlpatterns = [
    path("gpon-conversor/", GponConversorView.as_view()),
    path("progress/<str:task_id>/", ProgressView.as_view()),
    
    path("login/", obtain_auth_token, name="login"),
]