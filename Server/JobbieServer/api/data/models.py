from django.db import models
from api.locations.models import Location

# Create your models here.
class Job(models.Model):
    name = models.CharField(max_length=80)
    location = models.ForeignKey(Location)
    company = models.CharField(max_length=80)
    url = models.URLField()
    description = models.CharField(max_length=500)
    date_posted = models.DateField()


class Skill(models.Model):
    id = models.IntegerField()
    name = models.CharField(max_length=30)

class Industry(models.Model):
    id = models.IntegerField()
    name = models.CharField()
