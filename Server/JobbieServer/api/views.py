from django.shortcuts import render
from django.http import HttpResponse, HttpRequest

def index(request):
    return HttpResponse("You've reached the api index")

