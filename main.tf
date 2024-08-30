provider "aws" {
  region = "us-east-1"
}

resource "aws_ecr_repository" "example" {
  name = "aws_deploye"
}

resource "aws_ecs_cluster" "example" {
  name = "my-cluster"
}

resource "aws_ecs_task_definition" "example" {
  family                   = "my-task-family"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  container_definitions = jsonencode([{
    name      = "my-container"
    image     = "${aws_ecr_repository.example.repository_url}:latest"
    cpu       = 256
    memory    = 512
    essential = true

    portMappings = [{
      containerPort = 8080
    }]
  }])

  cpu    = "256"
  memory = "512"
}

resource "aws_ecs_service" "example" {
  name            = "my-service"
  cluster         = aws_ecs_cluster.example.id
  task_definition = aws_ecs_task_definition.example.arn
  desired_count   = 1

  network_configuration {
    subnets          = ["subnet-xxxxxx"]
    security_groups  = ["sg-xxxxxx"]
    assign_public_ip = true
  }
}
