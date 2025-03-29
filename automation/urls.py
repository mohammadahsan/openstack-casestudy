from django.urls import path
from views import automation_view

urlpatterns = [
    path('', automation_view),
]