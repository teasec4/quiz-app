import 'package:flutter/material.dart';
import 'package:bookexample/core/theme/color_scheme_extensions.dart';
import 'package:bookexample/core/theme/spacing.dart';

/// Demo widget that showcases all semantic colors from ColorSchemeExtensions
class SemanticColorDemo extends StatelessWidget {
  const SemanticColorDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Semantic Color Demo'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === PRIMARY COLORS ===
            _buildSection(context, 'Primary Colors', [
              _buildColorRow(
                'Primary',
                colorScheme.primary,
                colorScheme.onPrimary,
              ),
              _buildColorRow(
                'Primary Container',
                colorScheme.primaryContainer,
                colorScheme.onPrimaryContainer,
              ),
              _buildColorRow(
                'Selected',
                colorScheme.selected,
                colorScheme.onSelected,
              ),
            ]),

            AppSpacing.verticalLg,

            // === SECONDARY COLORS ===
            _buildSection(context, 'Secondary Colors', [
              _buildColorRow(
                'Secondary',
                colorScheme.secondary,
                colorScheme.onSecondary,
              ),
              _buildColorRow(
                'Secondary Container',
                colorScheme.secondaryContainer,
                colorScheme.onSecondaryContainer,
              ),
              _buildColorRow(
                'Activated',
                colorScheme.activated,
                colorScheme.onActivated,
              ),
            ]),

            AppSpacing.verticalLg,

            // === SUCCESS/TERTIARY COLORS ===
            _buildSection(context, 'Success Colors', [
              _buildColorRow(
                'Success',
                colorScheme.success,
                colorScheme.onSuccess,
              ),
              _buildColorRow(
                'Success Container',
                colorScheme.successContainer,
                colorScheme.onSuccessContainer,
              ),
            ]),

            AppSpacing.verticalLg,

            // === ERROR COLORS ===
            _buildSection(context, 'Error Colors', [
              _buildColorRow('Error', colorScheme.error, colorScheme.onError),
              _buildColorRow(
                'Error Container',
                colorScheme.errorContainer,
                colorScheme.onErrorContainer,
              ),
            ]),

            AppSpacing.verticalLg,

            // === WARNING COLORS ===
            _buildSection(context, 'Warning Colors', [
              _buildColorRow(
                'Warning',
                colorScheme.warning,
                colorScheme.onWarning,
              ),
              _buildColorRow(
                'Warning Container',
                colorScheme.warningContainer,
                colorScheme.onWarningContainer,
              ),
            ]),

            AppSpacing.verticalLg,

            // === INFO COLORS ===
            _buildSection(context, 'Info Colors', [
              _buildColorRow('Info', colorScheme.info, colorScheme.onInfo),
              _buildColorRow(
                'Info Container',
                colorScheme.infoContainer,
                colorScheme.onInfoContainer,
              ),
            ]),

            AppSpacing.verticalLg,

            // === SURFACE COLORS ===
            _buildSection(context, 'Surface Colors', [
              _buildColorRow(
                'Surface',
                colorScheme.surface,
                colorScheme.onSurface,
              ),
              _buildColorRow(
                'Surface Container Highest',
                colorScheme.surfaceContainerHighest,
                colorScheme.onSurface,
              ),
              _buildColorRow(
                'Surface Container Highest',
                colorScheme.surfaceContainerHighest,
                colorScheme.onSurface,
              ),
            ]),

            AppSpacing.verticalLg,

            // === TEXT COLORS ===
            _buildSection(context, 'Text Colors', [
              _buildSimpleColorRow('Text Primary', colorScheme.textPrimary),
              _buildSimpleColorRow('Text Secondary', colorScheme.textSecondary),
              _buildSimpleColorRow('Text Disabled', colorScheme.textDisabled),
              _buildSimpleColorRow('Text Hint', colorScheme.textHint),
            ]),

            AppSpacing.verticalLg,

            // === BORDER & DIVIDER COLORS ===
            _buildSection(context, 'Border & Divider Colors', [
              _buildSimpleColorRow('Card Border', colorScheme.cardBorder),
              _buildSimpleColorRow('Input Border', colorScheme.inputBorder),
              _buildSimpleColorRow(
                'Input Focused Border',
                colorScheme.inputFocusedBorder,
              ),
              _buildSimpleColorRow(
                'Input Error Border',
                colorScheme.inputErrorBorder,
              ),
              _buildSimpleColorRow('Divider', colorScheme.divider),
              _buildSimpleColorRow('Divider Subtle', colorScheme.dividerSubtle),
            ]),

            AppSpacing.verticalLg,

            // === STATE COLORS ===
            _buildSection(context, 'State Colors', [
              _buildSimpleColorRow('Disabled', colorScheme.disabled),
              _buildSimpleColorRow(
                'Disabled Container',
                colorScheme.disabledContainer,
              ),
              _buildSimpleColorRow('Focus', colorScheme.focus),
              _buildSimpleColorRow('Hover', colorScheme.hover),
              _buildSimpleColorRow('Pressed', colorScheme.pressed),
              _buildSimpleColorRow('Dragged', colorScheme.dragged),
            ]),

            AppSpacing.verticalLg,

            // === BADGE COLORS ===
            _buildSection(context, 'Badge Colors', [
              _buildColorRow(
                'Badge Success',
                colorScheme.badgeSuccess,
                colorScheme.onBadgeSuccess,
              ),
              _buildColorRow(
                'Badge Warning',
                colorScheme.badgeWarning,
                colorScheme.onBadgeWarning,
              ),
              _buildColorRow(
                'Badge Error',
                colorScheme.badgeError,
                colorScheme.onBadgeError,
              ),
              _buildColorRow(
                'Badge Info',
                colorScheme.badgeInfo,
                colorScheme.onBadgeInfo,
              ),
              _buildColorRow(
                'Badge Neutral',
                colorScheme.badgeNeutral,
                colorScheme.onBadgeNeutral,
              ),
            ]),

            AppSpacing.verticalLg,

            // === UTILITY DEMOS ===
            _buildSection(context, 'Utility Demos', [
              _buildUtilityDemo(
                context,
                'Darken Primary',
                colorScheme.primary.darken(0.2),
              ),
              _buildUtilityDemo(
                context,
                'Lighten Primary',
                colorScheme.primary.lighten(0.2),
              ),
              _buildUtilityDemo(
                context,
                'Primary with 50% opacity',
                colorScheme.primary.withAdjustedOpacity(0.5),
              ),
            ]),

            AppSpacing.verticalLg,

            // === BUTTON DEMOS ===
            _buildSection(context, 'Button Demos with Semantic Colors', [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Primary'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.secondary,
                      foregroundColor: colorScheme.onSecondary,
                    ),
                    onPressed: () {},
                    child: const Text('Secondary'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.success,
                      foregroundColor: colorScheme.onSuccess,
                    ),
                    onPressed: () {},
                    child: const Text('Success'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.warning,
                      foregroundColor: colorScheme.onWarning,
                    ),
                    onPressed: () {},
                    child: const Text('Warning'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.error,
                      foregroundColor: colorScheme.onError,
                    ),
                    onPressed: () {},
                    child: const Text('Error'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.info,
                      foregroundColor: colorScheme.onInfo,
                    ),
                    onPressed: () {},
                    child: const Text('Info'),
                  ),
                ],
              ),
            ]),

            AppSpacing.verticalLg,

            // === CHIP DEMOS ===
            _buildSection(context, 'Chip Demos with Semantic Colors', [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(
                    backgroundColor: colorScheme.badgeSuccess,
                    label: Text(
                      'Success',
                      style: TextStyle(color: colorScheme.onBadgeSuccess),
                    ),
                  ),
                  Chip(
                    backgroundColor: colorScheme.badgeWarning,
                    label: Text(
                      'Warning',
                      style: TextStyle(color: colorScheme.onBadgeWarning),
                    ),
                  ),
                  Chip(
                    backgroundColor: colorScheme.badgeError,
                    label: Text(
                      'Error',
                      style: TextStyle(color: colorScheme.onBadgeError),
                    ),
                  ),
                  Chip(
                    backgroundColor: colorScheme.badgeInfo,
                    label: Text(
                      'Info',
                      style: TextStyle(color: colorScheme.onBadgeInfo),
                    ),
                  ),
                  Chip(
                    backgroundColor: colorScheme.badgeNeutral,
                    label: Text(
                      'Neutral',
                      style: TextStyle(color: colorScheme.onBadgeNeutral),
                    ),
                  ),
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        AppSpacing.verticalMd,
        ...children,
      ],
    );
  }

  Widget _buildColorRow(String label, Color color, Color textColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: textColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '#${color.value.toRadixString(16).toUpperCase()}',
              style: TextStyle(
                color: textColor,
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleColorRow(String label, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: color.contrastingText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.contrastingText.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '#${color.value.toRadixString(16).toUpperCase()}',
              style: TextStyle(
                color: color.contrastingText,
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUtilityDemo(BuildContext context, String label, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: color.contrastingText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            'Utility Demo',
            style: TextStyle(
              color: color.contrastingText.withAdjustedOpacity(0.8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
