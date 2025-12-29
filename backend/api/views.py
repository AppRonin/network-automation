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
from rest_framework.permissions import IsAuthenticated
from django.core.files.storage import default_storage

r = redis.Redis()

class GponConversorView(APIView):
    parser_classes = (MultiPartParser, FormParser)
    permission_classes = [IsAuthenticated]

    PORT_PATTERN = r"^\d+\/\d+\/\d+$" # 1/1/1
    MAX_FILE_SIZE = 2 * 1024 * 1024  # 2 MB

    def post(self, request):
        task_id = str(uuid.uuid4())
        uploaded_file = request.FILES.get("file")
        port = request.data.get("port")

        if not uploaded_file:
            return Response({"error": "No file provided"}, status=400)
        
        if uploaded_file.size > self.MAX_FILE_SIZE:
            return Response({"error": "File too large. Max size is 2MB"}, status=400)

        # Allow only .txt
        if not uploaded_file.name.lower().endswith(".txt"):
            return Response({"error": "Only .txt files are allowed"}, status=400)

        # Validate port
        if not port or not re.match(self.PORT_PATTERN, port):
            return Response({"error": "Invalid port format"}, status=400)

        file_path = default_storage.save(f"uploads/{task_id}.txt", uploaded_file)

        gpon_conversor.send(task_id, file_path, port)

        # For now: just return the contents
        return Response({"task_id": task_id})

class ProgressView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, task_id):
        progress = r.get(f"progress:{task_id}")
        result = r.get(f"result:{task_id}")

        return Response({
            "progress": int(progress) if progress else 0,
            "result": ast.literal_eval(result.decode()) if result else None
        })
