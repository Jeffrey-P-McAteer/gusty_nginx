from django.shortcuts import render
from django.http import HttpResponse

def index(request):
    print("home Gusty")
    return render(request, 'personal/home.html')

def contact(request):
    #return HttpResponse("<h2>Hey!</h2>")
    print("contact Gusty")
    return render(request, 'personal/contact.html', {'content':['<b>email</b>: gusty@gusty.bike','We may meet bicycling.']})

def search(request):
    return render(request, 'personal/search.html')

def searchResults(request):
    if request.method == 'GET':
        print('GET')
    elif request.method == 'POST':
        print('POST')
    else:
        print('Not GET nor POST')

    if request.GET.get('q'):
        message = 'Your submitted search value: %r' % request.GET['q']
    else:
        message = 'Your submitted search value: nothing!'
    print("Search", message)
    return render(request, 'personal/search.html', {'content':[message]})

def login(request):
    if request.method == 'GET':
        print('GET')
    elif request.method == 'POST':
        print('POST')
    else:
        print('Not GET nor POST')

    username = 'Your submitted login username: nothing!'
    password = 'Your submitted login password: nothing!'
    if request.GET.get('username'):
        username = 'Your submitted login username: %r' % request.GET['username']
    if request.GET.get('password'):
        password = 'Your submitted login password: %r' % request.GET['password']

    print("Login", username, password)
    return render(request, 'personal/login.html', {'content':[username, password]})

def about(request):
    content = {'content':
    ['gustyDotBike is a website for programmers who love to bicycle.',
     'gustyDotBike is a website for bicyclists who love to program.',
     'The website chronicles adventures in bicycling, programming, guitar playing, international relations, story telling, and fun.',
    ]}
    return render(request, 'personal/about.html', content)

