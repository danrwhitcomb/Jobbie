from django.shortcuts import render
from django.http import HttpResponse
from api.accounts.models import User
from Jobbie.keys import client_key
import random
import string
from string import Template
from django.contrib.auth.hashers import *

# Create your views here.

def index(request):
    return HttpResponse("You've reached the account API")


def new_user(request):
    method = check_post_method(request)
    if method is not None:
        return method

    result = validate_data(request, ["client_key", "email_address", "name", "password"])
    if result is not None:
        return result

    output = {}
    sent_client_key = request.POST['client_key']

    if sent_client_key != client_key:
        return HttpResponse("{'status':'2','error':'You are not authorized to use this service'}",
                            content_type='application/json')
    else:

        user = User.object.get(email_address=request.POST['email_address'])
        if user:
            return HttpResponse("{'status':'3','error':'email_address is already being used'}",
                                content_type='application/json')
        else:
            user = User()

        user.email_address = request.POST['email_address']
        user.name = request.POST['name']
        user.password_salt = generate_salt()
        user.encrypted_password = make_password(request.POST['password'], user.password_salt)

        user.token = unique_token()
        user.save()

        output["status"] = 0
        output["content"] = {}
        output["content"]["user"] = user

        return HttpResponse(str(output), content_type='application/json')


def authenticate(request):
    method = check_post_method(request)
    if method is not None:
        return method

    result = validate_data(request, ["email_address", "password"])
    if not result:
        return HttpResponse("Please provide a username and password")

    user = User.objects.get(email_address=request.POST['email_address'])
    if not user:
        return HttpResponse("{'status':'1', 'error':'The requested user does not exist'}",
                            content_type='application/json')

    encrypted_password = make_password(request.POST['password'], user.password_salt)
    if encrypted_password == user.encrypted_password:
        user.token = unique_token()
        s = Template("{'status':'0', 'content':{'name':'$name', 'search_profile':'$search_profile', 'token':'$token'}}")
        response = s.substitute(name=user.name, search_profile=str(user.search_profiles), token=user.token)

        return HttpResponse(response, content_type='application/json')
    else:
        return HttpResponse("{'status':'2', 'error':'The provided username or password was incorrect'}",
                            content_type='application/json')


def validate_data(request, strings):
    for ind in strings:
        try:
            val = request.POST[ind]

        except KeyError:
            output = {}

            output['status'] = 0
            output['content'] = {}
            output['error'] = [{"KeyError": "Missing POST data"}]

            return HttpResponse(str(output))

    return None


def check_post_method(request):
    """

    :rtype : HttpResponse
    """
    if request.method != "POST":
        return HttpResponse("Please use POST to create a new user", content_type="application/json")
    else:
        return None


def generate_token():
    return ''.join(random.choice(string.printable) for i in range(40)).translate(None, " ")


def unique_token():
    new_token = None

    while new_token is None:
        new_token = generate_token()
        try:
            User.objects.get(token=new_token)
        except User.DoesNotExist:
            return new_token

def generate_salt():
    return ''.join(random.choice(string.printable) for i in range(10)).translate(None, " ")
