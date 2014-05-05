__author__ = 'danrwhitcomb'
from string import Template
import json

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
    status = {}
    error = {}
    content = {}
    isError = False
    isContent = False

    contentTemplate = Template("{'status':'$status', 'content':'$content'}")
    errorTemplate = Template("{'status':'$status', 'content':'$error'}")

    def __init__(self, m_status, m_error=None):
        if m_error is not None:

            self.status = str(m_status)
            self.error = m_error
            self.isError = True
        else:
            self.status = str(m_status)
            self.content = {}
            self.isContent = True


    def addContent(self, key, value):
        self.content[key] = value

    def addToContentValue(self, key, sub_key, value):
        val = self.content[key]
        val[sub_key] = value

    def __str__(self):
        if self.isContent:
            string = self.contentTemplate.substitute(status=self.status, content=self.content)
        else:
            string = self.errorTemplate.substitute(status=self.status, error=self.error)

        return json.dumps(string)
