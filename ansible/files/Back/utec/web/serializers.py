# -*- coding: utf-8 -*-
from rest_framework.serializers import ModelSerializer, PrimaryKeyRelatedField
from .models import Person
from django.conf import settings


class PersonSerializer(ModelSerializer):
    class Meta:
        model = Person
        fields = (
            'first_name', 'last_name', 'message'
        )
