from django.shortcuts import render
from django.http import HttpResponse
from django.shortcuts import render
# Create your views here.

def index(request):
	print "HELLO!"
	templateName = "home.html"

	return render(request, templateName)