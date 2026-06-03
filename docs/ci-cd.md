# Application CI/CD Setup

This runbook documents the application repository pipeline used by the
GitOpsLedger project.

## Pipeline Flow

The workflow file is `.github/workflows/ci.yml`.

```text
Pull request to main:
  Maven build -> unit tests -> Checkstyle -> SonarQube scan -> quality gate

Push to main:
  Docker build -> push image to Amazon ECR -> update Helm values in gitopsledger-helm
```

Feature branch pushes do not run the pipeline unless a pull request targets
`main`.

## 1. SonarQube on EC2

Provision an Ubuntu EC2 instance for self-hosted SonarQube:

| Setting | Value |
| --- | --- |
| AMI | Ubuntu 22.04 |
| Instance type | `t3.medium` or larger |
| Inbound 22/TCP | Your IP |
| Inbound 80/TCP | Public or restricted to your team |

After SonarQube is running:

1. Open `http://<sonarqube-ec2-ip>`.
2. Log in with the initial admin account.
3. Change the default password.
4. Generate a global analysis token for GitHub Actions.
5. Store the token as `SONAR_TOKEN` in GitHub Actions secrets.

Keep tokens out of the repository. Only secret names are documented here.

## 2. SonarQube Project Settings

The scanner reads project settings from `sonar-project.properties`.

Important fields:

```properties
sonar.projectKey=opsledger-app
sonar.projectName=opsledger-app
sonar.sources=src/
sonar.java.binaries=target/classes
```

Run local Maven verification before opening a pull request:

```sh
mvn -B clean verify
```

## 3. Amazon ECR

Create or confirm the private ECR repository used by the workflow:

```text
Repository: opsledgerappimg
Region: ap-southeast-3
```

The workflow tags the application image with both the commit SHA and `latest`.
The SHA tag is written into the Helm repo so Argo CD can deploy an immutable app
version.

## 4. GitHub Actions Secrets

Create these repository secrets under:

```text
Settings -> Secrets and variables -> Actions -> Secrets
```

| Secret | Purpose |
| --- | --- |
| `SONAR_TOKEN` | Authenticates SonarQube scan and quality gate checks |
| `AWS_ACCESS_KEY_ID` | Allows GitHub Actions to push to ECR |
| `AWS_SECRET_ACCESS_KEY` | Secret key for the ECR publishing user |
| `HELM_REPO_USER` | GitHub user or organization that owns the Helm repo |
| `GITOPS_PAT` | Fine-grained PAT with read/write content access to the Helm repo |
| `SLACK_WEBHOOK` | Optional deployment notification webhook |

Use a fine-grained PAT for `GITOPS_PAT` and grant access only to the Helm
repository.

## 5. GitHub Actions Variables

Create these repository variables under:

```text
Settings -> Secrets and variables -> Actions -> Variables
```

| Variable | Purpose |
| --- | --- |
| `AWS_REGION` | AWS region for ECR, default `ap-southeast-3` |
| `ECR_REPOSITORY` | ECR repository name, default `opsledgerappimg` |
| `HELM_REPO_NAME` | Helm repository name, default `gitopsledger-helm` |
| `SONAR_HOST_URL` | Base URL for the self-hosted SonarQube server |

## 6. Branch Protection

Protect `main` so code quality gates cannot be bypassed:

1. Open GitHub repository settings.
2. Create a branch ruleset for `main`.
3. Require pull requests before merging.
4. Require the `Maven, Checkstyle, and SonarQube` status check.
5. Block force pushes.

## 7. Working Branch Flow

```sh
git checkout -b feature-your-change
git add .
git commit -m "Describe the change"
git push -u origin feature-your-change
```

Open a pull request into `main`. After the pull request checks pass and the PR is
merged, the push workflow builds the image, pushes it to ECR, and updates
`helm/opsledger/values.yaml` in the Helm repository.
