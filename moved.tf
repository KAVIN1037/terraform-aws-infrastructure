moved {
  from = aws_instance.web
  to   = module.compute.aws_instance.web
}

moved {
  from = aws_eip.web
  to   = module.compute.aws_eip.web
}

moved {
  from = aws_eip_association.web
  to   = module.compute.aws_eip_association.web
}
