terraform {
  required_version = "~> 1.5.0"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
}

resource "github_repository" "repo" {
  name               = "DevOps-Course-Terraform-Repo"
  description        = "DevOps course. Terraform lab."
  visibility         = "public"
  has_issues         = true
  has_wiki           = true
  auto_init          = true
  license_template   = "mit"
  gitignore_template = "VisualStudio"
}

resource "github_branch_default" "main" {
  repository = github_repository.repo.name
  branch     = "main"
}

resource "github_branch_protection" "default" {
  repository_id                   = github_repository.repo.id
  pattern                         = github_branch_default.main.branch
  require_conversation_resolution = true
  enforce_admins                  = true

  required_pull_request_reviews {
    required_approving_review_count = 1
  }
}

resource "github_repository" "devops-course" {
  name          = "devops-course"
  description   = "Description by terraform"
}