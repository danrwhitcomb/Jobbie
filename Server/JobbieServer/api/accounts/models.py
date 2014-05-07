from django.db import models
from django.contrib.auth.models import User
from api.locations.models import Location
from api.data.models import Job, Industry, Skill

# Create your models here.

class SearchProfile(models.Model):
    user = models.OneToOneField(User)
    college = models.CharField(max_length=50)
    graduation_year = models.TimeField()
    job_preference = models.CharField(max_length=15)
    skillset = models.ManyToManyField(Skill)
    industry = models.ManyToManyField(Industry)
    skill_level = models.IntegerField()
    locations = models.ManyToManyField(Location)

    def __init__(self, user):
        self.super()
        self.user = user
