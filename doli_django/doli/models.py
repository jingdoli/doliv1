from django.db import models
from django.contrib.auth.models import User
from swingtime.models import *


class Calendar(models.Model):
    """
    A generic model for user Calendar.

    """
    calendarid = models.AutoField(primary_key = True)
    userid = models.ForeignKey(User, verbose_name = "The user id associated with this calendar")


class UserWidgets(models.Model):
    """docstring for UserWidgets
    """
    userid = models.ForeignKey(User, primary_key = True)
    calendarid = models.ForeignKey(Calendar)
    #notesid = models.ForeignKey(notes)

 
