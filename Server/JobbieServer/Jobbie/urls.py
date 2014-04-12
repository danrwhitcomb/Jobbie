from django.conf.urls import patterns, include, url
from web import urls
from api import urls

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'Jobbie.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),
    url(r'^api/', include('api.urls')),
    url(r'^.*', include('web.urls'))
)
