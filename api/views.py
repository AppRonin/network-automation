from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.parsers import MultiPartParser, FormParser
from tasks.workers import gpon_conversor
import uuid

class GponConversorView(APIView):
    parser_classes = (MultiPartParser, FormParser)

    def post(self, request):
        task_id = str(uuid.uuid4())
        uploaded_file = request.FILES.get("file")

        if not uploaded_file:
            return Response({"error": "No file provided"}, status=400)

        # Read entire file as text
        file_content = uploaded_file.read().decode("utf-8", errors="ignore")

        gpon_conversor(task_id, file_content)

        # For now: just return the contents
        return Response({"task_id": task_id})

class ProgressView(APIView):
    def get(self, request, task_id):
        pass