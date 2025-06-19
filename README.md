# Add Eyes Reaction Action

A GitHub Action that adds an eyes reaction (👀) to the current issue or pull request.

## Usage

Add this action to your workflow file:

```yaml
name: Add Eyes Reaction

on:
  issues:
    types: [opened, reopened, edited]
  pull_request:
    types: [opened, reopened, edited]
  issue_comment:
    types: [created, edited]
  pull_request_review_comment:
    types: [created, edited]
permissions:
  issues: write
  pull-requests: write
jobs:
  add-reaction:
    runs-on: ubuntu-latest
    steps:
      - uses: pelikhan/action-add-reaction@v0
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          # Optional: override the default 'eyes' reaction
          # reaction: heart
```

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
