resource "aws_budgets_budget" "cybershady_budget" {
  name              = "monthly-budget"
  budget_type       = "COST"
  limit_amount      = "100.00"
  limit_unit        = "USD"
  time_unit         = "MONTHLY"
  time_period_start = "2022-03-21_00:01"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = ["<redacted>"]
  }
}
