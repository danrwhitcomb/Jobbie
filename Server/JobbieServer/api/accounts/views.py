from django.shortcuts import render
from django.http import HttpResponse
from django.contrib import auth
from django.contrib.auth.models import User
from json import loads
from api.accounts.models import SearchProfile
from api.data.models import Location
from Jobbie.keys import api_client_key
import random
import string
from django.contrib.auth.hashers import *
from api.common import *
import sys

# Create your views here.

'''
Request Handlers
'''
def index(request):
    return HttpResponse("You've reached the account API")


def new_user(request):

    result = request_checks(request, ['email_address',
                                    "first_name",
                                    "last_name",
                                    "client_key",
                                    "password"], "POST")

    if result is not None:
        return HttpResponse(str(result), content_type='application/json')

    user = None
    try:
        user = User.objects.get(email=request.POST['email_address'])
        output = Output(httpBadAuth, kStrBadAuth)
        return HttpResponse(str(output),
                            content_type='application/json')
    except:
        user = User.objects.create_user(username=request.POST['email_address'],
                                        email=request.POST['email_address'],
                                        password=request.POST['password'],
                                        first_name=request.POST['first_name'],
                                        last_name=request.POST['last_name'])

        user.save()

        create_session(request, user)
        auth.authenticate(username=user.username, password=user.password)
        output = Output(httpSuccess)
        output.addContent("first_name", user.first_name)
        output.addContent("last_name", user.last_name)

        response = HttpResponse(str(output), content_type='application/json')

        return response

def change_password(request):
    result = request_checks(request, ["password", "client_key"], "POST")
    if result is not None:
        return HttpResponse(str(result), 'application/json')

    if 'user' not in request.session:
        output = Output(httpBadAuth, kStrBadAuth)
        return HttpResponse(str(output), content_type='application/json')

    try:
        user = User.objects.get(username=request.session['user'])
        user.password = request.POST['password']
        user.save()
        output = Output(httpSuccess)
    except:
        output = Output(httpUserNotFound, kStrUserNotFound)
        return HttpResponse(str(output), content_type='application/json')

def update_email(request):
    result = request_checks(request, ["email_address", "client_key"], "POST")
    if result is not None:
        return HttpResponse(str(result), 'application/json')

    if 'user' not in request.session:
        output = Output(httpBadAuth, kStrBadAuth)
        return HttpResponse(str(output), content_type='application/json')

    try:
        user = User.objects.get(username=request.session['user'])
        user.email = request.POST['email_address']
        user.username = request.POST['email_address']

        user.save()
        request.session['user'] = request.POST['email_address']

        output = Output(httpSuccess)
    except:
        output = Output(httpBadAuth, kStrBadAuth)

    return HttpResponse(str(output), content_type='application/json')

def delete_user(request):
    check_result = check_method(request)
    if check_result is not None:
        return check_result

    check_result = validate_data(request, ["client_key", "email_address"])
    if check_result is not None:
        return check_result

    if 'user' not in request.session:
        output = Output(httpBadAuth, kStrBadAuth)
        return HttpResponse(str(output), content_type='application/json')

    user = User.objects.get(email=request.POST["email_address"])
    if user:

        user.delete()
        output = Output(httpSuccess)
        output.addContent("result", kStrSuccess)

        try:
            del request.session['user']
        except:
            pass

        return HttpResponse(str(output), content_type="application/json")
    else:
        output = Output(httpUserNotFound, kStrBadAuth)
        return HttpResponse(str(output), content_type="application/json")



def authenticate(request):
    method = request_checks(request, ['email_address', 'password', 'client_key'], "POST")
    if method is not None:
        return HttpResponse(str(method), content_type="application/json")

    print("Checking for user")
    sys.stdout.flush()
    if 'user' in request.COOKIES:
        output = Output(httpBadAuth, "This user is already logged in")
        return HttpResponse(str(output), content_type='application/json')

    print("Authenticating....")

    user = auth.authenticate(username=request.REQUEST['email_address'], password=request.REQUEST['password'])

    print("Got User...")
    sys.stdout.flush()
    if user is not None:
        output = Output(httpSuccess)
        output.addContent("first_name", str(user.first_name))
        output.addContent("last_name", str(user.last_name))
        output.addContent("email_address", str(user.email))
        request.session['user'] = user.username
        return HttpResponse(str(output), content_type='application/json')
    else:
        output = Output(httpBadAuth, kStrBadAuth)
        return HttpResponse(str(output),
                            content_type='application/json')


def new_search_profile(request):
    result = request_checks(request, ['profile', 'client_key'], "POST")
    if result is not None:
        return HttpResponse(str(result), content_type='application/json')

    try:
        username = request.session['user']
    except:
        output = Output(httpBadAuth, httpBadAuth)
        return HttpResponse(str(output), content_type='application/json')

    try:
        user = User.objects.get(username=username)
        sent_profile = loads('json', request.raw_post_data)
        search_profile = SearchProfile(user)
        search_profile.search_terms = sent_profile['search_terms']
        search_profile.distance = float(sent_profile['distance'])
        search_profile.company = sent_profile['company']

        locations = sent_profile['locations']

        for location in locations:
            try:
                isState = False
                state = None
                country = None
                try:
                    state = location['state']
                    city = location['city']
                    isState = True
                except:
                    city = location['state']
                    country = location['country']

                if isState:
                    loc = Location.objects.get(city=city, state=state)
                else:
                    loc = Location.objects.get(city=city, country=country)

            except:
                loc = Location()
                loc.city = location['city']
                loc.state = location['state']
                loc.country = location['country']
                loc.save()

            search_profile.locations.add(loc)

        search_profile.save()


        output = Output(httpSuccess)

        return HttpResponse(str(output), content_type='application/json')

    except:
        output = Output(httpBadAuth, kStrBadAuth)
        return HttpResponse(str(output), 'application/json')

def update_search_profile(request):
    result = request_checks(request, ["profile", "client_key"], "POST")
    if result is not None:
        return HttpResponse(json.dumps(result), content_type='application/json')

    try:
        user = request.session['user']
    except:
        output = Output(httpUserNotFound, kStrUserNotFound)
        return HttpResponse(str(output), content_type='application/json')

    try:
        search_profile = SearchProfile.objects.get(user=user)
        sent_profile = loads('json', request.raw_post_data)
        search_profile.search_terms = sent_profile['search_terms']
        search_profile.distance = sent_profile['distance']
        search_profile.company = sent_profile['company']

        search_profile.locations = None

        for location in sent_profile['locations']:
            try:
                isState = False
                state = None
                country = None
                try:
                    state = location['state']
                    city = location['city']
                    isState = True
                except:
                    city = location['state']
                    country = location['country']

                if isState:
                    loc = Location.objects.get(city=city, state=state)
                else:
                    loc = Location.objects.get(city=city, country=country)

            except:
                loc = Location()
                loc.city = location['city']
                loc.state = location['state']
                loc.country = location['country']
                loc.save()

            search_profile.locations.add(loc)

        search_profile.save()
        return HttpResponse(str(Output(httpSuccess)), content_type='application/json')

    except:
        return HttpResponse(str(Output(httpError, kStrError)), content_type='application/json')

def update_job_set(request):
    result = request_checks(request, ['list', 'jobs', 'client_key'])
    if result is not None:
        return HttpResponse(str(result), content_type='application/json')

    try:
        username = request.session['user']
        user = User.objects.get(username=username)
    except:
        return HttpResponse(str(Output(httpBadAuth, kStrBadMethod)), content_type='application/json')

    set = request.POST['set']
    search_profile = user.search_profile

    if set == 'job_list':
        set = search_profile.job_list
    elif set == 'job_opps':
        set = search_profile.job_opps
    else:
        set = search_profile.job_matches

    jobs = loads('json', request.POST['jobs'])

    #for job in jobs:
     #   try:



'''
Helper Methods

'''
def request_checks(request, args, method):
    check_result = check_method(request, method)
    if check_result is not None:
        return check_result

    check_result = validate_data(request, args)
    if check_result is not None:
        print("Failed data validation")
        sys.stdout.flush()
        return check_result


    if request.REQUEST['client_key'] != api_client_key:
        print("Failed client_key")
        sys.stdout.flush()
        output = Output(httpBadClientKey)
        return output


    return None


def validate_data(request, strings):
    print("Validating Data..")
    print(strings)
    print(request.REQUEST.items())
    print(request)
    sys.stdout.flush()
    for ind in strings:
        if not ind in request.REQUEST:
            return Output(httpBadArguments)

    return None


def check_method(request, method):
    if request.method != method:
        output = Output(httpBadMethod)
        return output
    else:
        return None


def create_session(request, user):
    request.session['user'] = user.username

def generate_token():
    return ''.join(random.choice(string.printable) for i in range(30)).translate(None, " ")


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

def validate_password(given_password, user):
    encrypted_password = make_password(given_password, user.salt)

    return encrypted_password == user.encrypted_password