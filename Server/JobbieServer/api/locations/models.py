from django.db import models

# Create your models here.
class Location(models.Model):
    city = models.CharField(max_length=80)
    state = models.CharField(max_length=5)
    country = models.CharField(max_length=20)
