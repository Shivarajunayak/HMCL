
output "kinesisanalytics_application_arn" {
  description = "The ARN of the Kinesis Analytics application"
  value       = aws_kinesisanalyticsv2_application.example.arn
}