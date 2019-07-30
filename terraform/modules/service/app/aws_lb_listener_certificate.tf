/**
@TODO - support mutli certs per LB, SNI
resource "aws_lb_listener_certificate" "tls_cert_0" {
  listener_arn    = "${aws_alb_listener.alb_listener_https.arn}"
  certificate_arn = "${var.ssl_cert_arn}"
}
*/