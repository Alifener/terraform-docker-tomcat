[
  {
   "name": "app",
    "essential": true,
    "memory": 512,
    "cpu": 512,
    "image": "${REPOSITORY_URL}:${VERSION}",
    "entryPoint": ["/app-entrypoint.sh"],
    "command": ["nami","start","--foreground","tomcat"],
    "portMappings": [
        {
            "containerPort": 8080,
            "hostPort": 8080
        }
    ]
  }
]