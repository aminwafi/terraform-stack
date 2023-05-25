resource "aws_instance" "instance" {
    ami                     = "${var.instance_ami}"
    instance_type           = "${var.instance_type}"
    subnet_id               = aws_subnet.public_subnet.id
    vpc_security_group_ids  = [aws_security_group.sg.id]
    key_name                = aws_key_pair.key_pair.key_name
    tags                    = {
        "Name"              = "${var.project_name}-${var.node_env}-server"
    }
}