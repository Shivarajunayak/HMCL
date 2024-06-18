output "load_balancer_arn" {
  value       = aws_lb.load_balancer.arn
  description = "Load Balancer ARN"
}

output "target_group_arn" {
  value = {
    for k, v in aws_lb_target_group.target_group : k => v.arn
  }
  description = "Target Group ARN"
}

output "listener_arn" {
  value = {
    for k, v in aws_lb_listener.listener : k => v.arn
  }
  description = "Listener ARN"
}
