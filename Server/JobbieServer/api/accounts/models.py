from django.db import models
from django.contrib.auth.models import User
from api.locations.models import Location
from api.data.models import Job

# Create your models here.

class SearchProfile(models.Model):
    user = models.OneToOneField(User)
    search_terms = models.CharField(max_length=200)
    locations = models.ManyToManyField(Location, related_name='location_list')
    distance = models.DecimalField(decimal_places=2, max_digits=10)
    company = models.CharField(max_length=40)

    job_matches = models.ManyToManyField(Job, related_name='job_matches', null=True, default=None)
    job_opps = models.ManyToManyField(Job, null=True, related_name='job_opps', default=None)
    job_list = models.ManyToManyField(Job, null=True, related_name='job_list', default=None)


    def __init__(self, user):
        self.super()
        self.user = user
