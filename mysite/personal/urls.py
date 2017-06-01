from django.conf.urls import url, include
from . import views

urlpatterns = [
    url(r'^$', views.index, name='index'),
    url(r'^contact', views.contact, name='contact'),
    url(r'^search', views.searchResults, name='searchResults'),
    url(r'^login', views.login, name='login'),
    url(r'^about', views.about, name='about'),
]
