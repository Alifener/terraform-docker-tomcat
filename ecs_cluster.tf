resource "aws_ecs_cluster" "umg_cluster" {
  name = "umg_cluster"
}

resource "aws_launch_configuration" "umg_launchconfig" {
  name_prefix          = "launchconfig_umg"
  image_id             = "${lookup(var.ECS_AMIS, var.AWS_REGION)}"
  instance_type        = "${var.ec2_machine_type}"
  key_name             = "${aws_key_pair.key.key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.ecs_ec2_role.id}"
  security_groups      = ["${aws_security_group.sg_ecs_cluster.id}"]
  user_data            = "#!/bin/bash\necho 'ECS_CLUSTER=umg_cluster' > /etc/ecs/ecs.config\nstart ecs"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "prod_autoscaling" {
  name                 = "umg_autoscaling"
  vpc_zone_identifier  = ["${aws_subnet.umg_public_a.id}"]
  launch_configuration = "${aws_launch_configuration.umg_launchconfig.name}"
  min_size             = "1"
  max_size             = "1"

  tag {
    key                 = "Name"
    value               = "ECS instance UMG"
    propagate_at_launch = true
  }
}
