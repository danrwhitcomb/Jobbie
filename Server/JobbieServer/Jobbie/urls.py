from django.conf.urls import patterns, include, url
from django.conf.urls.static import static
from django.conf import settings
from web.Views.homeViews import index
from django.views.generic import RedirectView

urlpatterns = patterns('',
    url(r'^api/', include('api.urls')),
    url(r'^$', index),
    url(r'^web/', include('web.urls')),
) + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)