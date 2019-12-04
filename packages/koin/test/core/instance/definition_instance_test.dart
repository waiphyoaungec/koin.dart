import 'package:koin/src/core/definition/bean_definition.dart';
import 'package:koin/src/core/definition_parameters.dart';
import 'package:koin/src/core/instance/definition_instance.dart';
import 'package:koin/src/core/instance/factory_definition_instance.dart';
import 'package:koin/src/core/instance/scope_definition_instance.dart';
import 'package:koin/src/core/instance/singleton_definition_instance.dart';
import 'package:koin/src/core/qualifier.dart';
import 'package:koin/src/core/scope.dart';
import 'package:koin/src/koin_dart.dart';
import 'package:test/test.dart';

class Service {}

class ServiceParameters {
  final String name;
  final int year;

  ServiceParameters(this.name, this.year);
}

class Definition {}

var qualifierDefinition = qualifier(Definition);
var qualifierDefinitionTest = named("Definition");
var qualifierScope = qualifier(Definition);

void main() {
  test("get FactoryDefinitionInstance ", () {
    var context = InstanceContext(
        koin: Koin(), scope: Scope(), parameters: parametersOf([]));

    BeanDefinition<Service> beanDefinitionSingle = BeanDefinition.createFactory(
        qualifierDefinition, qualifierScope, (s, p) => Service());
    var factoryInstance = FactoryDefinitionInstance(beanDefinitionSingle);

    expect(false, factoryInstance.isCreated(context));
    var result1 = factoryInstance.get(context);
    var result2 = factoryInstance.get(context);

    expect(result1, isNotNull);
    expect(result1, isA<Service>());
    expect(true, result1 != result2);
    expect(false, factoryInstance.isCreated(context));
  });

  test("get FactoryDefinitionInstance with parameters ", () {
    var context = InstanceContext(
        koin: Koin(), scope: Scope(), parameters: parametersOf(["Juca", 22]));

    BeanDefinition<ServiceParameters> beanDefinitionSingle =
        BeanDefinition.createFactory(qualifierDefinition, qualifierScope,
            (s, p) => ServiceParameters(p.component1(), p.component2()));
    var factoryInstance = FactoryDefinitionInstance(beanDefinitionSingle);

    var result1 = factoryInstance.get(context);
    var result2 = factoryInstance.get(context);

    expect(result1, isNotNull);
    expect(result1, isA<ServiceParameters>());
    expect(true, result1 != result2);

    expect(result1.name, "Juca");
    expect(result1.year, 22);
  });

  test("get SingleDefinitionInstance ", () {
    var context = InstanceContext(
        koin: Koin(), scope: Scope(), parameters: parametersOf([]));
    BeanDefinition<Service> beanDefinitionSingle = BeanDefinition.createSingle(
        qualifierDefinition, qualifierScope, (s, p) => Service());
    var factoryInstance = SingleDefinitionInstance(beanDefinitionSingle);

    expect(false, factoryInstance.isCreated(context));
    var result1 = factoryInstance.get(context);
    var result2 = factoryInstance.get(context);

    expect(result1, isNotNull);
    expect(result1, isA<Service>());
    expect(true, result1 == result2);
    expect(true, factoryInstance.isCreated(context));
  });
  /*
  test("get ScopeDefinitionInstance ", () {
    var context = InstanceContext(koin: Koin(), scope: Scope());
    BeanDefinition<Service> beanDefinitionScope = BeanDefinition.createScoped(
        qualifierDefinition, qualifierScope, (s, p) => Service());

    var factoryInstance = ScopeDefinitionInstance(beanDefinitionScope);

    expect(false, factoryInstance.isCreated(InstanceContext()));
    var result1 = factoryInstance.get(InstanceContext(
        koin: Koin(), scope: Scope(), parameters: parametersOf([])));
    var result2 = factoryInstance.get(InstanceContext(
        koin: Koin(), scope: Scope(), parameters: parametersOf([])));

    expect(result1, isNotNull);
    expect(result1, isA<Service>());
    expect(true, result1 == result2);
    expect(true, factoryInstance.isCreated(context));
  });*/
}