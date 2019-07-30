
resource "aws_launch_configuration" "ecs-launch-configuration" {
    //image_id                    = "ami-0dca97e7cde7be3d5"
    image_id                    = "${data.aws_ami.latest_ecs.id}"
    instance_type               = "${var.service_app_instance_type}"
    iam_instance_profile        = "${aws_iam_instance_profile.ecs-instance-profile.id}"
    
    root_block_device {
      volume_type = "standard"
      volume_size = 32
      delete_on_termination = true
    }

    lifecycle {
      create_before_destroy = true
    }

    security_groups             = ["${aws_security_group.ContainerServiceapp.id}"]
    associate_public_ip_address = "true"
    key_name                    = "${var.ecs_key_pair_name}"
    user_data                   = <<EOF
#!/bin/bash
echo ECS_CLUSTER="${var.aws_resource_base_name}_${var.ecs_cluster}" >> /etc/ecs/ecs.config
echo ECS_BACKEND_HOST= >> /etc/ecs/ecs.config;
EOF
    
    
}