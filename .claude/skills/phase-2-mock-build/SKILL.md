# Phase 2: Mock Build

**This file is READ-ONLY during app builds. Do NOT modify it. If you encounter a gap or error, note it in the app's `_local/skill-feedback.md` and continue.**

Load this skill when building a mock app from a functional spec. The skeleton provides all structural code. Your job is to copy it, replace placeholders, and wire controls to a mock data service.

---

## Inputs Required

Before starting, confirm you have:

1. **Functional spec** — the Phase 1 output document (markdown file)
2. **Skeleton** — the `skeleton/` directory from tercen-flutter-skills
3. **Target directory** — where the new app will be created
4. **Mock data** — CSV files, JSON, or generated data described in the spec's Section 7.3

---

## Step 1: Copy and Rename

Copy the entire `skeleton/` directory to the target project location, then update these files:

### pubspec.yaml
- `name:` — new app name in snake_case (e.g., `volcano_flutter_operator`)
- `description:` — one-line description from spec Section 1.1

### operator.json
- `name` — display name from spec (e.g., "Volcano Plot")
- `description` — one-line description
- `urls` — GitHub repository URL

### version_info.dart (`lib/core/version/version_info.dart`)
- `gitRepo` — GitHub repository URL
- `version` — set to `'0.1.0'`
- `commitHash` — leave empty (populated at build time)

### main.dart (`lib/main.dart`)
- Rename `SkeletonApp` class -> `YourAppNameApp`
- Update `title:` in `MaterialApp`

### home_screen.dart (`lib/presentation/screens/home_screen.dart`)
- Update `appTitle:` — display name shown in panel header
- Update `appIcon:` — app icon shown in panel header

---

## Step 2: Define Domain Models

Read spec **Section 2.2 (Data Source)** and **Section 7.3 (Mock Data)**.

### Create domain models in `lib/domain/models/`

Create one or more classes representing the app's data. Use the spec's data columns and types.

Example (from a volcano app spec):
```dart
// lib/domain/models/gene_data.dart
class GeneData {
  final String gene;
  final double log2FoldChange;
  final double negLog10PValue;
  final String regulation;

  const GeneData({
    required this.gene,
    required this.log2FoldChange,
    required this.negLog10PValue,
    required this.regulation,
  });
}
```

### Update DataService interface (`lib/domain/services/data_service.dart`)

Replace the generic `Map<String, dynamic>` return type with your domain model. If the spec requires distinct operations (e.g., load metadata separately from fetching binary assets), add multiple methods — don't force everything through one `loadData()` call.

```dart
abstract class DataService {
  Future<List<GeneData>> loadData();
}
```

---

## Step 3: Build Mock Service

Read spec **Section 7.3 (Mock Data)**.

### Place mock data files

Put data files in `assets/data/` (CSV, JSON, images, or any format the spec requires). Register them in `pubspec.yaml`:
```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/data/
```

### Create mock service (`lib/implementations/services/mock_data_service.dart`)

Replace the placeholder with a service that loads your mock data. Use `rootBundle.loadString()` for text (CSV, JSON) or `rootBundle.load()` for binary (images, files). Match the approach to your data type:

```dart
class MockDataService implements DataService {
  @override
  Future<List<GeneData>> loadData() async {
    final csvString = await rootBundle.loadString('assets/data/sample.csv');
    final rows = const CsvToListConverter(eol: '\n').convert(csvString);
    // Skip header row, parse each data row into domain model
    return rows.skip(1).map((row) => GeneData(
      gene: row[0].toString(),
      log2FoldChange: (row[1] as num).toDouble(),
      negLog10PValue: (row[2] as num).toDouble(),
      regulation: row[3].toString(),
    )).toList();
  }
}
```

The mock service must return real, usable data — not placeholder values.

---

## Step 4: Build Provider (State Management)

Read spec **Section 4.2 (Left Panel Sections)** — every control listed becomes a state field.

### Replace AppStateProvider (`lib/presentation/providers/app_state_provider.dart`)

For each control in the spec, add one field following this exact pattern:

```dart
// [Type] — [Control name from spec]
Type _fieldName = defaultValue;
Type get fieldName => _fieldName;
void setFieldName(Type value) {
  _fieldName = value;
  notifyListeners();
}
```

Keep the data loading infrastructure (`loadData`, `isLoading`, `error`, `data`). Update the `data` field type to match your domain model.

### Wiring Golden Rule

Every control follows this one-way data flow:

```
control.onChanged -> provider.setXxx(value) -> notifyListeners() -> Consumer rebuilds main content
```

The skeleton's `controls_section.dart` demonstrates all 10 control types wired to the provider. Copy the wiring pattern exactly — only change the field names and values.

---

## Step 5: Build Left Panel Sections

Read spec **Section 4.2 (Left Panel Sections)**.

### Create one widget per section

For each section defined in the spec, create a file in `lib/presentation/widgets/left_panel/`:

```dart
// lib/presentation/widgets/left_panel/display_section.dart
class DisplaySection extends StatelessWidget {
  // Controls for this section, wired to provider
}
```

**Reference the skeleton's `controls_section.dart` for every control type:**

| Control Type | Skeleton Example | Key Widget |
|---|---|---|
| Text input | `TextField` with `onChanged: provider.setXxx` | `TextField` |
| Dropdown | `DropdownButton` with `onChanged` | `DropdownButton<String>` |
| Checkbox | `SizedBox(16x16)` + `Checkbox` with `visualDensity: compact` | `Checkbox` |
| Radio | `SizedBox(16x16)` + `Radio` with `visualDensity: compact` | `Radio<String>` |
| Switch/toggle | `SizedBox(36x20)` + `FittedBox` + `Switch` | `Switch` |
| Slider | `Slider` with `onChanged` | `Slider` |
| Range slider | `RangeSlider` with `onChanged` | `RangeSlider` |
| Number input | `TextField` with `keyboardType: number`, nullable parse | `TextField` |
| Searchable input | `Autocomplete<String>` | `Autocomplete` |
| Segmented button | `SegmentedButton<String>` | `SegmentedButton` |

For control styling (labels, spacing, theme awareness), copy the pattern from `controls_section.dart`:
```dart
final isDark = context.watch<ThemeProvider>().isDarkMode;
final labelColor = isDark ? AppColorsDark.textSecondary : AppColors.textSecondary;

Text('Label', style: AppTextStyles.label.copyWith(color: labelColor)),
const SizedBox(height: AppSpacing.xs),
// control widget here
const SizedBox(height: AppSpacing.controlSpacing),
```

### Wire sections into home_screen.dart

Replace the placeholder sections list in `home_screen.dart`:

```dart
sections: const [
  PanelSection(
    icon: Icons.filter_list,     // from spec
    label: 'FILTERS',           // UPPERCASE from spec
    content: FiltersSection(),
  ),
  PanelSection(
    icon: Icons.display_settings,
    label: 'DISPLAY',
    content: DisplaySection(),
  ),
  PanelSection(
    icon: Icons.info_outline,
    label: 'INFO',
    content: InfoSection(),      // always last, never remove
  ),
],
```

---

## Step 6: Build Main Content

Read spec **Section 4.3 (Main Panel)**.

### Replace _MainContent in home_screen.dart

The main content widget reads from the provider and renders the visualization described in the spec. If the spec describes multiple view modes (e.g., grid + detail view, chart + table), manage the view state in the provider and switch within this widget.

Structure:
```dart
class _MainContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppStateProvider>();
    final isDark = context.watch<ThemeProvider>().isDarkMode;

    if (provider.isLoading) {
      return /* loading indicator */;
    }
    if (provider.error != null) {
      return /* error display */;
    }

    // Filter/transform data based on provider state
    final filteredData = provider.data.where((item) => /* apply control values */);

    // Render visualization from spec Section 4.3
    return /* chart, grid, image, canvas, table */;
  }
}
```

The main content is **display only**. No controls, inputs, or buttons in this area. Spec-described interactions (hover tooltips, click-to-select, zoom) are read-only feedback, not input controls.

---

## Step 7: Verify

Run `flutter run -d chrome`. Verify against the checklist at the end of this document.

---

## DO NOT MODIFY

Copy these files unchanged.

| File | What it does |
|---|---|
| `lib/presentation/widgets/left_panel/left_panel.dart` | Collapse, expand, resize, LayoutBuilder, icon strip, footer chevron |
| `lib/presentation/widgets/left_panel/left_panel_header.dart` | 4-element header, collapsed header restructuring |
| `lib/presentation/widgets/left_panel/left_panel_section.dart` | Section header styling (background, text color, borders) |
| `lib/presentation/widgets/app_shell.dart` | Frame layout, conditional top bar |
| `lib/presentation/widgets/top_bar.dart` | Standalone mode indicator |
| `lib/core/theme/app_colors.dart` | Light theme color tokens |
| `lib/core/theme/app_colors_dark.dart` | Dark theme color tokens |
| `lib/core/theme/app_spacing.dart` | Spacing and dimension tokens |
| `lib/core/theme/app_text_styles.dart` | Typography tokens |
| `lib/core/theme/app_theme.dart` | Material 3 ThemeData (light + dark) |
| `lib/core/utils/context_detector.dart` | Tercen embedded detection |
| `lib/presentation/providers/theme_provider.dart` | Theme persistence |
| `lib/di/service_locator.dart` | DI registration (add services, don't restructure) |
| `lib/main.dart` | Entry point (rename class + title only, don't restructure) |

If panel collapse, resize, or theme toggle breaks — a DO NOT MODIFY file was changed. Revert.

---

## Files You Create or Replace

| File | Action |
|---|---|
| `lib/domain/models/*.dart` | Create — domain model classes from spec Section 2.2 |
| `lib/domain/services/*.dart` | Replace or create — update return types, add service interfaces as needed |
| `lib/implementations/services/*.dart` | Replace or create — one mock implementation per service interface |
| `lib/presentation/providers/app_state_provider.dart` | Replace — one field per control from spec Section 4.2. Split into multiple providers if the spec has distinct state domains (e.g., separate navigation, settings, data). |
| `lib/presentation/screens/home_screen.dart` | Replace — sections list + main content from spec |
| `lib/presentation/widgets/left_panel/*_section.dart` | Create — one per spec section (except info_section.dart, which stays) |
| `assets/data/*` | Create — mock data files from spec Section 7.3 |
| `pubspec.yaml` | Edit — name, description, assets |
| `operator.json` | Edit — name, description, urls |
| `lib/core/version/version_info.dart` | Edit — gitRepo, version |

Delete the skeleton's demo files after replacing them:
- `controls_section.dart` (replaced by your app's sections)
- `buttons_section.dart` (replaced by your app's sections)
- `settings_section.dart` (unused)
- `filters_section.dart` (unused)

---

## Checklist

Before completing Phase 2:

- [ ] App runs with `flutter run -d chrome` — no errors
- [ ] All sections from spec Section 4.2 present with correct icons and UPPERCASE labels
- [ ] All controls have correct types, defaults, and ranges from spec
- [ ] Every control updates main content via the provider (wiring golden rule)
- [ ] Main content matches spec Section 4.3
- [ ] Mock data loaded from assets (not hardcoded placeholder values)
- [ ] Panel collapse/expand/resize works identically to skeleton
- [ ] Theme toggle works (light + dark)
- [ ] INFO section present with correct GitHub URL
- [ ] No controls in the main content area
- [ ] No modifications to DO NOT MODIFY files
- [ ] `flutter build web --wasm` succeeds
- [ ] User has reviewed and approved the mock app
