variable "lambda_name" {
  description = "name of the lambda"
  type        = string
  default     = "subscription-checker-test"
}

variable "subscription_backend_api_gateway_endpoint_url" {
  description = "name of the lambda"
  type        = string
  default     = "https://6p40sns60g.execute-api.eu-central-1.amazonaws.com"
}

variable "nuvibit_lambda_layer_arns" {
  description = "ARNS of the Lambda Layers"
  type        = list(string)
  default = [
    "arn:aws:lambda:eu-central-1:634353262874:layer:sourcedefender:31",
    "arn:aws:lambda:eu-central-1:634353262874:layer:subscription_checker:9"
  ]
}