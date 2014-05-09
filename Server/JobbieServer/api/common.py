__author__ = 'danrwhitcomb'
from string import Template
import json
import sys

#HttpResponseCodes
httpSuccess         = 0
httpError           = 1
httpBadMethod       = 2
httpBadArguments    = 3
httpBadClientKey    = 4
httpBadAuth         = 5
httpUserNotFound    = 6

#HttpMessages
kStrSuccess         = "Operation completed successfully"
kStrError           = "Internal Server Error"
kStrBadMethod       = "The requested method is not supported"
kStrArguments       = "The provided arguments are invalid"
kStrBadClientKey    = "Invalid key. You are unauthorized to use this service"
kStrBadAuth         = "Invalid credentials"
kStrUserNotFound    = "The user cannot be found"

class Output:
    def __init__(self, m_status, m_error=None):
        print("Creating Output")
        sys.stdout.flush()

        self.status = str(m_status)
        self.content = {}

    def addContent(self, key, value):
        self.content[key] = value

    def addToContentValue(self, key, sub_key, value):
        val = self.content[key]
        val[sub_key] = value

    def __str__(self):
        dictionary = {'content': self.content, 'status': self.status}
        return json.dumps(dictionary)
