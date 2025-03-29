import os

BASE_DIR = os.path.dirname(os.path.abspath(__file__))

SECRET_KEY = 'django-insecure-automation-key'
DEBUG = True
ALLOWED_HOSTS = ['automation.opsbyak.com']

INSTALLED_APPS = ['django.contrib.staticfiles']

ROOT_URLCONF = 'urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'templates')],
        'APP_DIRS': True,
    },
]

WSGI_APPLICATION = 'wsgi.application'

STATIC_URL = '/static/'