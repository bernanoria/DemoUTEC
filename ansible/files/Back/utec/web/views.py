# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.shortcuts import render
from .models import Person
from .serializers import PersonSerializer
from rest_framework.viewsets import ModelViewSet
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from django.http import HttpResponseRedirect, HttpResponse
import  json
from django.core import serializers
from django.conf import settings
from rest_framework.generics import ListAPIView, RetrieveAPIView




class PersonViewSet(ModelViewSet):
    model = Person
    queryset= Person.objects.all()
    serializer_class = PersonSerializer
    http_method_names = ['get']


@api_view(["POST"])
def crearperson(request):
    #import ipdb; ipdb.set_trace()
    try:
        nombre = request.data['nombre']
        apellido = request.data['apellido']
        mensaje = request.data['mensaje']
        usuario = Person(first_name=nombre, last_name=apellido, message=mensaje)
        usuario.save()
        return HttpResponse(json.dumps({"mensaje": "Usuario creado"}), status=status.HTTP_200_OK, content_type="application/json")
    except Exception as e:
        return HttpResponse(json.dumps({"mensaje": "Problemas al crear usuario."}), status=status.HTTP_200_OK, content_type="application/json")

