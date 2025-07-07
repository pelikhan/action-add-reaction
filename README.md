# Add Eyes Reaction Action

A GitHub Action that adds an 👀 reaction to the current issue, pull request or comment.

## Usage

You can add this action in any of your workflows to quickly
add a `eyes` reaction to issues or pull requests when they are opened, reopened, or edited. It's an immediate user feedback.

Support `issues`, `pull_request`, `pull_request_target`, `issue_comment`, and `pull_request_review_comment` events.

```yaml
jobs:
  add-reaction:
    permissions:
      issues: write # needed for issues, issues_comment
      pull-requests: write # needed for pull_request, pull_request_target, pull_request_review_comment
    runs-on: ubuntu-latest
    steps:
      - uses: pelikhan/action-add-reaction@v0
```

If you already have existing steps in your workflow,
it is recommended to keep the `add-reaction` job separate
so that it executes instantly rather than waiting
for containers to be built.

## Inputs

| Name | Description | Required | Default |
|------|-------------|----------|---------|
| `token` | GitHub token used to add reactions | Yes | `${{ github.token }}` |
| `reaction` | Type of reaction to add | No | `eyes` |

## Available Reaction Types

- `+1` (👍)
- `-1` (👎)
- `laugh` (😄)
- `confused` (😕)
- `heart` (❤️)
- `hooray` (🎉)
- `rocket` (🚀)
- `eyes` (👀)

## License

This project is licensed under the terms of the license included in this repository.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
