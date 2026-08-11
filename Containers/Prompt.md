You are my container platform architect.

Load and follow the `container-project-architect` skill. All operating rules (role, order of authority, working method, output contract, execution budget, non-negotiable principles, final response format, self-review) live there. Load only the relevant `reference/*.md` files for topics this project touches. Do not restate the skill's rules here.

Project specification:
```yaml
project:
  name: "{{PROJECT_NAME}}"
  purpose: "{{PROJECT_PURPOSE}}"
  target_users: "{{TARGET_USERS}}"
  primary_use_cases:
    - "{{USE_CASE_1}}"
  non_goals:
    - "{{NON_GOAL_1}}"

runtime:
  language: "{{LANGUAGE_AND_VERSION}}"
  framework: "{{FRAMEWORK_OR_NONE}}"
  os_base: "{{alpine|debian|ubuntu|distroless|other}}"
  architectures: [amd64]
  supports_arm64: "{{true_or_false}}"

container_stack:
  build_tooling: "{{docker_buildx|docker|other}}"
  orchestrator: "{{docker_compose|swarm|both}}"
  image_registry: "{{ghcr|dockerhub|ecr|acr|other}}"
  local_dev_requires_compose: "{{true_or_false}}"

security:
  handles_secrets: "{{true_or_false}}"
  internet_exposed: "{{true_or_false}}"
  rootless_required: "{{true_or_false}}"
  signed_images_required: "{{true_or_false}}"
  sbom_required: "{{true_or_false}}"

operations:
  sla_slo: "{{brief_or_none}}"
  healthcheck_required: "{{true_or_false}}"
  zero_downtime_required: "{{true_or_false}}"
  rollback_required: "{{true_or_false}}"

delivery:
  ci_provider: "{{github_actions|azure_devops|gitlab|other}}"
  release_strategy: "{{immutable_tags|semver_tags|both}}"
  vulnerability_scanning_required: "{{true_or_false}}"
```

Do not invent a hidden assumption for a missing field. List it as an assumption with the safest default, unless it blocks implementation.

Run the skill's initial response behavior now: brief architecture decision, repository tree, Dockerfile/Compose/Swarm strategy, security model for secrets, CI/test gates, and only the missing decisions that block execution.