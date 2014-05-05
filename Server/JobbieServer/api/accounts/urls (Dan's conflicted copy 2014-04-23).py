from django.conf.urls import patterns, include, url
from api.accounts import views

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'Jobbie.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),
    url(r'^$', views.index),
    url(r'^new_user$', views.new_user)
)