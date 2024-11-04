import 'package:character_sheet/utils/yaml_utils.dart';
import 'package:yaml/yaml.dart';

import 'formulae.dart';

enum SourceMethod {
  constant,
  variable,
  function,
}

/* * * * * * * * * * *
 * SourceDefinition  *
 * * * * * * * * * * */

abstract class SourceDefinition {
  final SourceMethod method;

  SourceDefinition({
    required this.method,
  });
}

class FunctionSourceDefinition extends SourceDefinition {
  final String formulaKey;
  final Map<String, String> parameterMap;

  FunctionSourceDefinition({
    required super.method,
    required this.formulaKey,
    required this.parameterMap,
  });
}

class ConstantSourceDefinition<T> extends SourceDefinition {
  final Type type = T;
  final T value;

  ConstantSourceDefinition({
    super.method = SourceMethod.constant,
    required this.value,
  });
}

class VariableSourceDefinition<T> extends SourceDefinition {
  final Type type = T;
  final T defaultValue;

  VariableSourceDefinition({
    super.method = SourceMethod.variable,
    required this.defaultValue, 
  });
}

class SourceDefinitionMap {
  Map<String, SourceDefinition> sources;

  SourceDefinitionMap({
    required this.sources,
  });

  factory SourceDefinitionMap.fromYaml(YamlMap yaml) {
    Map<String, SourceDefinition> sources = {};

    void parseSourceDefinitions(YamlMap yaml, String parentKey) {
      yaml.forEach((key, value) {
        String fullKey = parentKey.isEmpty ? key : '$parentKey.$key';
        print('Parsing source definition: $fullKey with value: $value');
        if (value is YamlMap) {
          if (value.containsKey('method')) {
            SourceMethod method = SourceMethod.values.firstWhere((e) => e.toString().split('.').last == value['method']);
            switch (method) {
              case SourceMethod.constant:
                sources[fullKey] = ConstantSourceDefinition(
                  method: method,
                  value: parseYamlValue(value['value']),
                );
                break;
              case SourceMethod.variable:
                sources[fullKey] = VariableSourceDefinition(
                  method: method,
                  defaultValue: parseYamlValue(value['default']),
                );
                break;
              case SourceMethod.function:
                sources[fullKey] = FunctionSourceDefinition(
                  method: method,
                  formulaKey: value['formula'],
                  parameterMap: Map<String, String>.from(value['inputs']),
                );
                break;
            }
          } else {
            parseSourceDefinitions(value, fullKey);
          }
        }
      });
    }

    parseSourceDefinitions(yaml, '');
    return SourceDefinitionMap(sources: sources);
  }

  SourceDefinition? operator [](String key) {
    return sources.containsKey(key) ? sources[key] : null;
  }

  void operator []=(String key, SourceDefinition value) {
    sources[key] = value;
  }

  void forEach(void Function(String key, SourceDefinition value) f) {
    sources.forEach(f);
  }
}

/* * * * * *
 * Source  *
 * * * * * */
abstract class Source {
  final SourceMethod method;

  Source({required this.method});

  factory Source.fromDefinition(SourceDefinition definition) {
    switch (definition.method) {
      case SourceMethod.constant:
        return ConstantSource.fromDefinition(definition as ConstantSourceDefinition);
      case SourceMethod.variable:
        return VariableSource.fromDefinition(definition as VariableSourceDefinition);
      case SourceMethod.function:
        return FunctionSource.fromDefinition(definition as FunctionSourceDefinition);
    }
  }

  dynamic get({SourceMap? sourceMap});
  Source copy();
}

class ConstantSource<T> extends Source {
  final T value;

  ConstantSource({required this.value}) : super(method: SourceMethod.constant);

  ConstantSource.fromDefinition(ConstantSourceDefinition<T> definition)
    : value = definition.value,
      super(method: SourceMethod.constant);

  @override
  T get({SourceMap? sourceMap}) => value;

  @override
  ConstantSource<T> copy() => ConstantSource<T>(value: value);
}

class VariableSource<T> extends Source {
  T value;

  VariableSource({required this.value}) : super(method: SourceMethod.variable);

  VariableSource.fromDefinition(VariableSourceDefinition<T> definition)
    : value = definition.defaultValue,
      super(method: SourceMethod.variable) {
    print('Creating VariableSource with default: $definition.defaultValue');
  }

  @override
  T get({SourceMap? sourceMap}) => value;

  @override
  VariableSource<T> copy() => VariableSource<T>(value: value);

  void setValue(T newValue) {
    value = newValue;
  }
}

class FunctionSource extends Source {
  final Formula formula;
  final FunctionSourceDefinition definition;

  FunctionSource({required this.formula, required this.definition})
    : super(method: SourceMethod.function);

  FunctionSource.fromDefinition(this.definition) : 
    formula = Formula.fromDefinition(definition),
    super(method: SourceMethod.function);

  @override
  dynamic get({SourceMap? sourceMap}) {
    print('FunctionSource.get for ${definition.formulaKey}: ${definition.parameterMap} -> ${sourceMap != null ? formula.evaluate(sourceMap) : 'null'}');
    if (sourceMap == null) {
      throw Exception('FunctionSource.get requires a SourceMap input');
    }
    return formula.evaluate(sourceMap);
  }

  @override
  FunctionSource copy() => FunctionSource(formula: formula, definition: definition);
}

class SourceMap {
  final Map<String, Source> sources;

  SourceMap(this.sources);
  SourceMap.empty() : sources = {};
  SourceMap.fromDefinitions(SourceDefinitionMap definitions) : 
    sources = definitions.sources.map((key, definition) {
      return MapEntry(key, Source.fromDefinition(definition));
  });

  factory SourceMap.clone(SourceMap original) {
    Map<String, Source> clonedSources = {};
    original.forEach((key, source) {
      clonedSources[key] = source.copy();
    });
    return SourceMap(clonedSources);
  }

  Source? operator [](String key) => sources[key];

  void operator []=(String key, Source value) {
    sources[key] = value;
  }

  dynamic getValue(String key) {
    return sources[key]!.get(sourceMap: this);
  }

  void forEach(void Function(String key, Source value) f) {
    sources.forEach(f);
  }
}
