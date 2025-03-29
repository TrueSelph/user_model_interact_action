# User Model Interact Action

![GitHub release (latest by date)](https://img.shields.io/github/v/release/TrueSelph/user_model_interact_action)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/TrueSelph/user_model_interact_action/test-action.yaml)
![GitHub issues](https://img.shields.io/github/issues/TrueSelph/user_model_interact_action)
![GitHub pull requests](https://img.shields.io/github/issues-pr/TrueSelph/user_model_interact_action)
![GitHub](https://img.shields.io/github/license/TrueSelph/user_model_interact_action)

JIVAS action for maintaining a conceptual user model by monitoring conversational exchanges.

## Package Information

- **Name:** `jivas/user_model_interact_action`
- **Author:** [V75 Inc.](https://v75inc.com/)
- **Architype:** `UserModelInteractAction`

## Meta Information

- **Title:** User Model Interact Action
- **Group:** core
- **Type:** interact_action

## Configuration

- **Singleton:** true
- **Order:**
  - **Weight:** 0
  - **Before:** persona_interact_action

## Dependencies

- **Jivas:** `^2.0.0`
- **Actions:**
  - `jivas/persona_interact_action`: `^0.0.1`
  - `jivas/langchain_model_action`: `^0.0.1`

This package, developed by V75 Inc., is designed to develop and maintain a conceptual understanding of the user by monitoring conversational exchanges. As a core interact action, it plays a critical role in personalizing and adapting the system to meet the user's specific needs. Configured as a singleton, the package requires the Jivas library version 2.0.0 and depends on the `persona_interact_action` and `langchain_model_action` for effective operation.

---

## How to Use

Below is detailed guidance on how to configure and use the User Model Interact Action.

### Overview

The User Model Interact Action provides an abstraction layer for maintaining a user model based on conversational exchanges. It supports multiple configurations for various use cases, including:

- **User profiling** based on conversational history.
- **Integration** with other actions to adapt the system to user-specific needs.

---

### Configuration Structure

The configuration consists of the following components:

### `user_model_template`

Defines the initial structure of the user model.

```python
user_model_template = "**User Model:**\n- **Personal Information and Demographics:**\n- **Preferences and Interests:**"
```

### `anchors`

Defines the key areas of focus for user profiling.

```python
anchors = [
    "The user shares personal information and demographics",
    "The user shares preferences and interests",
    "The user shares behavioral patterns and habits",
    "The user shares personal opinions, values, or beliefs",
    "The user shares goals and needs",
    "Mentions of relationships with family, friends, or colleagues"
]
```

---

### Example Configurations

### Basic Configuration for User Model Interact Action

```python
user_model_template = "**User Model:**\n- **Personal Information and Demographics:**\n- **Preferences and Interests:**"
anchors = [
    "The user shares personal information and demographics",
    "The user shares preferences and interests",
    "The user shares behavioral patterns and habits",
    "The user shares personal opinions, values, or beliefs",
    "The user shares goals and needs",
    "Mentions of relationships with family, friends, or colleagues"
]
history_size = 3
model_name = "gpt-4o"
model_temperature = 0.3
model_max_tokens = 2048
```

### Best Practices
- Ensure the `user_model_template` is comprehensive and extensible.
- Regularly update `anchors` to reflect evolving user profiling needs.

---

## 🔰 Contributing

- **🐛 [Report Issues](https://github.com/TrueSelph/user_model_interact_action/issues)**: Submit bugs found or log feature requests for the `user_model_interact_action` project.
- **💡 [Submit Pull Requests](https://github.com/TrueSelph/user_model_interact_action/blob/main/CONTRIBUTING.md)**: Review open PRs, and submit your own PRs.

<details closed>
<summary>Contributing Guidelines</summary>

1. **Fork the Repository**: Start by forking the project repository to your GitHub account.
2. **Clone Locally**: Clone the forked repository to your local machine using a git client.
   ```sh
   git clone https://github.com/TrueSelph/user_model_interact_action
   ```
3. **Create a New Branch**: Always work on a new branch, giving it a descriptive name.
   ```sh
   git checkout -b new-feature-x
   ```
4. **Make Your Changes**: Develop and test your changes locally.
5. **Commit Your Changes**: Commit with a clear message describing your updates.
   ```sh
   git commit -m 'Implemented new feature x.'
   ```
6. **Push to GitHub**: Push the changes to your forked repository.
   ```sh
   git push origin new-feature-x
   ```
7. **Submit a Pull Request**: Create a PR against the original project repository. Clearly describe the changes and their motivations.
8. **Review**: Once your PR is reviewed and approved, it will be merged into the main branch. Congratulations on your contribution!
</details>

<details open>
<summary>Contributor Graph</summary>
<br>
<p align="left">
    <a href="https://github.com/TrueSelph/user_model_interact_action/graphs/contributors">
        <img src="https://contrib.rocks/image?repo=TrueSelph/user_model_interact_action" />
   </a>
</p>
</details>

## 🎗 License

This project is protected under the Apache License 2.0. See [LICENSE](./LICENSE) for more information.