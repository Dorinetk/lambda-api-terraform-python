variable "log_group_name" {
  description = "Name of log group."
  type        = string
  
}

/*variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}*/

variable "retention_in_days" {
  description = "retention days"
  type        = number
 
}