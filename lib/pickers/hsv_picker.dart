import 'package:flutter/cupertino.dart' show CupertinoTextField;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// Just an example of how to use/interpret/format text input's result.
void copyToClipboard(String input) {
  String textToCopy = input.replaceFirst('#', '').toUpperCase();
  if (textToCopy.startsWith('FF') && textToCopy.length == 8) {
    textToCopy = textToCopy.replaceFirst('FF', '');
  }
  Clipboard.setData(ClipboardData(text: '#$textToCopy'));
}

class HSVColorPickerExample extends StatefulWidget {
  const HSVColorPickerExample({
    Key? key,
    required this.pickerColor,
    required this.onColorChanged,
    this.colorHistory,
    this.onHistoryChanged,
  }) : super(key: key);

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final List<Color>? colorHistory;
  final ValueChanged<List<Color>>? onHistoryChanged;

  @override
  State<HSVColorPickerExample> createState() => _HSVColorPickerExampleState();
}

class _HSVColorPickerExampleState extends State<HSVColorPickerExample> {
  // Picker 1
  PaletteType _paletteType = PaletteType.hsl;
  bool _enableAlpha = true;
  bool _displayThumbColor = true;
  final List<ColorLabelType> _labelTypes = [
    ColorLabelType.hsl,
    ColorLabelType.hsv
  ];
  bool _displayHexInputBar = false;

  // Picker 2
  bool _displayThumbColor2 = true;
  bool _enableAlpha2 = false;

  // Picker 3
  ColorModel _colorModel = ColorModel.rgb;
  bool _enableAlpha3 = false;
  bool _displayThumbColor3 = true;
  bool _showParams = true;
  bool _showIndicator = true;

  // Picker 4
  final textController = TextEditingController(
      text:
          '#2F19DB'); // The initial value can be provided directly to the controller.
  bool _enableAlpha4 = true;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      titlePadding: const EdgeInsets.all(0),
                      contentPadding: const EdgeInsets.all(0),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: widget.pickerColor,
                          onColorChanged: widget.onColorChanged,
                          colorPickerWidth: 300,
                          pickerAreaHeightPercent: 0.7,
                          enableAlpha: _enableAlpha,
                          labelTypes: _labelTypes,
                          displayThumbColor: _displayThumbColor,
                          paletteType: _paletteType,
                          pickerAreaBorderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(2),
                            topRight: Radius.circular(2),
                          ),
                          hexInputBar: _displayHexInputBar,
                          colorHistory: widget.colorHistory,
                          onHistoryChanged: widget.onHistoryChanged,
                        ),
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
              child: Text(
                'Color Picker with Slider',
                style: TextStyle(
                    color: useWhiteForeground(widget.pickerColor)
                        ? Colors.white
                        : Colors.black),
              ),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SingleChildScrollView(
                        child: Text(
                          '''
ColorPicker(
  pickerColor: color,
  onColorChanged: changeColor,
  colorPickerWidth: 300,
  pickerAreaHeightPercent: 0.7,
  enableAlpha: $_enableAlpha,
  labelTypes: $_labelTypes,
  displayThumbColor: $_displayThumbColor,
  paletteType: $_paletteType,
  pickerAreaBorderRadius: const BorderRadius.only(
    topLeft: Radius.circular(2),
    topRight: Radius.circular(2),
  ),
  hexInputBar: $_displayHexInputBar,
  colorHistory: colorHistory,
  onHistoryChanged: changeColorHistory,
)
                          ''',
                        ),
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
              child: Icon(Icons.code,
                  color: useWhiteForeground(widget.pickerColor)
                      ? Colors.white
                      : Colors.black),
            ),
          ],
        ),
        SwitchListTile(
          title: const Text('Enable Alpha Slider'),
          subtitle: const Text('Display alpha slider & label text'),
          value: _enableAlpha,
          onChanged: (bool value) =>
              setState(() => _enableAlpha = !_enableAlpha),
        ),
        SwitchListTile(
          title: const Text('Display Thumb Color in slider'),
          value: _displayThumbColor,
          onChanged: (bool value) =>
              setState(() => _displayThumbColor = !_displayThumbColor),
        ),
        ListTile(
          title: const Text('Palette Type'),
          trailing: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: _paletteType,
              onChanged: (PaletteType? type) {
                if (type != null) setState(() => _paletteType = type);
              },
              items: [
                for (PaletteType type in PaletteType.values)
                  DropdownMenuItem(
                    value: type,
                    child: SizedBox(
                      width: 150,
                      child: Text(type.toString().split('.').last,
                          textAlign: TextAlign.end),
                    ),
                  )
              ],
            ),
          ),
        ),
        ExpansionTile(
          title:
              Text(_labelTypes.isNotEmpty ? 'Display Label' : 'Disable Label'),
          subtitle: Text(
            _labelTypes.isNotEmpty
                ? _labelTypes
                    .map((e) => e.toString().split('.').last.toUpperCase())
                    .toString()
                : '',
          ),
          children: [
            SwitchListTile(
              title: const Text('    Display HEX Label Text'),
              value: _labelTypes.contains(ColorLabelType.hex),
              onChanged: (bool value) => setState(
                () => value
                    ? _labelTypes.add(ColorLabelType.hex)
                    : _labelTypes.remove(ColorLabelType.hex),
              ),
              dense: true,
            ),
            SwitchListTile(
              title: const Text('    Display RGB Label Text'),
              value: _labelTypes.contains(ColorLabelType.rgb),
              onChanged: (bool value) => setState(
                () => value
                    ? _labelTypes.add(ColorLabelType.rgb)
                    : _labelTypes.remove(ColorLabelType.rgb),
              ),
              dense: true,
            ),
            SwitchListTile(
              title: const Text('    Display HSV Label Text'),
              value: _labelTypes.contains(ColorLabelType.hsv),
              onChanged: (bool value) => setState(
                () => value
                    ? _labelTypes.add(ColorLabelType.hsv)
                    : _labelTypes.remove(ColorLabelType.hsv),
              ),
              dense: true,
            ),
            SwitchListTile(
              title: const Text('    Display HSL Label Text'),
              value: _labelTypes.contains(ColorLabelType.hsl),
              onChanged: (bool value) => setState(
                () => value
                    ? _labelTypes.add(ColorLabelType.hsl)
                    : _labelTypes.remove(ColorLabelType.hsl),
              ),
              dense: true,
            ),
          ],
        ),
        SwitchListTile(
          title: const Text('Display Hex Input Bar'),
          value: _displayHexInputBar,
          onChanged: (bool value) =>
              setState(() => _displayHexInputBar = !_displayHexInputBar),
        ),
        const Divider(),
        const SizedBox(height: 5),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      titlePadding: const EdgeInsets.all(0),
                      contentPadding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? const BorderRadius.vertical(
                                top: Radius.circular(500),
                                bottom: Radius.circular(100),
                              )
                            : const BorderRadius.horizontal(
                                right: Radius.circular(500)),
                      ),
                      content: SingleChildScrollView(
                        child: HueRingPicker(
                          pickerColor: widget.pickerColor,
                          onColorChanged: widget.onColorChanged,
                          enableAlpha: _enableAlpha2,
                          displayThumbColor: _displayThumbColor2,
                        ),
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
              child: Text(
                'Hue Ring Picker with Hex Input',
                style: TextStyle(
                    color: useWhiteForeground(widget.pickerColor)
                        ? Colors.white
                        : Colors.black),
              ),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SingleChildScrollView(
                        child: Text(
                          '''
HueRingPicker(
  pickerColor: color,
  onColorChanged: changeColor,
  enableAlpha: $_enableAlpha2,
  displayThumbColor: $_displayThumbColor2,
)
                          ''',
                        ),
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
              child: Icon(Icons.code,
                  color: useWhiteForeground(widget.pickerColor)
                      ? Colors.white
                      : Colors.black),
            ),
          ],
        ),
        SwitchListTile(
          title: const Text('Enable Alpha Slider'),
          value: _enableAlpha2,
          onChanged: (bool value) =>
              setState(() => _enableAlpha2 = !_enableAlpha2),
        ),
        SwitchListTile(
          title: const Text('Display Thumb Color in Slider'),
          value: _displayThumbColor2,
          onChanged: (bool value) =>
              setState(() => _displayThumbColor2 = !_displayThumbColor2),
        ),
        const Divider(),
        const SizedBox(height: 5),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      titlePadding: const EdgeInsets.all(0),
                      contentPadding: const EdgeInsets.all(0),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      content: SingleChildScrollView(
                        child: SlidePicker(
                          pickerColor: widget.pickerColor,
                          onColorChanged: widget.onColorChanged,
                          colorModel: _colorModel,
                          enableAlpha: _enableAlpha3,
                          displayThumbColor: _displayThumbColor3,
                          showParams: _showParams,
                          showIndicator: _showIndicator,
                          indicatorBorderRadius: const BorderRadius.vertical(
                              top: Radius.circular(25)),
                        ),
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
              child: Text(
                'Slider-only Color Picker',
                style: TextStyle(
                    color: useWhiteForeground(widget.pickerColor)
                        ? Colors.white
                        : Colors.black),
              ),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SingleChildScrollView(
                        child: Text(
                          '''
SlidePicker(
  pickerColor: color,
  onColorChanged: changeColor,
  colorModel: $_colorModel,
  enableAlpha: $_enableAlpha3,
  displayThumbColor: $_displayThumbColor3,
  showParams: $_showParams,
  showIndicator: $_showIndicator,
  indicatorBorderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
)
                          ''',
                        ),
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
              child: Icon(Icons.code,
                  color: useWhiteForeground(widget.pickerColor)
                      ? Colors.white
                      : Colors.black),
            ),
          ],
        ),
        ListTile(
          title: const Text('Color Model'),
          trailing: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: _colorModel,
              onChanged: (ColorModel? type) {
                if (type != null) setState(() => _colorModel = type);
              },
              items: [
                for (ColorModel type in ColorModel.values)
                  DropdownMenuItem(
                    value: type,
                    child: SizedBox(
                      width: 50,
                      child: Text(type.toString().split('.').last,
                          textAlign: TextAlign.end),
                    ),
                  )
              ],
            ),
          ),
        ),
        SwitchListTile(
          title: const Text('Enable Alpha Slider'),
          value: _enableAlpha3,
          onChanged: (bool value) =>
              setState(() => _enableAlpha3 = !_enableAlpha3),
        ),
        SwitchListTile(
          title: const Text('Display Thumb Color in Slider'),
          value: _displayThumbColor3,
          onChanged: (bool value) =>
              setState(() => _displayThumbColor3 = !_displayThumbColor3),
        ),
        SwitchListTile(
          title: const Text('Show Parameters next to Slider'),
          value: _showParams,
          onChanged: (bool value) => setState(() => _showParams = !_showParams),
        ),
        SwitchListTile(
          title: const Text('Show Color Indicator'),
          value: _showIndicator,
          onChanged: (bool value) =>
              setState(() => _showIndicator = !_showIndicator),
        ),
        const Divider(),
        const SizedBox(height: 15),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      scrollable: true,
                      titlePadding: const EdgeInsets.all(0),
                      contentPadding: const EdgeInsets.all(0),
                      content: Column(
                        children: [
                          ColorPicker(
                            pickerColor: widget.pickerColor,
                            onColorChanged: widget.onColorChanged,
                            colorPickerWidth: 300,
                            pickerAreaHeightPercent: 0.7,
                            enableAlpha:
                                _enableAlpha4, // hexInputController will respect it too.
                            displayThumbColor: true,
                            paletteType: PaletteType.hsvWithHue,
                            labelTypes: const [],
                            pickerAreaBorderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(2),
                              topRight: Radius.circular(2),
                            ),
                            hexInputController: textController, // <- here
                            portraitOnly: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            /* It can be any text field, for example:

                            * TextField
                            * TextFormField
                            * CupertinoTextField
                            * EditableText
                            * any text field from 3-rd party package
                            * your own text field

                            so basically anything that supports/uses
                            a TextEditingController for an editable text.
                            */
                            child: CupertinoTextField(
                              controller: textController,
                              // Everything below is purely optional.
                              prefix: const Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Icon(Icons.tag)),
                              suffix: IconButton(
                                icon: const Icon(Icons.content_paste_rounded),
                                onPressed: () =>
                                    copyToClipboard(textController.text),
                              ),
                              autofocus: true,
                              maxLength: 9,
                              inputFormatters: [
                                // Any custom input formatter can be passed
                                // here or use any Form validator you want.
                                UpperCaseTextFormatter(),
                                FilteringTextInputFormatter.allow(
                                    RegExp(kValidHexPattern)),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
              child: Text(
                '  HSV Color Picker\n(Your own text field)',
                style: TextStyle(
                    color: useWhiteForeground(widget.pickerColor)
                        ? Colors.white
                        : Colors.black),
              ),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SingleChildScrollView(
                        child: Text(
                          '''
Column(
  children: [
    ColorPicker(
      pickerColor: color,
      onColorChanged: changeColor,
      colorPickerWidth: 300,
      pickerAreaHeightPercent: 0.7,
      enableAlpha: $_enableAlpha4,
      displayThumbColor: true,
      paletteType: PaletteType.hsvWithHue,
      labelTypes: const [],
      pickerAreaBorderRadius: const BorderRadius.only(
        topLeft: Radius.circular(2),
        topRight: Radius.circular(2),
      ),
      hexInputController: textController,
      portraitOnly: true,
    ),
    Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: CupertinoTextField(
        controller: textController,
        prefix: const Padding(padding: EdgeInsets.only(left: 8), child: Icon(Icons.tag)),
        suffix: IconButton(
          icon: const Icon(Icons.content_paste_rounded),
          onPressed: () => copyToClipboard(textController.text),
        ),
        autofocus: true,
        maxLength: 9,
        inputFormatters: [
          UpperCaseTextFormatter(),
          FilteringTextInputFormatter.allow(RegExp(kValidHexPattern)),
        ],
      ),
    )
  ],
)
                          ''',
                        ),
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
              child: Icon(Icons.code,
                  color: useWhiteForeground(widget.pickerColor)
                      ? Colors.white
                      : Colors.black),
            ),
          ],
        ),
        SwitchListTile(
          title: const Text('Enable Alpha Slider'),
          value: _enableAlpha4,
          onChanged: (bool value) =>
              setState(() => _enableAlpha4 = !_enableAlpha4),
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}

class SlidePicker extends StatefulWidget {
  const SlidePicker({
    Key? key,
    required this.pickerColor,
    required this.onColorChanged,
    this.colorModel = ColorModel.rgb,
    this.enableAlpha = true,
    this.sliderSize = const Size(260, 40),
    this.showSliderText = true,
    @Deprecated(
        'Use Theme.of(context).textTheme.bodyText1 & 2 to alter text style.')
    this.sliderTextStyle,
    this.showParams = true,
    @Deprecated('Use empty list in [labelTypes] to disable label.')
    this.showLabel = true,
    this.labelTypes = const [],
    @Deprecated(
        'Use Theme.of(context).textTheme.bodyText1 & 2 to alter text style.')
    this.labelTextStyle,
    this.showIndicator = true,
    this.indicatorSize = const Size(280, 50),
    this.indicatorAlignmentBegin = const Alignment(-1.0, -3.0),
    this.indicatorAlignmentEnd = const Alignment(1.0, 3.0),
    this.displayThumbColor = true,
    this.indicatorBorderRadius = const BorderRadius.all(Radius.zero),
  }) : super(key: key);

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final ColorModel colorModel;
  final bool enableAlpha;
  final Size sliderSize;
  final bool showSliderText;
  final TextStyle? sliderTextStyle;
  final bool showLabel;
  final bool showParams;
  final List<ColorLabelType> labelTypes;
  final TextStyle? labelTextStyle;
  final bool showIndicator;
  final Size indicatorSize;
  final AlignmentGeometry indicatorAlignmentBegin;
  final AlignmentGeometry indicatorAlignmentEnd;
  final bool displayThumbColor;
  final BorderRadius indicatorBorderRadius;

  @override
  State<StatefulWidget> createState() => _SlidePickerState();
}

class _SlidePickerState extends State<SlidePicker> {
  HSVColor currentHsvColor = const HSVColor.fromAHSV(0.0, 0.0, 0.0, 0.0);

  @override
  void initState() {
    super.initState();
    currentHsvColor = HSVColor.fromColor(widget.pickerColor);
  }

  @override
  void didUpdateWidget(SlidePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentHsvColor = HSVColor.fromColor(widget.pickerColor);
  }

  Widget colorPickerSlider(TrackType trackType) {
    return ColorPickerSlider(
      trackType,
      currentHsvColor,
      (HSVColor color) {
        setState(() => currentHsvColor = color);
        widget.onColorChanged(currentHsvColor.toColor());
      },
      displayThumbColor: widget.displayThumbColor,
      fullThumbColor: true,
    );
  }

  Widget indicator() {
    return ClipRRect(
      borderRadius: widget.indicatorBorderRadius,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: GestureDetector(
        onTap: () {
          setState(
              () => currentHsvColor = HSVColor.fromColor(widget.pickerColor));
          widget.onColorChanged(currentHsvColor.toColor());
        },
        child: Container(
          width: widget.indicatorSize.width,
          height: widget.indicatorSize.height,
          margin: const EdgeInsets.only(bottom: 15.0),
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                widget.pickerColor,
                widget.pickerColor,
                currentHsvColor.toColor(),
                currentHsvColor.toColor(),
              ],
              begin: widget.indicatorAlignmentBegin,
              end: widget.indicatorAlignmentEnd,
              stops: const [0.0, 0.5, 0.5, 1.0],
            ),
          ),
          child: const CustomPaint(painter: CheckerPainter()),
        ),
      ),
    );
  }

  String getColorParams(int pos) {
    assert(pos >= 0 && pos < 4);
    if (widget.colorModel == ColorModel.rgb) {
      final Color color = currentHsvColor.toColor();
      return [
        color.red.toString(),
        color.green.toString(),
        color.blue.toString(),
        '${(color.opacity * 100).round()}',
      ][pos];
    } else if (widget.colorModel == ColorModel.hsv) {
      return [
        currentHsvColor.hue.round().toString(),
        (currentHsvColor.saturation * 100).round().toString(),
        (currentHsvColor.value * 100).round().toString(),
        (currentHsvColor.alpha * 100).round().toString(),
      ][pos];
    } else if (widget.colorModel == ColorModel.hsl) {
      HSLColor hslColor = hsvToHsl(currentHsvColor);
      return [
        hslColor.hue.round().toString(),
        (hslColor.saturation * 100).round().toString(),
        (hslColor.lightness * 100).round().toString(),
        (currentHsvColor.alpha * 100).round().toString(),
      ][pos];
    } else {
      return '??';
    }
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = 14;
    if (widget.labelTextStyle != null &&
        widget.labelTextStyle?.fontSize != null) {
      fontSize = widget.labelTextStyle?.fontSize ?? 14;
    }
    final List<TrackType> trackTypes = [
      if (widget.colorModel == ColorModel.hsv) ...[
        TrackType.hue,
        TrackType.saturation,
        TrackType.value
      ],
      if (widget.colorModel == ColorModel.hsl) ...[
        TrackType.hue,
        TrackType.saturationForHSL,
        TrackType.lightness
      ],
      if (widget.colorModel == ColorModel.rgb) ...[
        TrackType.red,
        TrackType.green,
        TrackType.blue
      ],
      if (widget.enableAlpha) ...[TrackType.alpha],
    ];
    List<SizedBox> sliders = [
      for (TrackType trackType in trackTypes)
        SizedBox(
          width: widget.sliderSize.width,
          height: widget.sliderSize.height,
          child: Row(
            children: <Widget>[
              if (widget.showSliderText)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    trackType.toString().split('.').last[0].toUpperCase(),
                    style: widget.sliderTextStyle ??
                        Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              Expanded(child: colorPickerSlider(trackType)),
              if (widget.showParams)
                ConstrainedBox(
                  constraints: BoxConstraints(minWidth: fontSize * 2 + 5),
                  child: Text(
                    getColorParams(trackTypes.indexOf(trackType)),
                    style: widget.sliderTextStyle ??
                        Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.right,
                  ),
                ),
            ],
          ),
        ),
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        if (widget.showIndicator) indicator(),
        if (!widget.showIndicator) const SizedBox(height: 20),
        ...sliders,
        const SizedBox(height: 20.0),
        if (widget.showLabel && widget.labelTypes.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: ColorPickerLabel(
              currentHsvColor,
              enableAlpha: widget.enableAlpha,
              textStyle: widget.labelTextStyle,
              colorLabelTypes: widget.labelTypes,
            ),
          ),
      ],
    );
  }
}
