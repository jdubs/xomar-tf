variable "domain_name" {
  description = "The domain name for Route 53 lookup"
  type        = string
  default     = "xomar.com" # Change this or pass it as a CLI argument
}

variable "subdomains" {
  description = "List of subdomains"
  type        = list(string)
  default     = ["www", "api"]
}
