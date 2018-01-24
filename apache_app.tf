# app

data "template_file" "app-task-definition-template" {
  template = "${file("templates/app.json.tpl")}"

  vars {
    REPOSITORY_URL = "${replace("${aws_ecr_repository.umg_repo.repository_url}", "https://", "")}"
    VERSION        = "${var.app_version}"
  }
}

resource "aws_ecs_task_definition" "app-task-definition" {
  family                = "app"
  container_definitions = "${data.template_file.app-task-definition-template.rendered}"
}

resource "aws_ecs_service" "app-service" {
  name            = "app"
  cluster         = "${aws_ecs_cluster.umg_cluster.id}"
  task_definition = "${aws_ecs_task_definition.app-task-definition.arn}"
  desired_count   = 1
  iam_role        = "${aws_iam_role.ecs_service_role.arn}"
  depends_on      = ["aws_iam_policy_attachment.ecs-service-attach1"]

  load_balancer {
    target_group_arn = "${aws_alb_target_group.alg_tg.arn}"
    container_name   = "app"
    container_port   = 8080
  }

  lifecycle {
    ignore_changes = ["task_definition"]
  }
}
