resource "aws_iam_server_certificate" "test_site_com" {
  name      = "test_site_com"
  certificate_body = "${file("../secrets/files/tls/cert/test.site.com.crt")}"
  private_key      = "${file("../secrets/files/tls/key/test.site.com.key")}"
}