output "application_endpoint" {
  value = "${aws_alb.ecs_alb.dns_name}"
}

output "umg-repository-URL" {
  value = "${aws_ecr_repository.umg_repo.repository_url}"
}
