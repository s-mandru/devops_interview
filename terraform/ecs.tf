resource "aws_ecs_cluster" "cluster" {
  name = "cohere"
}

resource "aws_ecs_service" "cohere" {
  name            = "cohere"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.taskdefinition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = aws_lb_target_group.tg.arn
    container_name   = "cohere"
    container_port   = 8080
  }

  network_configuration {
    subnets         = module.vpc.private_subnets
    security_groups = [aws_security_group.allow_internal.id]
  }

}

resource "aws_ecs_task_definition" "taskdefinition" {
  family                   = "cohere"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = aws_iam_role.iam_role.arn
    task_role_arn            = aws_iam_role.iam_role.arn

  container_definitions = jsonencode(
    [
      {
        "name" : "cohere",
        "image" : "039914463580.dkr.ecr.us-east-1.amazonaws.com/coherehealth:latest",
        "cpu" : 1024,
        "memory" : 2048,
        "essential" : true
        "portMappings" = [
          {
            "containerPort" = 8080
            "hostPort"      = 8080
            "protocol"      = "tcp"
          }
        ]
      }
  ])
}
