from django.conf.urls import patterns, include, url
from api import views

urlpatterns = patterns('',
    url(r'^$', views.index, name='index'),
    url(r'^accounts/*', include('api.accounts.urls'))
)