# Phase 1: Functional Specification

**This file is READ-ONLY during app builds. Do NOT modify it. If you encounter a gap or error, note it in the app's `_local/skill-feedback.md` and continue.**

Load this skill when starting a new app. Produce a functional spec document. Do NOT write any code.

---

## Tercen Design Constraints

MUST follow these rules when designing the UI.

1. **ALL controls go in the left panel.** Main content area is display only (charts, grids, images, canvas). No sliders, buttons, dropdowns, or inputs in the main panel.
2. **Left panel sections scroll vertically.** No tabs. No internal collapse. Sections are always visible and scroll as a single list.
3. **Every section has an icon and UPPERCASE label.** Example: a filter icon with "FILTERS", a settings icon with "SETTINGS".
4. **INFO section is mandatory.** Every app has an INFO section at the bottom of the left panel with a GitHub repository link.
5. **Available control types**: dropdown, slider, range slider, toggle, number input, button, searchable input, text input. Do not invent new control types.
6. **Identify the app type**:
   - Type 1 (Visualization): Tercen -> App -> Screen (+ download)
   - Type 2 (Interactive): Same as Type 1 + writes data back to Tercen
   - Type 3 (Workflow Manager): Multi-step with Tercen object creation and breakpoints

---

## Output Rules

- The spec describes WHAT the app does, never HOW it is implemented.
- No Dart code, no pseudo-code, no implementation approach.
- No pixel values, spacing tokens, or colour codes (except domain-specific colours like chart series colours).
- No references to Flutter widgets, Provider, GetIt, or any framework.
- Mock data requirements describe WHAT data is needed and WHERE it comes from, not how to load it.

---

## Spec Template

Every functional spec follows this structure. All 8 sections are required.

```markdown
# [App Name] - Functional Specification

**Version:** 1.0.0
**Status:** Draft
**Last Updated:** [Date]
**Reference**: [Source material — Shiny app path, screenshots, description, etc.]

---

## 1. Overview

### 1.1 Purpose
[What problem does this app solve? One paragraph.]

### 1.2 Users
[Who uses this app?]

### 1.3 Scope

**In Scope:**
- [Feature 1]
- [Feature 2]

**Out of Scope:**
- [Exclusion 1]
- [Exclusion 2]

---

## 2. Domain Context

### 2.1 Background
[Domain knowledge needed to understand this app.]

### 2.2 Data Source

**Row Data (main data points):**

| Column | Description | Example |
|--------|-------------|---------|
| `.ci` | [What this column represents] | [Example values] |
| `.x` | [What this column represents] | [Example values] |
| `.y` | [What this column represents] | [Example values] |
| `labels` | [What this column represents] | [Example values] |

**Column Data (grouping/metadata):**

| Column | Description | Example |
|--------|-------------|---------|
| [Name] | [What this column represents] | [Example values] |

**Data Characteristics:**
- [Number of data points, ranges, sparsity, etc.]

### 2.3 Typical Workflow
1. [Step 1]
2. [Step 2]
3. [Step 3]

---

## 3. Functional Requirements

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-01 | [Requirement] | Must / Should / Could |
| FR-02 | [Requirement] | Must / Should / Could |

---

## 4. User Interface Components

### 4.1 App Structure

[ASCII layout diagram showing left panel sections and main content area. Example:]

┌──────────────────────────┬──────────────────────────────────┐
│ Left Panel (280px)       │ Main Content                     │
│                          │                                  │
│ [Panel Header]           │ [Main display description]       │
│                          │                                  │
│ ▼ SECTION NAME           │                                  │
│ ┌──────────────────────┐ │                                  │
│ │ [Control] [Type]     │ │                                  │
│ └──────────────────────┘ │                                  │
│                          │                                  │
│ ▼ INFO                   │                                  │
│ ┌──────────────────────┐ │                                  │
│ │ GitHub link          │ │                                  │
│ └──────────────────────┘ │                                  │
└──────────────────────────┴──────────────────────────────────┘

### 4.2 Left Panel Sections

#### Section 1: [NAME]
Icon: [icon description]

| Control | Type | Default | Range/Notes |
|---------|------|---------|-------------|
| [Control name] | dropdown / slider / toggle / etc. | [Default] | [Range or options] |

#### Section N: INFO
Icon: info icon

| Control | Type | Notes |
|---------|------|-------|
| GitHub link | Icon + Link | Links to repository |

### 4.3 Main Panel

[What the main panel displays. Describe visual elements, interactions (hover, click, select), and any dynamic behaviour.]

---

## 5. Non-Functional Requirements

| ID | Requirement |
|----|-------------|
| NFR-01 | [Requirement] |

---

## 6. Feature Summary

### Must Have
| Feature | Status |
|---------|--------|
| [Feature] | Planned |

### Should Have
| Feature | Status |
|---------|--------|
| [Feature] | Planned |

### Could Have
| Feature | Status |
|---------|--------|
| [Feature] | Planned |

---

## 7. Assumptions

### 7.1 Data Assumptions
- [What we assume about input data]

### 7.2 Environment Assumptions
- [Browser, screen size, network, etc.]

### 7.3 Mock Data
- [What example data is available — CSV files, assets, generated data]
- [Data characteristics: ranges, counts, sparsity]
- [How mock data maps to the data source described in Section 2.2]

---

## 8. Glossary

| Term | Definition |
|------|------------|
| [Term] | [Definition] |
```

---

## Discovery Process

Gather information in this order. Adapt questions to the input source (Shiny code, screenshots, verbal description, existing documentation).

### Round 1: Purpose and Data

- What does this app do? Who uses it?
- What domain is this? What does the data represent?
- What data comes from Tercen? What are the projections (.x, .y, .ci, labels, colours)?
- What are the data characteristics (ranges, counts, sparsity)?
- What is in scope? What is explicitly out of scope?
- What app type is this? (Type 1 / Type 2 / Type 3)

### Round 2: UI Design

- Is there existing code, screenshots, or a description to reference?
- If existing UI: evaluate against Tercen design constraints above. What needs to change?
- What sections does the left panel need? What icon and label for each?
- What controls in each section? Type, default, range?
- What does the main content display? (chart, grid, images, canvas, table)
- What interactions does the main content support? (hover, click, select, drag)
- Does the app export anything? (PDF, PNG, CSV, data write-back)

### Round 3: Constraints and Assumptions

- Performance requirements? Expected data volume?
- What example/mock data is available?
- Any domain-specific terminology to define?

### Round 4: Draft and Review

- Write the complete spec following the template above.
- Present to user for review.
- Iterate until approved.

---

## Question Efficiency

- Do NOT dump all questions at once. Ask 3-4 per round.
- Skip questions already answered by provided material (Shiny code, screenshots, etc.).
- When reviewing existing code/UI, proactively identify Tercen constraint violations and propose fixes.
- Consolidate related questions.

---

## Checklist

Before completing Phase 1:

- [ ] All 8 spec sections populated
- [ ] ASCII layout diagram included
- [ ] Every left panel section has icon and UPPERCASE label
- [ ] ALL controls are in the left panel (none in main content)
- [ ] INFO section included
- [ ] App type identified (1 / 2 / 3)
- [ ] Mock data requirements described
- [ ] No implementation detail (no code, no framework references)
- [ ] User has reviewed and approved
