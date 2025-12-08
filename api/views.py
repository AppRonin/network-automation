from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.parsers import MultiPartParser, FormParser


class StartTaskView(APIView):
    parser_classes = (MultiPartParser, FormParser)

    def post(self, request):
        uploaded_file = request.FILES.get("file")

        if not uploaded_file:
            return Response({"error": "No file provided"}, status=400)

        # Read entire file as text
        file_content = uploaded_file.read().decode("utf-8", errors="ignore")

        print(file_content)
        # For now: just return the contents
        return Response({
            "filename": uploaded_file.name,
            "content": file_content,
        })

class ProgressView(APIView):
    def get(self, request, task_id):
        pass