---
layout: page
title: Mermaid Test Page
---

# Mermaid Diagram Test

This page tests various Mermaid diagram types to ensure they render correctly with the hacker theme.

## Flowchart

```mermaid
graph TD
    A[Start] --> B{Is it working?}
    B -->|Yes| C[Great!]
    B -->|No| D[Debug]
    D --> B
    C --> E[End]
```

## Sequence Diagram

```mermaid
sequenceDiagram
    participant User
    participant Browser
    participant Server
    
    User->>Browser: Open page
    Browser->>Server: Request content
    Server->>Browser: Return HTML
    Browser->>User: Display page
```

## Class Diagram

```mermaid
classDiagram
    class Animal {
        +String name
        +int age
        +makeSound()
    }
    class Dog {
        +String breed
        +bark()
    }
    class Cat {
        +String color
        +meow()
    }
    
    Animal <|-- Dog
    Animal <|-- Cat
```

## Gantt Chart

```mermaid
gantt
    title Project Timeline
    dateFormat  YYYY-MM-DD
    section Phase 1
    Task 1           :a1, 2024-01-01, 30d
    Task 2           :after a1, 20d
    section Phase 2
    Task 3           :2024-02-01, 25d
    Task 4           :20d
```

## State Diagram

```mermaid
stateDiagram-v2
    [*] --> Idle
    Idle --> Processing : start
    Processing --> Success : complete
    Processing --> Error : fail
    Success --> [*]
    Error --> Idle : retry
```

## Mind Map

```mermaid
mindmap
  root((Mermaid))
    Diagrams
      Flowchart
      Sequence
      Class
    Features
      Syntax
      Themes
      Export
    Benefits
      Visual
      Documentation
      Collaboration
```

If you can see all the diagrams above rendered correctly with the green hacker theme, then Mermaid is working properly!
