import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:koin/koin.dart';
import 'package:koin/src/koin_dart.dart';
import 'package:koin/src/core/definition_parameters.dart';
import 'package:koin_and_bloc/scope_builder.dart';
import 'package:koin_and_bloc/scope_provider.dart';

class FModule extends Module {
  BeanDefinition<T> bloc<T extends Bloc>(
    Definition<T> definition, {
    Qualifier qualifier,
    bool createdAtStart = false,
    bool override = false,
  }) {
    BeanDefinition<T> beanDefinition =
        BeanDefinition<T>.createSingle(qualifier, null, definition);
    declareDefinition(beanDefinition,
        Options(isCreatedAtStart: createdAtStart, override: override));

    beanDefinition.onClose((bloc) => bloc.close());
    return beanDefinition;
  }
}

// Todo
// Possibilida a injeção de bloc
// Criar um bloc passando um contexto, e somente permitir o acesso a quem for do mesmo contexto.

mixin ScopedComponent<St extends StatefulWidget> on State<St>
    implements KoinComponent {
  Qualifier _scopeName;
  String id;

  Qualifier get scopeName => _scopeName;
  Scope get currentScope => getScope;

  ///
  /// Get instance instance from Koin
  /// @param qualifier
  /// @param parameters
  ///
  T get<T>(Qualifier qualifier, DefinitionParameters parameters) =>
      getKoin().get(qualifier, parameters);

  ///
  /// Lazy inject instance from Koin
  /// @param qualifier
  /// @param parameters
  ///
  T inject<T>({Qualifier qualifier, List<Object> parameters}) =>
      getKoin().inject(qualifier, parametersOf(parameters));

  ///
  /// Get instance instance from Koin by Primary Type P, as secondary type S
  /// @param parameters
  ///
  S bind<S, P>(Qualifier qualifier, DefinitionParameters parameters) =>
      getKoin().bind<S, P>(parameters);

  Scope get getScope {
    return getKoin().getScope(id);
  }

  @override
  Koin getKoin() {
    return GlobalContext.instance.get().koin;
  }

  @override
  void initState() {
    _scopeName = StringQualifier(this.widget.runtimeType.toString());
    id = "${this.widget.hashCode.toString()}@${scopeName.toString()}";
    getKoin().createScope(id, scopeName);
    super.initState();
  }

  @override
  void dispose() {
    getKoin().deleteScope(id);
    super.dispose();
  }
}

mixin Injector on Widget {
  ///
  /// Inject instance from Koin
  /// @param qualifier
  /// @param parameters
  ///
  ///

  T inject<T>(BuildContext context,
      [Qualifier qualifier, List<Object> parameters]) {
    var scopeBuilder = ScopeProvider.of<ScopeBuilder>(context);

    if (parameters != null) {
      return scopeBuilder.get(qualifier, parametersOf(parameters));
    } else {
      return scopeBuilder.get(qualifier, null);
    }
  }
}