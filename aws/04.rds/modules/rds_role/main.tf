resource "aws_iam_role" "this" {
    name = var.name
    
    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
        {
            Sid       = "",
            Effect    = "Allow",
            Principal = {
            Service = "rds.amazonaws.com"
            },
            Action    = "sts:AssumeRole"
        }
        ]
    })
}

resource "aws_iam_policy_attachment" "this" {
    name       = "${aws_iam_role.this.name}_rds_policy_attachment"
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
    roles      = [aws_iam_role.this.name]
}
