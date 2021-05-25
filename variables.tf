variable "tags" {
  description = "A mapping of tags to assign to resources."
  default = {}
  type = map(string)
}
variable "environment" {
  type = string
  default = ""
}
