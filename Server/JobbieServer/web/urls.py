from django.conf.urls import patterns, include, url
from web.Views import homeViews

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'Jobbie.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),
    url(r'^$', homeViews.index, name='index')
)