from django.db import models
from api.locations.models import Location
from api.data.models import Job

# Create your models here.

class SearchProfile(models.Model):
    name = models.CharField(max_length=30)
    search_terms = models.CharField(max_length=200)
    locations = models.ManyToManyField(Location, related_name='location_list')
    distance = models.DecimalField(decimal_places=2, max_digits=10)
    company = models.CharField(max_length=40)

    job_matches = models.ForeignKey(Job, related_name='job_matches', null=True, blank=True)
    job_list = models.ForeignKey(Job, related_name='job_list', null=True, blank=True)
    job_opportunities = models.ForeignKey(Job, related_name='job_opportunities', null=True, blank=True)


class User(models.Model):
    name = models.CharField(max_length=50)
    email_address = models.EmailField()
    encrypted_password = models.CharField(max_length=80)
    password_salt = models.CharField(max_length=10)
    token = models.CharField(max_length=40)
    search_profiles = models.ForeignKey(SearchProfile, related_name='search_profiles', null=True, blank=True)


#Job lists
class JobMatches(models.Model):
    jobs = models.ManyToManyField(Job, related_name='jobMatches', null=True, blank=True)

class JobList(models.Model):
    jobs = models.ManyToManyField(Job, related_name='jobLists', null=True, blank=True)

class JobOpportunities(models.Model):
    jobs = models.ManyToManyField(Job, related_name='jobOpps', null=True, blank=True)

class JobRejections(models.Model):
    jobs = models.ManyToManyField(Job, related_name='jobRejects', null=True, blank=True)

