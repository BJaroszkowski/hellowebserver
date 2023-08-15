from django.http import HttpResponse


def index(request):
    return HttpResponse('Hello, Mad World!')
