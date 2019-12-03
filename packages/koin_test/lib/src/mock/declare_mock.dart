/*
 * Copyright 2017-2018 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:koin/koin.dart';

/**
 * Declare & Create a mock in Koin container for given type
 *
 * @author Arnaud Giuliani
 */
/*
 T declareMock<T>(
        Qualifier qualifier,
        T stubbing
) {
    var koin = GlobalContext.instance.get().koin;
    Type type = T;
    BeanDefinition<T> foundDefinition   = getDefinition(type, koin, qualifier);

    koin.declareMockedDefinition(foundDefinition, stubbing)

    //return koin.get<T>();
}

// TODO declaremock on Scopes

@Suppress("UNCHECKED_CAST")
inline fun <reified T : Any> getDefinition(
        clazz: KClass<T>,
        koin: Koin,
        qualifier: Qualifier?
): BeanDefinition<T> {
    logger.info("declare mock for '${clazz.getFullName()}'")

    return koin.rootScope.beanRegistry.findDefinition(qualifier, clazz) as BeanDefinition<T>?
            ?: throw NoBeanDefFoundException("No definition found for qualifier='$qualifier' & class='$clazz'")
}

/**
 * Declare & Create a mock in Koin container for given type
 *
 * @author Arnaud Giuliani
 */
inline fun <reified T : Any> Koin.declareMock(
        qualifier: Qualifier? = null,
        noinline stubbing: (T.() -> Unit)? = null
): T {

    val clazz = T::class
    val foundDefinition: BeanDefinition<T> = getDefinition(clazz, this, qualifier)

    declareMockedDefinition(foundDefinition, stubbing)

    return get(qualifier)
}

inline fun <reified T : Any> Koin.declareMockedDefinition(
        foundDefinition: BeanDefinition<T>,
        noinline stubbing: (T.() -> Unit)?
) {
    val definition: BeanDefinition<T> = foundDefinition.createMockedDefinition(stubbing)
    rootScope.beanRegistry.saveDefinition(definition)
}

inline fun <reified T : Any> BeanDefinition<T>.createMockedDefinition(noinline stubbing: (T.() -> Unit)? = null): BeanDefinition<T> {
    val copy = BeanDefinition<T>(qualifier, scopeName, primaryType)
    copy.secondaryTypes = this.secondaryTypes
    copy.definition = {
        val (instance: T, time: Double) = measureDuration {
            mock(T::class.java)
        }
        logger.debug("| mock created in $time ms")
        stubbing?.let { instance.apply(stubbing) }
        instance
    }
    copy.properties = this.properties.copy()
    copy.options = this.options.copy()
    copy.options.override = true
    copy.kind = this.kind
    copy.createInstanceHolder()
    return copy
}
*/
