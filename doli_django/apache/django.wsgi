import os,sys

apache_configuration = os.path.dirname(__file__)
project = os.path.dirname(apache_configuration)
workspace = os.path.dirname(project)
sys.path.append(workspace)
sys.path.append('/home/jing/ws/django_proj/doli')
sys.path.append('/home/jing/ws/django_proj/doli')

os.environ['DJANGO_SETTINGS_MODULE'] = 'doli.settings'

import django.core.handlers.wsgi
application = django.core.handlers.wsgi.WSGIHandler()
