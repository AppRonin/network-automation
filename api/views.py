import ast
import uuid
import re
import redis
from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.parsers import MultiPartParser, FormParser
from tasks.workers import gpon_conversor
from django.urls import path
from rest_framework.response import Response
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated

r = redis.Redis()

class GponConversorView(APIView):
    parser_classes = (MultiPartParser, FormParser)
    PORT_PATTERN = r"^\d+\/\d+\/\d+$"

    def post(self, request):
        task_id = str(uuid.uuid4())
        uploaded_file = request.FILES.get("file")
        port = request.data.get("port")

        if not uploaded_file:
            return Response({"error": "No file provided"}, status=400)
        
        # Allow only .txt
        if not uploaded_file.name.lower().endswith(".txt"):
            return Response({"error": "Only .txt files are allowed"}, status=400)
        
        # Validate port
        if not port or not re.match(self.PORT_PATTERN, port):
            return Response({"error": "Invalid port format"}, status=400)

        gpon_conversor(task_id, uploaded_file, port)

        # For now: just return the contents
        return Response({"task_id": task_id})

class ProgressView(APIView):
    def get(self, request, task_id):
        progress = r.get(f"progress:{task_id}")
        result = r.get(f"result:{task_id}")

        return Response({
            "progress": int(progress) if progress else 0,
            "result": ast.literal_eval(result.decode()) if result else None
        })
