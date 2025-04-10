# Terraform Reconcile

Terraform Reconcile job performs a check of existing infrastructure and compares it with desired state, defined in the Terraform code. If the existing infrastructure is aligned with the desired state, then the job succeeds. Otherwise, if there is a discrepancy between the desired state and the existing infrastructure, the job fails. The Terraform Reconcile job does not make any changes to the infrastructure. Terraform Reconcile runs periodically on schedule.

[![terraform-eks](https://github.com/goodsystems/terraform-eks/actions/workflows/terraform-eks.yml/badge.svg?event=schedule)](https://github.com/goodsystems/terraform-eks/actions/workflows/terraform-eks.yml)