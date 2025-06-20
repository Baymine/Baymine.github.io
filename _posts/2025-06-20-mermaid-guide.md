---
layout: post
title: "How to Use Mermaid Diagrams in Your Blog"
date: 2025-06-20 18:30 +0800
tags: [mermaid, diagrams, documentation, tutorial]
---

# How to Use Mermaid Diagrams in Your Blog

Mermaid is now fully configured in your Jekyll blog with a custom hacker theme! This guide shows you how to create various types of diagrams.

## Basic Syntax

To create a Mermaid diagram, use a code block with the `mermaid` language identifier:

````markdown
```mermaid
graph TD
    A[Start] --> B[End]
```
````

## Supported Diagram Types

### 1. Flowcharts

Perfect for showing processes and decision flows:

```mermaid
graph TD
    A[User Request] --> B{Authentication}
    B -->|Valid| C[Process Request]
    B -->|Invalid| D[Return Error]
    C --> E[Return Response]
    D --> F[Log Error]
```

### 2. Sequence Diagrams

Great for API interactions and system communications:

```mermaid
sequenceDiagram
    participant Client
    participant API
    participant Database
    
    Client->>API: POST /login
    API->>Database: Validate credentials
    Database-->>API: User data
    API-->>Client: JWT token
```

### 3. Class Diagrams

Useful for software architecture documentation:

```mermaid
classDiagram
    class User {
        +String username
        +String email
        +login()
        +logout()
    }
    class Admin {
        +manageUsers()
        +viewLogs()
    }
    User <|-- Admin
```

### 4. State Diagrams

Perfect for showing system states and transitions:

```mermaid
stateDiagram-v2
    [*] --> Idle
    Idle --> Loading : fetch_data
    Loading --> Success : data_received
    Loading --> Error : fetch_failed
    Success --> Idle : reset
    Error --> Idle : retry
```

### 5. Gantt Charts

Great for project timelines:

```mermaid
gantt
    title Development Timeline
    dateFormat  YYYY-MM-DD
    section Backend
    API Development    :a1, 2024-01-01, 30d
    Database Setup     :a2, after a1, 15d
    section Frontend
    UI Development     :b1, 2024-01-15, 25d
    Integration        :b2, after a2, 10d
```

### 6. Mind Maps

Excellent for brainstorming and concept mapping:

```mermaid
mindmap
  root((Blog Features))
    Content
      Posts
      Pages
      Comments
    Design
      Theme
      Layout
      Responsive
    Technical
      Jekyll
      Mermaid
      GitHub Pages
```

## Styling Features

Your Mermaid diagrams automatically inherit the hacker theme with:

- **Green terminal colors** (`#00ff41`)
- **Dark background** (`#0a0a0a`)
- **Monospace font** (Fira Code)
- **Glitch hover effects**
- **Terminal-style borders**

## Tips for Better Diagrams

1. **Keep it simple**: Don't overcrowd diagrams
2. **Use meaningful labels**: Make node text descriptive
3. **Consistent styling**: Stick to the theme colors
4. **Logical flow**: Arrange elements in reading order
5. **Test rendering**: Preview your diagrams before publishing

## Advanced Features

### Subgraphs

Group related elements:

```mermaid
graph TB
    subgraph "Frontend"
        A[React App]
        B[Components]
    end
    subgraph "Backend"
        C[API Server]
        D[Database]
    end
    A --> C
    C --> D
```

### Styling Individual Elements

```mermaid
graph LR
    A[Normal] --> B[Highlighted]
    B --> C[Important]
    
    classDef highlight fill:#ff9999
    classDef important fill:#99ff99
    
    class B highlight
    class C important
```

## Troubleshooting

If diagrams don't render:

1. Check syntax with [Mermaid Live Editor](https://mermaid.live/)
2. Ensure proper code block formatting
3. Verify no special characters in diagram code
4. Check browser console for JavaScript errors

## Resources

- [Mermaid Documentation](https://mermaid.js.org/)
- [Syntax Reference](https://mermaid.js.org/syntax/flowchart.html)
- [Live Editor](https://mermaid.live/)

Happy diagramming! 🎨
