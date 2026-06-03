# GitOpsLedger App Docs

This folder captures application CI/CD setup notes and screenshot evidence for
the OpsLedger Java web application repository.

## Contents

- [CI/CD Setup](ci-cd.md) - SonarQube, ECR, GitHub Actions, Helm repo update, and branch protection setup.
- [screenshots/](screenshots/) - Copied evidence images with markdown-friendly filenames.

## Repository Role

This repo owns the application source code and delivery pipeline:

- Java Spring MVC application source, tests, and resources
- Docker image build for the OpsLedger web application
- Maven build, unit tests, Checkstyle, and SonarQube scan
- Amazon ECR image publishing
- Cross-repo Helm values update after a successful merge to `main`
